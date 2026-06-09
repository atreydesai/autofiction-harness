#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_DIR="$PROJECT_ROOT/output"
CHAPTER_DIR="$OUTPUT_DIR/chapters"
REPORT_DIR="$OUTPUT_DIR/critiques/codex/mechanical"
REPORT_FILE="$REPORT_DIR/quality_gate_report.md"
ALLOWLIST_FILE="$OUTPUT_DIR/quality_gate_allowlist.txt"

mkdir -p "$REPORT_DIR"

failures=0
hit_count=0

{
  printf "# Mechanical Quality Gate Report\n\n"
  printf "Allowlist format: \`relative/path.md|pattern-label|line-number\`\n\n"
  printf "| file | line | pattern | status | evidence |\n"
  printf "|---|---:|---|---|---|\n"
} > "$REPORT_FILE"

escape_cell() {
  printf "%s" "$1" | sed 's/|/\\|/g'
}

normalize_quotes_file() {
  local input="$1"
  local output="$2"

  perl -pe 's/\xE2\x80[\x9C\x9D]/"/g; s/\xE2\x80[\x98\x99]/'\''/g' "$input" > "$output"
}

record_hit() {
  local file="$1"
  local pattern="$2"
  local line="$3"
  local evidence="$4"
  local rel_file
  local key
  local status

  rel_file="${file#$PROJECT_ROOT/}"
  key="$rel_file|$pattern|$line"
  if [ -f "$ALLOWLIST_FILE" ] && grep -Fqx "$key" "$ALLOWLIST_FILE"; then
    status="ALLOWLISTED"
  else
    status="OPEN"
    failures=$((failures + 1))
  fi
  hit_count=$((hit_count + 1))

  printf "| \`%s\` | %s | %s | %s | %s |\n" \
    "$(escape_cell "$rel_file")" \
    "$line" \
    "$(escape_cell "$pattern")" \
    "$status" \
    "$(escape_cell "$evidence")" >> "$REPORT_FILE"
}

run_grep() {
  local report_file="$1"
  local scan_file="$2"
  local pattern_label="$3"
  local grep_flags="$4"
  local regex="$5"
  local line
  local evidence

  while IFS=: read -r line evidence; do
    [ -n "${line:-}" ] || continue
    record_hit "$report_file" "$pattern_label" "$line" "$evidence"
  done < <(grep $grep_flags "$regex" "$scan_file" || true)
}

if [ ! -d "$CHAPTER_DIR" ]; then
  printf "\nNo chapter directory found at \`output/chapters\`.\n" >> "$REPORT_FILE"
  echo "[quality_gate] OK no_chapters report=$REPORT_FILE"
  exit 0
fi

shopt -s nullglob
chapter_files=("$CHAPTER_DIR"/chapter_*.md)
if [ "${#chapter_files[@]}" -eq 0 ]; then
  printf "\nNo chapter files found under \`output/chapters\`.\n" >> "$REPORT_FILE"
  echo "[quality_gate] OK no_chapters report=$REPORT_FILE"
  exit 0
fi

for f in "${chapter_files[@]}"; do
  scan_f="$(mktemp)"
  normalize_quotes_file "$f" "$scan_f"

  run_grep "$f" "$scan_f" "process-leakage-marker" "-iEn" '(\[[[:space:]]*(TODO|TK|FIXME|NOTE)[^]]*\]|\b(TODO|TK|FIXME|PLACEHOLDER|DRAFT NOTE|REVISION NOTE|INSERT SCENE|ADD DETAIL|AS AN AI|LANGUAGE MODEL)\b|<!--)'
  run_grep "$f" "$scan_f" "clean-menace-metaphor" "-iEn" '\bclean (knife|cut|wound|blade|violence|kill|death|break)\b'
  run_grep "$f" "$scan_f" "not-x-but-y-scaffold" "-iEn" '(^|\. |\? |! )(It|This|That|The point|The problem|The truth|The danger|He|She|They) (was|were|is|are|felt|looked|seemed) not [^.!?]{1,80},? but\b'
  run_grep "$f" "$scan_f" "not-x-semicolon-y-scaffold" "-iEn" '(^|\. |\? |! )[^.!?]*\b(it |this |that |he |she |they )?(was|were) not [^.!?;]*;[[:space:]]*(it |this |that |he |she |they )?(was|were)\b'
  run_grep "$f" "$scan_f" "the-way-stock-explanation" "-iEn" '\bthe way (he|she|they|it) (always |still |just |used to |would )?(did|does|looked|moved|sounded|felt) when\b|\bthe way (his|her|their) (mouth|voice|face|eyes|hands|body) (moved|looked|sounded|went|did) when\b'
  run_grep "$f" "$scan_f" "uncontracted-casual-dialogue" "-iEn" '"[^"]*\b(do not|does not|did not|cannot|could not|would not|will not|should not|have not|has not|is not|are not|was not|were not|I am|you are|he is|she is|they are|we are|it is)\b[^"]*"'
  run_grep "$f" "$scan_f" "narrator-admiration-tell" "-iEn" '\b(the word|the line|the name|the question|the answer|the silence|the pause) (landed|hung|stretched|settled|hit|thickened|grew heavy|lingered)\b'
  run_grep "$f" "$scan_f" "silence-pause-cliche" "-iEn" '\b(silence|pause|quiet|stillness) (stretched|hung|settled|thickened|grew heavy|lingered)\b'
  run_grep "$f" "$scan_f" "em-dash-apposition-workshop" "-En" '^[A-Z][a-z]{3,20}\.? — [a-z][^.!?]{0,120}\.$'

  rm -f "$scan_f"
done

{
  printf "\nTotal hits: %s\n" "$hit_count"
  printf "Open hits: %s\n" "$failures"
} >> "$REPORT_FILE"

if [ "$failures" -gt 0 ]; then
  echo "[quality_gate] FAIL open_hits=$failures report=$REPORT_FILE"
  exit 2
fi

echo "[quality_gate] PASS hits=$hit_count report=$REPORT_FILE"
