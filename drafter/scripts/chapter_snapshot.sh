#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_DIR="${OUTPUT_DIR:-$PROJECT_ROOT/output}"
SNAPSHOT_DIR="$OUTPUT_DIR/revision_snapshots"
STATE_DIR="$SNAPSHOT_DIR/.state"
MANIFEST="$SNAPSHOT_DIR/manifest.tsv"

usage() {
  cat >&2 <<'USAGE'
Usage:
  scripts/chapter_snapshot.sh --chapter NN --label LABEL [--force]
  scripts/chapter_snapshot.sh --watch [--interval SECONDS]

Copies output/chapters/chapter_NN.md into output/revision_snapshots/chapter_NN/
whenever the prose changes, and appends metadata to output/revision_snapshots/manifest.tsv.
USAGE
}

die() {
  echo "chapter_snapshot: $*" >&2
  exit 2
}

hash_file() {
  local file="$1"
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$file" | awk '{print $1}'
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$file" | awk '{print $1}'
  else
    cksum "$file" | awk '{print $1}'
  fi
}

sanitize_label() {
  printf "%s" "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9._-]+/_/g; s/^_+//; s/_+$//'
}

chapter_file_for() {
  local chapter="$1"
  if [[ "$chapter" =~ ^[0-9][0-9]$ ]]; then
    printf "%s/chapters/chapter_%s.md" "$OUTPUT_DIR" "$chapter"
  elif [[ "$chapter" =~ ^[0-9]+$ ]]; then
    printf "%s/chapters/chapter_%02d.md" "$OUTPUT_DIR" "$((10#$chapter))"
  else
    die "--chapter must be a number, got: $chapter"
  fi
}

chapter_id_from_path() {
  local file="$1"
  basename "$file" .md | sed -E 's/^chapter_//'
}

next_sequence() {
  local chapter_dir="$1"
  local latest
  latest="$(find "$chapter_dir" -maxdepth 1 -type f -name '*.md' 2>/dev/null \
    | sed -E 's/.*\.([0-9]{4})\..*/\1/' \
    | grep -E '^[0-9]{4}$' \
    | sort -n \
    | tail -n 1 || true)"
  if [ -z "$latest" ]; then
    printf "0001"
  else
    printf "%04d" "$((10#$latest + 1))"
  fi
}

ensure_manifest() {
  mkdir -p "$SNAPSHOT_DIR" "$STATE_DIR"
  if [ ! -f "$MANIFEST" ]; then
    printf "timestamp_utc\tchapter\tsequence\tlabel\tsha256\twords\tpath\n" > "$MANIFEST"
  fi
}

snapshot_file() {
  local file="$1"
  local label="${2:-auto}"
  local force="${3:-0}"

  [ -s "$file" ] || return 0
  ensure_manifest

  local chapter chapter_dir state_file current_hash previous_hash sequence timestamp safe_label dest words rel_dest
  chapter="$(chapter_id_from_path "$file")"
  chapter_dir="$SNAPSHOT_DIR/chapter_$chapter"
  mkdir -p "$chapter_dir"
  safe_label="$(sanitize_label "$label")"
  [ -n "$safe_label" ] || safe_label="auto"

  current_hash="$(hash_file "$file")"
  state_file="$STATE_DIR/chapter_$chapter.sha256"
  previous_hash="$(cat "$state_file" 2>/dev/null || true)"

  if [ "$force" != "1" ] && [ "$safe_label" = "auto" ] && [ "$current_hash" = "$previous_hash" ]; then
    return 0
  fi

  sequence="$(next_sequence "$chapter_dir")"
  timestamp="$(date -u +%Y%m%dT%H%M%SZ)"

  dest="$chapter_dir/chapter_$chapter.$sequence.$timestamp.$safe_label.md"
  cp -p "$file" "$dest"
  printf "%s\n" "$current_hash" > "$state_file"

  words="$(wc -w < "$dest" | tr -d '[:space:]')"
  rel_dest="${dest#"$OUTPUT_DIR"/}"
  printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n" \
    "$timestamp" "$chapter" "$sequence" "$safe_label" "$current_hash" "$words" "$rel_dest" >> "$MANIFEST"
  echo "chapter_snapshot: saved $rel_dest words=$words"
}

watch_loop() {
  local interval="$1"
  mkdir -p "$OUTPUT_DIR/chapters"
  echo "chapter_snapshot: watch_start output_dir=$OUTPUT_DIR interval=${interval}s"
  while true; do
    while IFS= read -r -d '' file; do
      snapshot_file "$file" "auto" "0"
    done < <(find "$OUTPUT_DIR/chapters" -maxdepth 1 -type f -name 'chapter_*.md' -print0 2>/dev/null)
    sleep "$interval"
  done
}

mode="snapshot"
chapter=""
label="manual"
interval="${CHAPTER_SNAPSHOT_INTERVAL_SECONDS:-5}"
force="0"

while [ "$#" -gt 0 ]; do
  case "$1" in
    --chapter)
      [ "$#" -ge 2 ] || die "--chapter requires a value"
      chapter="$2"
      shift 2
      ;;
    --label)
      [ "$#" -ge 2 ] || die "--label requires a value"
      label="$2"
      shift 2
      ;;
    --force)
      force="1"
      shift
      ;;
    --watch)
      mode="watch"
      shift
      ;;
    --interval)
      [ "$#" -ge 2 ] || die "--interval requires a value"
      interval="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "unknown argument: $1"
      ;;
  esac
done

case "$mode" in
  watch)
    [[ "$interval" =~ ^[0-9]+$ ]] || die "--interval must be an integer"
    watch_loop "$interval"
    ;;
  snapshot)
    [ -n "$chapter" ] || die "missing --chapter"
    snapshot_file "$(chapter_file_for "$chapter")" "$label" "$force"
    ;;
esac
