#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat >&2 <<'USAGE'
Usage:
  scripts/claude_logged_call.sh --kind KIND [--chapter XX] [--scene NN] \
    --prompt-file PATH --out PATH [--md-out PATH]

Examples:
  scripts/claude_logged_call.sh \
    --kind chapter_rewrite --chapter 14 \
    --prompt-file output_edit/model_prompts/claude/chapter_rewrite/chapter_14.md \
    --out output_edit/drafts/claude/chapter_14.round_01.stream.jsonl \
    --md-out output_edit/drafts/claude/chapter_14.round_01.md

  scripts/claude_logged_call.sh \
    --kind cold_read --chapter global \
    --prompt-file output_edit/model_prompts/claude/cold_read/phase_1b.md \
    --out output_edit/diagnosis/cold_read.stream.jsonl \
    --md-out output_edit/diagnosis/cold_read.md

The wrapper logs every Claude attempt, prevents accidental output overwrites,
saves the exact prompt for provenance, captures the raw stream JSONL output,
optionally extracts a readable Markdown artifact, appends a record to the call
ledger, and serializes Claude calls by default.

This editor run does NOT enforce hard call budgets. Iteration discipline lives
in the task spec. The wrapper's job is provenance and serialization, not
budget enforcement.
USAGE
}

die() {
  echo "claude_logged_call: $*" >&2
  exit 2
}

iso_now() {
  date -u +"%Y-%m-%dT%H:%M:%SZ"
}

is_positive_int() {
  case "${1:-}" in
    ''|*[!0-9]*) return 1 ;;
    *) [ "$1" -gt 0 ] ;;
  esac
}

kind=""
chapter=""
scene="-"
prompt_file=""
out=""
md_out=""

while [ "$#" -gt 0 ]; do
  case "$1" in
    --kind)
      [ "$#" -ge 2 ] || die "--kind requires a value"
      kind="$2"
      shift 2
      ;;
    --chapter)
      [ "$#" -ge 2 ] || die "--chapter requires a value"
      chapter="$2"
      shift 2
      ;;
    --scene)
      [ "$#" -ge 2 ] || die "--scene requires a value"
      scene="$2"
      shift 2
      ;;
    --prompt-file)
      [ "$#" -ge 2 ] || die "--prompt-file requires a value"
      prompt_file="$2"
      shift 2
      ;;
    --out)
      [ "$#" -ge 2 ] || die "--out requires a value"
      out="$2"
      shift 2
      ;;
    --md-out)
      [ "$#" -ge 2 ] || die "--md-out requires a value"
      md_out="$2"
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

[ -n "$kind" ] || die "missing --kind"
[ -n "$prompt_file" ] || die "missing --prompt-file"
[ -n "$out" ] || die "missing --out"
[ -s "$prompt_file" ] || die "prompt file is missing or empty: $prompt_file"
[ ! -e "$out" ] || die "refusing to overwrite existing output: $out"

# Default chapter to "global" for whole-book / cross-chapter calls
[ -n "$chapter" ] || chapter="global"

case "$out" in
  output_edit/*.stream.jsonl) ;;
  *) die "--out must be an output_edit/*.stream.jsonl path" ;;
esac

if [ -n "$md_out" ]; then
  case "$md_out" in
    output_edit/*.md) ;;
    *) die "--md-out must be an output_edit/*.md path" ;;
  esac
  [ ! -e "$md_out" ] || die "refusing to overwrite existing markdown output: $md_out"
  command -v python3 >/dev/null 2>&1 || die "python3 is required when --md-out is supplied"
fi

CLAUDE_BIN="${CLAUDE_BIN:-claude}"
CLAUDE_MODEL="${CLAUDE_MODEL:-claude-fable-5}"
CLAUDE_EFFORT="${CLAUDE_EFFORT:-xhigh}"
CLAUDE_TOOLS="${CLAUDE_TOOLS:-Read,Bash,Grep,Glob}"
CLAUDE_DISALLOWED_TOOLS="${CLAUDE_DISALLOWED_TOOLS:-Agent,Task,TaskCreate,TaskGet,TaskList,TaskStop,TaskUpdate,TaskOutput,ToolSearch}"

CLAUDE_MAX_PARALLEL="${CLAUDE_MAX_PARALLEL:-1}"

is_positive_int "$CLAUDE_MAX_PARALLEL" || die "CLAUDE_MAX_PARALLEL must be a positive integer"

log_path="${CLAUDE_GUARD_LOG:-output_edit/logs/claude_calls.tsv}"
lock_root="${CLAUDE_GUARD_LOCK_ROOT:-output_edit/.claude_guard}"
slots_dir="$lock_root/slots"
mutex_dir="$lock_root/mutex.lock"

mkdir -p "$(dirname "$log_path")" "$slots_dir" "$(dirname "$out")"
if [ -n "$md_out" ]; then
  mkdir -p "$(dirname "$md_out")"
fi
md_log_path="${md_out:-"-"}"

mutex_held=0
acquire_mutex() {
  while ! mkdir "$mutex_dir" 2>/dev/null; do
    if [ -f "$mutex_dir/pid" ]; then
      old_pid="$(cat "$mutex_dir/pid" 2>/dev/null || true)"
      if [ -n "$old_pid" ] && ! kill -0 "$old_pid" 2>/dev/null; then
        rm -rf "$mutex_dir"
        continue
      fi
    fi
    sleep 1
  done
  echo "$$" > "$mutex_dir/pid"
  mutex_held=1
}

release_mutex() {
  if [ "${mutex_held:-0}" -eq 1 ]; then
    rm -rf "$mutex_dir"
    mutex_held=0
  fi
}

slot_path=""
acquire_slot() {
  while true; do
    i=1
    while [ "$i" -le "$CLAUDE_MAX_PARALLEL" ]; do
      candidate="$slots_dir/$i.lock"
      if mkdir "$candidate" 2>/dev/null; then
        echo "$$" > "$candidate/pid"
        slot_path="$candidate"
        return 0
      fi
      if [ -f "$candidate/pid" ]; then
        old_pid="$(cat "$candidate/pid" 2>/dev/null || true)"
        if [ -n "$old_pid" ] && ! kill -0 "$old_pid" 2>/dev/null; then
          rm -rf "$candidate"
        fi
      fi
      i=$((i + 1))
    done
    sleep 5
  done
}

release_slot() {
  if [ -n "${slot_path:-}" ]; then
    rm -rf "$slot_path"
  fi
}

append_log() {
  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' "$@" >> "$log_path"
}

trap 'release_mutex; release_slot' EXIT

acquire_slot
acquire_mutex
start_iso="$(iso_now)"
start_epoch="$(date +%s)"
append_log "$start_iso" "START" "$$" "$kind" "$chapter" "$scene" "$prompt_file" "$out" "$md_log_path" "$CLAUDE_MODEL" "$CLAUDE_EFFORT" "-" "-"
release_mutex

set +e
"$CLAUDE_BIN" -p \
  --model "$CLAUDE_MODEL" \
  --effort "$CLAUDE_EFFORT" \
  --tools "$CLAUDE_TOOLS" \
  --disallowedTools "$CLAUDE_DISALLOWED_TOOLS" \
  --input-format text \
  --output-format stream-json \
  --verbose \
  --no-session-persistence \
  --dangerously-skip-permissions < "$prompt_file" > "$out"
exit_code="$?"
set -e

if [ "$exit_code" -eq 0 ] && [ -n "$md_out" ]; then
  set +e
  python3 - "$out" "$md_out" <<'PY'
import json
import sys
from pathlib import Path

stream_path = Path(sys.argv[1])
md_path = Path(sys.argv[2])
assistant_texts = []
result_texts = []
partial_texts = []

with stream_path.open('r', encoding='utf-8') as stream:
    for raw_line in stream:
        line = raw_line.strip()
        if not line:
            continue
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        event_type = event.get('type')
        if event_type == 'assistant':
            message = event.get('message') or {}
            for item in message.get('content') or []:
                if isinstance(item, dict) and item.get('type') == 'text':
                    text = item.get('text')
                    if isinstance(text, str) and text:
                        assistant_texts.append(text)
        elif event_type == 'content_block_delta':
            delta = event.get('delta') or {}
            text = delta.get('text')
            if isinstance(text, str) and text:
                partial_texts.append(text)
        elif event_type == 'result':
            result = event.get('result')
            if isinstance(result, str) and result:
                result_texts.append(result)

if assistant_texts:
    markdown = '\n\n'.join(text.rstrip() for text in assistant_texts if text.strip())
elif result_texts:
    markdown = '\n\n'.join(text.rstrip() for text in result_texts if text.strip())
elif partial_texts:
    markdown = ''.join(partial_texts).rstrip()
else:
    raise SystemExit(f'no assistant text found in {stream_path}')

md_path.parent.mkdir(parents=True, exist_ok=True)
md_path.write_text(markdown.rstrip() + '\n', encoding='utf-8')
PY
  extract_code="$?"
  set -e
  if [ "$extract_code" -ne 0 ]; then
    echo "claude_logged_call: markdown extraction failed rc=$extract_code stream=$out md_out=$md_out" >&2
    exit_code="$extract_code"
  fi
fi

end_iso="$(iso_now)"
end_epoch="$(date +%s)"
duration="$((end_epoch - start_epoch))"

acquire_mutex
append_log "$end_iso" "END" "$$" "$kind" "$chapter" "$scene" "$prompt_file" "$out" "$md_log_path" "$CLAUDE_MODEL" "$CLAUDE_EFFORT" "$exit_code" "$duration"
release_mutex

exit "$exit_code"
