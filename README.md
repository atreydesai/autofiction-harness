# Autofiction Harness — Drafter + Editor

Two-stage autonomous novel pipeline. Both stages use Codex (GPT-5.5 extra-high) as the orchestrator and Claude Fable 5 (xhigh effort) as the independent prose writer / adversarial auditor, and both enforce a shared, source-traceable check system.

## Contents

- **`drafter/`** — Phase 1: generate a complete novel manuscript from a premise. Premise + optional reading guide go in; a full manuscript comes out. ~96-hour autonomous run.
- **`editor/`** — Phase 2: edit a drafted manuscript against a binding editorial standard. Manuscript + premise (+ optional calibration/impressions) go in; revised final manuscript comes out. ~96-hour autonomous run.
- **`checks/`** — the shared check library both stages enforce (see below).
- **`COVERAGE_MATRIX.md`** — every entry of the check sources traced to its implementation (or explicitly merged / cannot-add).
- **`CAVEATS.md`** — the sources' own calibration warnings (safety rails, accumulation principle, over-correction cautions), preserved verbatim; the harness's tier design implements them.

The two stages are independent: run the drafter alone, the editor alone (on any manuscript), or chain them.

## The check system

All checks derive from two sources, item-by-item (traceability in `COVERAGE_MATRIX.md`):

1. `unified_source_collation.md` — a 319-entry collation of 17 sources on AI writing patterns, novel craft, long-context fiction generation, and writing rules (BANNED guide, AI-isms Bible, LLM research reports, craft manuals, practitioner threads).
2. Wikipedia's **Signs of AI writing** (WP:AIWTW) — in-repo copy at `checks/sources/wikipedia_signs_of_ai_writing.md`.

Four layers:

- **Mechanical gate** — `checks/quality_gate.py` + `checks/patterns/*.tsv` (213 pattern rows). Three tiers, per the sources' own calibration guidance: **BANNED** (any hit blocks commit), **CAP** (blocks above a stated threshold per scene/chapter/1k-words), **WATCH** (counted and reported to the judgment audits; never blocks). Curly-quote normalization, scene segmentation, dialogue-vs-narration scoping, code-fence exclusion, allowlist with required defense, and a book-level accumulation report.
- **Judgment audits** — `checks/audits/` (79 templates, one audit per source item) scheduled by `checks/audit_manifest.tsv`: each has an owner (`codex` runs it inline; `claude` runs through the logged wrapper), a tier (`core` = every chapter, `risk` = trigger-fired, `book` = whole manuscript), and a required verdict format with per-criterion quoted evidence. Coverage rule: by final assembly, every chapter × every applicable audit ≥ once.
- **Protocols** — `checks/protocols/` (pre-draft / mid-draft / post-draft revision, required checks, diagnostic questions, editing-stage sequencing, revision discipline, final test, precedence + safety rails), wired into the task prompts.
- **Scaffolds** — `checks/scaffolds/` (master spec, character snapshot/voice card, world bible, NPC goals, timeline, event-ripple tracker, thread ledger, rolling summaries, canon sheet, research dossier, continuity log, style sheet, chapter card, premise development, prompt library) — required workspace artifacts that the audits read.

Generative recommendations from the sources (prose dials, style anchors/exemplars with anti-fixation rules, yes-but/no-and outcome rules, seeds/payoffs, antagonist sheets, meanwhile prompts) are woven into the chapter-packet templates in the task prompts.

## Each subfolder is self-contained

Each stage has its own `README.md`, `launch.sh`, task prompt, and scripts; both reference the shared `checks/` library by relative path (keep the directory layout intact). Read the stage README before running.

## What's NOT included

Premise files, reading guides, reader impressions, calibration artifacts, manuscripts, and run outputs. Drop your own materials into the stage `input`/`premise` directories and run.

## Requirements

- Codex CLI installed and authenticated
- Claude Code CLI installed and authenticated (`claude` on PATH)
- python3 (used by the quality gate and the Claude wrapper's markdown extraction)
- macOS or Linux shell (zsh / bash); `caffeinate` (macOS) optional
- Git (both stages use git inside their output dirs for rollback)

## Premise-agnostic by construction

The task prompts contain only premise-agnostic process. All book-specific calibration (voice rules, register, motifs and caps, form targets, locked text, book-specific gates, comp authors, high-leverage scenes, optional amplification direction) comes from the premise / reading guide / calibration artifact you supply. The editor's amplification machinery (chaos-up, register-density) only activates when your calibration artifact declares an amplification direction.
