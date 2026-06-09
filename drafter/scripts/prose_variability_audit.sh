#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_DIR="$PROJECT_ROOT/output"
CHAPTER_DIR="$OUTPUT_DIR/chapters"
REPORT_DIR="$OUTPUT_DIR/critiques/codex"
REPORT_FILE="$REPORT_DIR/prose_variability_audit.md"

mkdir -p "$REPORT_DIR"

tmp_metrics="$(mktemp)"
trap 'rm -f "$tmp_metrics"' EXIT

normalize_quotes_file() {
  local input="$1"
  local output="$2"

  perl -pe 's/\xE2\x80[\x9C\x9D]/"/g; s/\xE2\x80[\x98\x99]/'\''/g' "$input" > "$output"
}

printf "chapter\twords\tsentences\tmean_sentence_words\tparagraphs\tmean_paragraph_words\tdialogue_word_ratio\tinteriority_per_1k\n" > "$tmp_metrics"

shopt -s nullglob
chapter_files=("$CHAPTER_DIR"/chapter_*.md)

if [ "${#chapter_files[@]}" -eq 0 ]; then
  {
    printf "# Prose Variability Audit\n\n"
    printf "No chapter files found under \`output/chapters\`.\n"
  } > "$REPORT_FILE"
  echo "[prose_variability_audit] OK no_chapters report=$REPORT_FILE"
  exit 0
fi

for chapter_file in "${chapter_files[@]}"; do
  chapter_name="$(basename "$chapter_file" .md)"
  scan_file="$(mktemp)"
  normalize_quotes_file "$chapter_file" "$scan_file"
  awk -v chapter="$chapter_name" '
    function count_words(s,    parts, n, i, c) {
      n = split(s, parts, /[^[:alnum:]_]+/)
      c = 0
      for (i = 1; i <= n; i++) if (parts[i] != "") c++
      return c
    }
    function flush_para() {
      if (para_words > 0) {
        paragraph_count++
        paragraph_words_total += para_words
        para_words = 0
      }
    }
    function count_mind_terms(s,    c) {
      c = 0
      while (match(s, /(^|[^[:alnum:]_])(thought|knew|remembered|noticed|wanted|feared|felt|wondered|realized|understood|recognized|calculated|imagined|decided|hoped|dreaded|suspected|meant|needed|could not tell|couldn.t tell)([^[:alnum:]_]|$)/)) {
        c++
        s = substr(s, RSTART + RLENGTH - 1)
      }
      return c
    }
    /^[[:space:]]*$/ {
      flush_para()
      next
    }
    {
      raw = $0
      line_words = count_words(raw)
      words += line_words
      para_words += line_words

      sentence_line = raw
      sentence_count += gsub(/[.!?]+/, ".", sentence_line)

      quoted_line = raw
      while (match(quoted_line, /"[^"]+"/)) {
        quoted = substr(quoted_line, RSTART + 1, RLENGTH - 2)
        dialogue_words += count_words(quoted)
        quoted_line = substr(quoted_line, RSTART + RLENGTH)
      }

      lower = tolower(raw)
      interiority_count += count_mind_terms(lower)
    }
    END {
      flush_para()
      if (sentence_count < 1) sentence_count = 1
      if (paragraph_count < 1) paragraph_count = 1
      mean_sentence = words / sentence_count
      mean_paragraph = words / paragraph_count
      dialogue_ratio = words > 0 ? dialogue_words / words : 0
      interiority_density = words > 0 ? interiority_count * 1000 / words : 0
      printf "%s\t%d\t%d\t%.2f\t%d\t%.2f\t%.3f\t%.2f\n", chapter, words, sentence_count, mean_sentence, paragraph_count, mean_paragraph, dialogue_ratio, interiority_density
    }
  ' "$scan_file" >> "$tmp_metrics"
  rm -f "$scan_file"
done

{
  printf "# Prose Variability Audit\n\n"
  printf "This is a blunt cross-chapter rhythm check. Low variance is not automatically bad, but a whole manuscript with uniform sentence length, paragraph scale, dialogue ratio, and interiority density usually reads flattened.\n\n"
  printf "| chapter | words | sentences | mean sentence words | paragraphs | mean paragraph words | dialogue word ratio | interiority / 1k |\n"
  printf "|---|---:|---:|---:|---:|---:|---:|---:|\n"
  awk -F '\t' 'NR > 1 { printf "| `%s` | %s | %s | %s | %s | %s | %s | %s |\n", $1, $2, $3, $4, $5, $6, $7, $8 }' "$tmp_metrics"
  printf "\n## Verdict\n\n"
} > "$REPORT_FILE"

set +e
awk -F '\t' '
  NR == 1 { next }
  {
    n++
    sent_sum += $4
    sent_sq += $4 * $4
    para_sum += $6
    para_sq += $6 * $6
    dialogue_sum += $7
    dialogue_sq += $7 * $7
    interior_sum += $8
    interior_sq += $8 * $8
  }
  END {
    if (n < 4) {
      print "PASS: fewer than four chapters; variability signal is not meaningful yet."
      exit 0
    }
    sent_mean = sent_sum / n
    para_mean = para_sum / n
    dialogue_mean = dialogue_sum / n
    interior_mean = interior_sum / n

    sent_sd = sqrt((sent_sq / n) - (sent_mean * sent_mean))
    para_sd = sqrt((para_sq / n) - (para_mean * para_mean))
    dialogue_sd = sqrt((dialogue_sq / n) - (dialogue_mean * dialogue_mean))
    interior_sd = sqrt((interior_sq / n) - (interior_mean * interior_mean))

    sent_cv = sent_mean > 0 ? sent_sd / sent_mean : 0
    para_cv = para_mean > 0 ? para_sd / para_mean : 0
    interior_cv = interior_mean > 0 ? interior_sd / interior_mean : 0

    printf "sentence_cv=%.3f paragraph_cv=%.3f dialogue_sd=%.3f interiority_cv=%.3f\n", sent_cv, para_cv, dialogue_sd, interior_cv
    if (sent_cv < 0.08 && para_cv < 0.12 && dialogue_sd < 0.06 && interior_cv < 0.15) {
      print "FAIL: chapters are metrically too uniform. Run a pace/register revision against the chapter cards before final assembly."
      exit 2
    }
    print "PASS: cross-chapter rhythm shows enough metric variation for this blunt audit."
    exit 0
  }
' "$tmp_metrics" >> "$REPORT_FILE"
rc=$?
set -e

if [ "$rc" -ne 0 ]; then
  echo "[prose_variability_audit] FAIL report=$REPORT_FILE"
  exit "$rc"
fi

echo "[prose_variability_audit] PASS report=$REPORT_FILE"
