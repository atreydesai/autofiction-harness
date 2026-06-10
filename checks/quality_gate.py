#!/usr/bin/env python3
"""Tiered mechanical quality gate for the autofiction harness.

Loads every pattern registry under checks/patterns/*.tsv and scans chapter
files with three enforcement tiers (see CAVEATS.md for the calibration
philosophy these tiers implement):

  BANNED  - any hit is an OPEN finding and blocks commit (exit 2)
  CAP     - hits are counted per unit (per-scene / per-chapter / per-1k-words
            / book); counts above the threshold are OPEN findings
  WATCH   - hits are counted and reported (watch_counts.json + report table)
            for the judgment audits; they never block

Scopes: narration | dialogue | both | opening | ending | heading | document.
Dialogue is the text inside straight double quotes after curly-quote
normalization; fenced code blocks (chat-format material) are excluded from
scanning entirely, preserving the chat-format gate exclusion as a generic
mechanism. The allowlist uses the legacy key format
`relative/path.md|pattern-id|line` and remains a narrow register-defense
mechanism: every allowlisted hit must be defended on the chapter card or in
style_and_voice.md. Dialogue-scope hits may additionally be defended by a
character voice card that claims the term (Character Voice vs. Ban List rule).

Engine keywords (notes column, `engine:<keyword>`) request structural checks
that a line regex cannot express:
  para-one-sentence | consecutive | per-paragraph | repeated-descriptor |
  title-case-headings | bold-density | inline-header-list |
  thematic-break-before-heading | skipped-heading-level | table-in-prose |
  quote-style-inconsistency | emdash-density (annotation only; merged with the
  regex density row)
"""

import argparse
import csv
import json
import re
import sys
from pathlib import Path

CURLY = {"“": '"', "”": '"', "‘": "'", "’": "'"}
HEADING_RE = re.compile(r"^#{1,6}\s+\S")
HR_RE = re.compile(r"^\s*([-*_]\s*){3,}$")
FENCE_RE = re.compile(r"^\s*(```|~~~)")
QUOTE_SPAN_RE = re.compile(r'"[^"]+"')
SENT_SPLIT_RE = re.compile(r"[.!?]+(?=\s|$)")
WORD_RE = re.compile(r"[A-Za-z'’-]+")
STOPWORDS = set(
    """the a an and or but of to in on at by for with from as is are was were be been
    being it its he she they them his her their i you we not no so that this those
    these then than there here when where who whom what which while into onto out up
    down over under again still just very too also had has have do does did would
    could should will shall may might must if because before after during between
    said say says like one two about all any some more most other such own same""".split()
)


def normalize(text):
    for k, v in CURLY.items():
        text = text.replace(k, v)
    return text


class Pattern:
    def __init__(self, row, source_file):
        self.id = row["id"].strip()
        self.tier = row["tier"].strip()
        self.scope = row["scope"].strip() or "both"
        self.raw_regex = row["regex"].strip()
        self.threshold = int(row["threshold"]) if row.get("threshold", "").strip() else None
        self.unit = row.get("unit", "").strip() or None
        self.action = row.get("action", "").strip()
        self.source_ref = row.get("source_ref", "").strip()
        self.notes = row.get("notes", "").strip()
        self.source_file = source_file
        self.engine = None
        m = re.search(r"engine:([a-z-]+)", self.notes)
        if m:
            self.engine = m.group(1)
        self.regex = None
        if self.raw_regex and self.raw_regex != "__ENGINE__":
            self.regex = re.compile(self.raw_regex, re.IGNORECASE)


def load_patterns(patterns_dir):
    pats = []
    for tsv in sorted(Path(patterns_dir).glob("*.tsv")):
        with open(tsv, newline="", encoding="utf-8") as f:
            for row in csv.DictReader(f, delimiter="\t"):
                if row.get("id"):
                    pats.append(Pattern(row, tsv.name))
    return pats


class Chapter:
    """Parsed chapter: scenes, paragraphs, line classifications."""

    def __init__(self, path, root):
        # resolve so rel (the allowlist key prefix) is stable across invocation
        # styles: glob vs explicit file args, relative paths, symlinks (/tmp)
        self.path = Path(path).resolve()
        self.rel = str(self.path.relative_to(root)) if root in self.path.parents else str(self.path)
        raw = self.path.read_text(encoding="utf-8", errors="replace")
        self.raw_lines = raw.splitlines()
        self.lines = [normalize(l) for l in self.raw_lines]
        self.in_fence = [False] * len(self.lines)
        fence_marks = [i for i, l in enumerate(self.lines) if FENCE_RE.match(l)]
        if len(fence_marks) % 2 == 1:
            # an unpaired fence marker would exempt the whole remainder of the
            # chapter from scanning; treat it as prose, not an open fence
            fence_marks = fence_marks[:-1]
        for k in range(0, len(fence_marks), 2):
            for j in range(fence_marks[k], fence_marks[k + 1] + 1):
                self.in_fence[j] = True  # fence markers themselves excluded
        self.is_heading = [bool(HEADING_RE.match(l)) and not self.in_fence[i] for i, l in enumerate(self.lines)]
        self.is_hr = [bool(HR_RE.match(l)) and not self.in_fence[i] for i, l in enumerate(self.lines)]
        # scene index per line (scenes split on headings / horizontal rules)
        self.scene_of = []
        scene = 0
        started = False
        for i in range(len(self.lines)):
            if self.is_heading[i] or self.is_hr[i]:
                if started:
                    scene += 1
                    started = False
                self.scene_of.append(scene)
                continue
            if self.lines[i].strip():
                started = True
            self.scene_of.append(scene)
        self.n_scenes = scene + 1
        # paragraphs: (start_line, text, scene) for prose lines outside fences
        self.paragraphs = []
        buf, start = [], None
        for i, l in enumerate(self.lines):
            skip = self.in_fence[i] or self.is_heading[i] or self.is_hr[i]
            if l.strip() and not skip:
                if start is None:
                    start = i
                buf.append(l.strip())
            else:
                if buf:
                    self.paragraphs.append((start, " ".join(buf), self.scene_of[start]))
                buf, start = [], None
        if buf:
            self.paragraphs.append((start, " ".join(buf), self.scene_of[start]))
        self.word_count = sum(len(WORD_RE.findall(p[1])) for p in self.paragraphs)

    def line_views(self, i):
        """Return (dialogue_text, narration_text, full_text) for a line."""
        line = self.lines[i]
        # An odd quote count means an unterminated span — standard typography
        # for multi-paragraph speech (continuation paragraphs omit the closing
        # quote). Everything after the unmatched quote is dialogue, not narration.
        head, open_tail = line, None
        quote_positions = [j for j, c in enumerate(line) if c == '"']
        if len(quote_positions) % 2 == 1:
            pos = quote_positions[-1]
            head, open_tail = line[:pos], line[pos + 1:]
        spans = QUOTE_SPAN_RE.findall(head)
        parts = [s[1:-1] for s in spans]
        narration = QUOTE_SPAN_RE.sub(" ⁂ ", head)  # placeholder keeps word boundaries
        if open_tail is not None:
            parts.append(open_tail)
            narration += " ⁂ "
        return " ".join(p for p in parts if p), narration, line

    def scannable(self, i):
        return not self.in_fence[i] and not self.is_hr[i]

    def opening_lines(self):
        # first paragraph of each scene + first two paragraphs of the chapter
        # (scope=opening rules are documented as scene-opening checks)
        first_by_scene = {}
        for idx, (start, text, scene) in enumerate(self.paragraphs):
            first_by_scene.setdefault(scene, idx)
        targets = set(first_by_scene.values())
        targets.update(range(min(2, len(self.paragraphs))))
        return self._para_lines(targets)

    def _para_lines(self, targets):
        out = set()
        for idx in targets:
            start, _, _ = self.paragraphs[idx]
            j = start
            while j < len(self.lines) and self.lines[j].strip():
                if self.scannable(j):
                    out.add(j)
                j += 1
        return out

    def ending_lines(self):
        # last paragraph of each scene + last two paragraphs of the chapter
        last_by_scene = {}
        for idx, (start, text, scene) in enumerate(self.paragraphs):
            last_by_scene[scene] = idx
        targets = set(last_by_scene.values())
        targets.update(range(max(0, len(self.paragraphs) - 2), len(self.paragraphs)))
        return self._para_lines(targets)


class Finding:
    def __init__(self, rel, line, pattern, status, evidence):
        self.rel, self.line, self.pattern, self.status, self.evidence = rel, line, pattern, status, evidence


def esc(s):
    return s.replace("|", "\\|")


def one_sentence_paragraphs(ch):
    out = []
    for start, text, scene in ch.paragraphs:
        if '"' in text:
            continue  # dialogue lines with tags are normal speech, not gravity beats
        sentences = [s for s in SENT_SPLIT_RE.split(text) if s.strip()]
        if len(sentences) == 1 and len(WORD_RE.findall(text)) <= 25:
            out.append((start, text, scene))
    return out


def repeated_descriptors(ch):
    """Tokens repeated 3+ times within one scene (heuristic, WATCH only)."""
    hits = []
    by_scene = {}
    for start, text, scene in ch.paragraphs:
        by_scene.setdefault(scene, []).append(text)
    for scene, texts in by_scene.items():
        counts = {}
        for w in WORD_RE.findall(" ".join(texts)):
            lw = w.lower()
            if len(lw) > 5 and lw not in STOPWORDS and not w[0].isupper():
                counts[lw] = counts.get(lw, 0) + 1
        for w, c in sorted(counts.items()):
            if c >= 3:
                hits.append((scene, f"{w} x{c}"))
    return hits


def run_structure_engine(pat, ch):
    """Wikipedia-style document/structure checks. Returns (count, [(line, evidence)])."""
    ev = []
    if pat.engine == "title-case-headings":
        for i, l in enumerate(ch.lines):
            if ch.is_heading[i]:
                words = [w for w in WORD_RE.findall(l.lstrip("# ")) if w.lower() not in STOPWORDS]
                if len(words) >= 3 and sum(1 for w in words if w[:1].isupper()) >= len(words) - 1:
                    ev.append((i + 1, l.strip()[:120]))
    elif pat.engine == "bold-density":
        for i, l in enumerate(ch.lines):
            if ch.scannable(i):
                for m in re.finditer(r"\*\*[^*]+\*\*", l):
                    ev.append((i + 1, m.group(0)[:80]))
    elif pat.engine == "inline-header-list":
        for i, l in enumerate(ch.lines):
            if ch.scannable(i) and re.match(r"^\s*([-*]\s*)?\*\*[^*]+:?\*\*\s*[:—-]?\s*\S", l):
                ev.append((i + 1, l.strip()[:120]))
    elif pat.engine == "thematic-break-before-heading":
        for i in range(len(ch.lines) - 1):
            nxt = i + 1
            while nxt < len(ch.lines) and not ch.lines[nxt].strip():
                nxt += 1
            if nxt < len(ch.lines) and ch.is_hr[i] and ch.is_heading[nxt]:
                ev.append((i + 1, "thematic break immediately before heading"))
    elif pat.engine == "skipped-heading-level":
        prev = None
        for i, l in enumerate(ch.lines):
            if ch.is_heading[i]:
                lvl = len(l) - len(l.lstrip("#"))
                if prev is not None and lvl > prev + 1:
                    ev.append((i + 1, f"heading level jumps {prev}->{lvl}"))
                prev = lvl
    elif pat.engine == "table-in-prose":
        for i, l in enumerate(ch.lines):
            if ch.scannable(i) and re.match(r"^\s*\|.*\|\s*$", l):
                ev.append((i + 1, l.strip()[:80]))
    elif pat.engine == "quote-style-inconsistency":
        raw = "\n".join(ch.raw_lines)
        curly = sum(raw.count(c) for c in "“”")
        straight = raw.count('"')
        if curly and straight:
            ev.append((0, f"mixed quote styles: {curly} curly vs {straight} straight"))
    elif pat.engine == "para-one-sentence":
        for start, text, scene in one_sentence_paragraphs(ch):
            ev.append((start + 1, text[:100]))
    elif pat.engine == "repeated-descriptor":
        for scene, info in repeated_descriptors(ch):
            ev.append((0, f"scene {scene + 1}: {info}"))
    elif pat.engine == "emdash-density":
        return 0, []  # annotation row; counted by the regex density row
    return len(ev), ev


def regex_hits(pat, ch):
    """Return [(line_number, evidence, scene)] for a regex pattern, honoring scope."""
    if pat.engine == "per-paragraph":
        # evaluate per paragraph instead of per line, still honoring scope:
        # the paragraph text is rebuilt from the scope view of each line so
        # narration-scoped rows do not fire on text inside dialogue quotes
        hits = []
        for start, text, scene in ch.paragraphs:
            if pat.scope in ("dialogue", "narration"):
                parts = []
                j = start
                while j < len(ch.lines) and ch.lines[j].strip():
                    if ch.scannable(j) and not ch.is_heading[j]:
                        dialogue, narration, _ = ch.line_views(j)
                        parts.append(dialogue if pat.scope == "dialogue" else narration)
                    j += 1
                text = " ".join(p for p in parts if p)
            m = pat.regex.search(text)
            if m:
                hits.append((start + 1, m.group(0)[:100].strip(), scene))
        return hits
    hits = []
    opening = ch.opening_lines() if pat.scope == "opening" else None
    ending = ch.ending_lines() if pat.scope == "ending" else None
    for i in range(len(ch.lines)):
        if not ch.scannable(i):
            continue
        if pat.scope == "heading":
            if not ch.is_heading[i]:
                continue
            target = ch.lines[i]
        elif pat.scope == "document":
            target = ch.lines[i]  # whole line, headings included
        elif ch.is_heading[i]:
            continue
        elif pat.scope == "opening":
            if i not in opening:
                continue
            target = ch.lines[i]
        elif pat.scope == "ending":
            if i not in ending:
                continue
            target = ch.lines[i]
        else:
            dialogue, narration, full = ch.line_views(i)
            if pat.scope == "dialogue":
                target = dialogue
            elif pat.scope == "narration":
                target = narration
            else:
                target = full
        if not target:
            continue
        for m in pat.regex.finditer(target):
            hits.append((i + 1, m.group(0)[:100].strip(), ch.scene_of[i]))
    if pat.engine == "consecutive":
        # merge hits on consecutive lines into one finding (runs count once)
        merged, prev_line = [], None
        for line, evd, scene in hits:
            if prev_line is not None and line == prev_line + 1:
                prev_line = line
                continue
            merged.append((line, evd, scene))
            prev_line = line
        hits = merged
    return hits


# engines that fully replace the row's regex (any regex is only a documented
# approximation); 'consecutive'/'per-paragraph' modify regex scanning instead,
# and 'emdash-density' is an annotation merged into its regex density row
STRUCTURE_ENGINES = {
    "para-one-sentence", "repeated-descriptor", "title-case-headings",
    "bold-density", "inline-header-list", "thematic-break-before-heading",
    "skipped-heading-level", "table-in-prose", "quote-style-inconsistency",
}


def evaluate_chapter(ch, patterns, allow):
    findings, watch, book_hits = [], {}, {}
    for pat in patterns:
        if pat.engine in STRUCTURE_ENGINES or (pat.regex is None and (pat.engine or pat.scope == "document")):
            count, ev = run_structure_engine(pat, ch)
            if count and pat.tier == "WATCH":
                watch[pat.id] = watch.get(pat.id, 0) + count
                findings.append(Finding(ch.rel, ev[0][0], pat, "WATCH", f"{count} occurrence(s); first: {ev[0][1]}"))
            elif count and pat.tier == "CAP" and pat.threshold is not None:
                hits = [(line, evd, ch.scene_of[line - 1] if 0 < line <= len(ch.lines) else 0)
                        for line, evd in ev]
                if pat.unit == "book":
                    book_hits[pat.id] = book_hits.get(pat.id, 0) + count
                    findings.append(Finding(ch.rel, hits[0][0], pat, "WATCH",
                                            f"{count} occurrence(s) (book-unit cap; enforced with --book-level)"))
                else:
                    findings.extend(_evaluate_cap(ch, pat, hits, allow))
            elif count and pat.tier == "BANNED":
                for line, evd in ev:
                    findings.append(_status(ch, line, pat, allow, evd))
            continue
        if pat.regex is None:
            continue
        hits = regex_hits(pat, ch)
        if not hits:
            continue
        if pat.tier == "BANNED":
            for line, evd, _ in hits:
                findings.append(_status(ch, line, pat, allow, evd))
        elif pat.tier == "WATCH":
            watch[pat.id] = watch.get(pat.id, 0) + len(hits)
            findings.append(Finding(ch.rel, hits[0][0], pat, "WATCH",
                                    f"{len(hits)} occurrence(s); first: {hits[0][1]}"))
        elif pat.tier == "CAP":
            if pat.unit == "book":
                book_hits[pat.id] = book_hits.get(pat.id, 0) + len(hits)
                findings.append(Finding(ch.rel, hits[0][0], pat, "WATCH",
                                        f"{len(hits)} occurrence(s) (book-unit cap; enforced with --book-level)"))
            else:
                findings.extend(_evaluate_cap(ch, pat, hits, allow))
    return findings, watch, book_hits


def _evaluate_cap(ch, pat, hits, allow):
    out = []
    if pat.unit == "per-scene":
        per = {}
        for line, evd, scene in hits:
            per.setdefault(scene, []).append((line, evd))
        for scene, scene_hits in sorted(per.items()):
            if len(scene_hits) > pat.threshold:
                out.append(_status(ch, scene_hits[0][0], pat, allow,
                                   f"scene {scene + 1}: {len(scene_hits)} > cap {pat.threshold}; first: {scene_hits[0][1]}"))
    elif pat.unit == "per-chapter":
        if len(hits) > pat.threshold:
            out.append(_status(ch, hits[0][0], pat, allow,
                               f"{len(hits)} > cap {pat.threshold}/chapter; first: {hits[0][1]}"))
    elif pat.unit == "per-1k-words":
        rate = len(hits) * 1000.0 / max(ch.word_count, 1)
        if rate > pat.threshold:
            out.append(_status(ch, hits[0][0], pat, allow,
                               f"{len(hits)} hits = {rate:.1f}/1k words > cap {pat.threshold}; first: {hits[0][1]}"))
    return out


def _status(ch, line, pat, allow, evidence):
    key = f"{ch.rel}|{pat.id}|{line}"
    status = "ALLOWLISTED" if key in allow else "OPEN"
    return Finding(ch.rel, line, pat, status, evidence)


def book_report(chapters, all_watch, report_lines):
    report_lines.append("\n## Book-level accumulation report\n")
    report_lines.append("Per the Accumulation Principle: no single element makes prose bad; density does. "
                        "Chapters whose WATCH density is far above the manuscript median deserve a "
                        "judgment-audit pass even when nothing blocks.\n")
    report_lines.append("| chapter | words | banned/cap OPEN | watch hits | watch per 1k words |")
    report_lines.append("|---|---:|---:|---:|---:|")
    rates = []
    for ch, open_n, watch_n in chapters:
        rate = watch_n * 1000.0 / max(ch.word_count, 1)
        rates.append(rate)
        report_lines.append(f"| `{ch.rel}` | {ch.word_count} | {open_n} | {watch_n} | {rate:.1f} |")
    if rates:
        med = sorted(rates)[len(rates) // 2]
        report_lines.append(f"\nMedian WATCH density: {med:.1f}/1k words. "
                            f"Chapters above {2 * med:.1f} (2x median) should be queued for prose audits.")
    top = sorted(all_watch.items(), key=lambda kv: -kv[1])[:25]
    if top:
        report_lines.append("\n### Top WATCH patterns across the manuscript\n")
        report_lines.append("| pattern | total hits |")
        report_lines.append("|---|---:|")
        for pid, n in top:
            report_lines.append(f"| `{pid}` | {n} |")


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--output-dir", required=True, help="stage output dir (drafter: output/, editor: output_edit/)")
    ap.add_argument("--chapters-dir", default=None, help="default: <output-dir>/chapters")
    ap.add_argument("--patterns-dir", action="append", default=None,
                    help="pattern registry dir; repeatable — extra dirs EXTEND the registry "
                         "(default: <this file's dir>/patterns)")
    ap.add_argument("--report", default=None, help="markdown report path")
    ap.add_argument("--json-out", default=None, help="JSON summary path")
    ap.add_argument("--allowlist", default=None, help="default: <output-dir>/quality_gate_allowlist.txt")
    ap.add_argument("--book-level", action="store_true", help="add cross-chapter accumulation report")
    ap.add_argument("files", nargs="*", help="explicit chapter files (default: chapters-dir/chapter_*.md)")
    args = ap.parse_args()

    out_dir = Path(args.output_dir).resolve()
    root = out_dir.parent
    chapters_dir = Path(args.chapters_dir) if args.chapters_dir else out_dir / "chapters"
    default_patterns = Path(__file__).resolve().parent / "patterns"
    patterns_dirs, seen_dirs = [], set()
    for d in ([Path(p) for p in args.patterns_dir] if args.patterns_dir else [default_patterns]):
        r = d.resolve()
        if r not in seen_dirs:
            seen_dirs.add(r)
            patterns_dirs.append(d)
    report_path = Path(args.report) if args.report else out_dir / "critiques" / "codex" / "mechanical" / "quality_gate_report.md"
    json_path = Path(args.json_out) if args.json_out else report_path.with_suffix(".json")
    allow_path = Path(args.allowlist) if args.allowlist else out_dir / "quality_gate_allowlist.txt"

    patterns = []
    for d in patterns_dirs:
        patterns.extend(load_patterns(d))
    allow = set()
    if allow_path.is_file():
        allow = {l.strip() for l in allow_path.read_text(encoding="utf-8").splitlines() if l.strip()}

    files = [Path(f) for f in args.files] if args.files else sorted(chapters_dir.glob("chapter_*.md"))
    report_path.parent.mkdir(parents=True, exist_ok=True)

    lines = ["# Mechanical Quality Gate Report", "",
             f"Patterns loaded: {len(patterns)} "
             f"(BANNED {sum(1 for p in patterns if p.tier == 'BANNED')}, "
             f"CAP {sum(1 for p in patterns if p.tier == 'CAP')}, "
             f"WATCH {sum(1 for p in patterns if p.tier == 'WATCH')})", "",
             "Allowlist format: `relative/path.md|pattern-id|line`. Every allowlisted hit must be "
             "defended on the chapter card or in style_and_voice.md (dialogue hits may instead cite "
             "the speaking character's voice card).", "",
             "| file | line | pattern | tier | status | evidence |",
             "|---|---:|---|---|---|---|"]

    if not files:
        lines.append("")
        lines.append("No chapter files found.")
        report_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
        print(f"[quality_gate] OK no_chapters report={report_path}")
        return 0

    open_count = allowlisted = watch_total = 0
    all_watch = {}
    all_book = {}
    per_chapter = []
    json_summary = {"chapters": {}, "open": 0, "allowlisted": 0, "watch": {}}
    for f in files:
        ch = Chapter(f, root)
        findings, watch, book_hits = evaluate_chapter(ch, patterns, allow)
        for k, v in book_hits.items():
            all_book[k] = all_book.get(k, 0) + v
        ch_open = 0
        for fd in sorted(findings, key=lambda x: (x.line, x.pattern.id)):
            if fd.status == "OPEN":
                open_count += 1
                ch_open += 1
            elif fd.status == "ALLOWLISTED":
                allowlisted += 1
            lines.append(f"| `{esc(fd.rel)}` | {fd.line} | {esc(fd.pattern.id)} | {fd.pattern.tier} "
                         f"| {fd.status} | {esc(fd.evidence)} |")
        ch_watch = sum(watch.values())
        watch_total += ch_watch
        for k, v in watch.items():
            all_watch[k] = all_watch.get(k, 0) + v
        per_chapter.append((ch, ch_open, ch_watch))
        json_summary["chapters"][ch.rel] = {"open": ch_open, "watch": watch, "words": ch.word_count}

    if args.book_level:
        # enforce book-unit CAP thresholds across the whole scanned set
        for pat in patterns:
            if pat.tier == "CAP" and pat.unit == "book" and pat.threshold is not None:
                total = all_book.get(pat.id, 0)
                if total > pat.threshold:
                    open_count += 1
                    lines.append(f"| `BOOK` | 0 | {esc(pat.id)} | CAP | OPEN "
                                 f"| book total {total} > cap {pat.threshold} |")

    json_summary["open"] = open_count
    json_summary["allowlisted"] = allowlisted
    json_summary["watch"] = all_watch
    if all_book:
        json_summary["book_caps"] = all_book

    if args.book_level:
        book_report(per_chapter, all_watch, lines)

    lines += ["", f"Open findings: {open_count}", f"Allowlisted: {allowlisted}",
              f"WATCH hits (non-blocking, feed the judgment audits and tics tracker): {watch_total}"]
    report_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    json_path.write_text(json.dumps(json_summary, indent=1), encoding="utf-8")

    if open_count:
        print(f"[quality_gate] FAIL open={open_count} watch={watch_total} report={report_path}")
        return 2
    print(f"[quality_gate] PASS open=0 allowlisted={allowlisted} watch={watch_total} report={report_path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
