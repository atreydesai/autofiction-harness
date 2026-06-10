#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# OUTPUT_DIR is overridable so the editor stage can run this against
# output_edit/ (the audit manifest schedules dialogue_doctor there too)
OUTPUT_DIR="${OUTPUT_DIR:-$PROJECT_ROOT/output}"
OUTPUT_LABEL="$(basename "$OUTPUT_DIR")"
CHAPTER_DIR="$OUTPUT_DIR/chapters"
REPORT_DIR="$OUTPUT_DIR/critiques/codex"
REPORT_FILE="$REPORT_DIR/dialogue_scene_manifest.md"
VERIFY=0

if [ "${1:-}" = "--verify" ]; then
  VERIFY=1
fi

mkdir -p "$REPORT_DIR"

{
  printf "# Dialogue Scene Manifest\n\n"
  printf "Scenes require Dialogue Doctor coverage when they contain at least 4 dialogue lines or 4 quoted utterances. Scene ids are zero-padded and derived from markdown headings or horizontal-rule scene breaks (blank lines and fenced code blocks are ignored, matching quality_gate.py's scene segmentation). Coverage is the per-chapter Doctor file declared by checks/audit_manifest.tsv: {audit_root}/claude/chapter_{NN}.dialogue_doctor.md — one file per chapter covering every required scene.\n\n"
  printf "| chapter | scene | lines | dialogue lines | quoted utterances | doctor required | expected Doctor file | coverage |\n"
  printf "|---|---:|---|---:|---:|---|---|---|\n"
} > "$REPORT_FILE"

missing=0

if [ ! -d "$CHAPTER_DIR" ]; then
  printf "\nNo chapter directory found at \`%s/chapters\`.\n" "$OUTPUT_LABEL" >> "$REPORT_FILE"
  echo "[dialogue_scene_manifest] OK no_chapters report=$REPORT_FILE"
  exit 0
fi

shopt -s nullglob
chapter_files=("$CHAPTER_DIR"/chapter_*.md)
if [ "${#chapter_files[@]}" -eq 0 ]; then
  printf "\nNo chapter files found under \`%s/chapters\`.\n" "$OUTPUT_LABEL" >> "$REPORT_FILE"
  echo "[dialogue_scene_manifest] OK no_chapters report=$REPORT_FILE"
  exit 0
fi

for chapter in "${chapter_files[@]}"; do
  chapter_base="$(basename "$chapter" .md)"
  expected="$OUTPUT_LABEL/critiques/claude/${chapter_base}.dialogue_doctor.md"
  expected_abs="$OUTPUT_DIR/critiques/claude/${chapter_base}.dialogue_doctor.md"
  chapter_counted=0
  scan_file="$(mktemp)"
  perl -pe 's/\xE2\x80[\x9C\x9D]/"/g; s/\xE2\x80[\x98\x99]/'\''/g' "$chapter" > "$scan_file"
  while IFS=$'\t' read -r scene start_line end_line dialogue_lines quote_count; do
    [ -n "${scene:-}" ] || continue
    required="no"
    coverage="not-required"
    if [ "$dialogue_lines" -ge 4 ] || [ "$quote_count" -ge 4 ]; then
      required="yes"
      if [ -f "$expected_abs" ]; then
        coverage="present"
      else
        coverage="missing"
        if [ "$VERIFY" -eq 1 ] && [ "$chapter_counted" -eq 0 ]; then
          missing=$((missing + 1))
          chapter_counted=1
        fi
      fi
    fi
    printf "| \`%s/chapters/%s.md\` | %s | %s-%s | %s | %s | %s | \`%s\` | %s |\n" \
      "$OUTPUT_LABEL" "$chapter_base" "$scene" "$start_line" "$end_line" "$dialogue_lines" "$quote_count" "$required" "$expected" "$coverage" >> "$REPORT_FILE"
  done < <(awk '
    function flush() {
      if (seen) {
        printf "%02d\t%s\t%s\t%s\t%s\n", scene, start, end, dialogue_lines, quote_count
      }
    }
    function count_quotes(line,    tmp, n) {
      tmp = line
      n = gsub(/"[^"]+"/, "&", tmp)
      return n
    }
    BEGIN { scene = 1; start = 1; end = 0; dialogue_lines = 0; quote_count = 0; seen = 0; in_fence = 0 }
    /^[[:space:]]*(```|~~~)/ {
      in_fence = !in_fence
      next
    }
    in_fence { next }
    /^[[:space:]]*$/ { next }
    /^#{1,6}[[:space:]]+/ || /^[[:space:]]*([-*_][[:space:]]*){3,}$/ {
      if (seen) {
        flush()
        scene++
        dialogue_lines = 0
        quote_count = 0
        seen = 0
      }
      start = NR + 1
      next
    }
    {
      seen = 1
      end = NR
      q = count_quotes($0)
      if (q > 0) {
        dialogue_lines++
        quote_count += q
      }
    }
    END { flush() }
  ' "$scan_file")
  rm -f "$scan_file"
done

if [ "$VERIFY" -eq 1 ] && [ "$missing" -gt 0 ]; then
  echo "[dialogue_scene_manifest] FAIL missing_doctor_files=$missing report=$REPORT_FILE"
  exit 2
fi

echo "[dialogue_scene_manifest] OK missing_doctor_files=$missing report=$REPORT_FILE"
