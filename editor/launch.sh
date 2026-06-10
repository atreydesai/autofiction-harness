#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TASK_PROMPT="$PROJECT_ROOT/long_novel_editing.md"
CODEX_BIN="${CODEX_BIN:-/Applications/Codex.app/Contents/Resources/codex}"
CLAUDE_BIN="${CLAUDE_BIN:-claude}"
CLAUDE_SMOKE_SCRIPT="$PROJECT_ROOT/scripts/inner_claude_smoke.sh"
CLAUDE_DISALLOWED_TOOLS="${CLAUDE_DISALLOWED_TOOLS:-Agent,Task,TaskCreate,TaskGet,TaskList,TaskStop,TaskUpdate,TaskOutput,ToolSearch}"
CLAUDE_TOOLS="${CLAUDE_TOOLS:-Read,Bash,Grep,Glob}"
INPUT_DIR="$PROJECT_ROOT/input"
OUTPUT_DIR="$PROJECT_ROOT/output_edit"
LOG_DIR="$OUTPUT_DIR/logs"
LOCK_DIR="$OUTPUT_DIR/.launcher.lock"
DEADLINE_FILE="$OUTPUT_DIR/.deadline_epoch"
RUN_DURATION_SECONDS="${RUN_DURATION_SECONDS:-345600}"
MAX_RESTARTS="${MAX_RESTARTS:-96}"
RESTART_BASE_SLEEP_SECONDS="${RESTART_BASE_SLEEP_SECONDS:-300}"
RESTART_MAX_SLEEP_SECONDS="${RESTART_MAX_SLEEP_SECONDS:-1800}"
SUCCESS_RESTART_SLEEP_SECONDS="${SUCCESS_RESTART_SLEEP_SECONDS:-300}"
PROGRESS_STALL_RESTARTS="${PROGRESS_STALL_RESTARTS:-6}"
SKIP_CODEX_VALIDATION="${SKIP_CODEX_VALIDATION:-0}"
SKIP_CLAUDE_VALIDATION="${SKIP_CLAUDE_VALIDATION:-0}"
SKIP_CODEX_CLAUDE_BRIDGE_VALIDATION="${SKIP_CODEX_CLAUDE_BRIDGE_VALIDATION:-0}"
CODEX_RECOVERABLE_LIMIT_SLEEP_SECONDS="${CODEX_RECOVERABLE_LIMIT_SLEEP_SECONDS:-18000}"
CODEX_RECOVERABLE_LIMIT_MAX="${CODEX_RECOVERABLE_LIMIT_MAX:-20}"
CODEX_VALIDATION_MAX_RETRIES="${CODEX_VALIDATION_MAX_RETRIES:-3}"
STREAM_CODEX_OUTPUT="${STREAM_CODEX_OUTPUT:-0}"
RUN_DEADLINE_SOURCE="unset"

EXIT_VALIDATION_FAILED=90
EXIT_HARD_LIMIT=91
EXIT_RESTART_LIMIT=92
EXIT_PROGRESS_STALL=93
EXIT_LOCKED=94
EXIT_RECOVERABLE_LIMIT=95
EXIT_CLAUDE_VALIDATION_FAILED=96

if [ "${UNDER_CAFFEINATE:-0}" != "1" ] && [ -x /usr/bin/caffeinate ]; then
  exec /usr/bin/caffeinate -disu env UNDER_CAFFEINATE=1 "$0" "$@"
fi

mkdir -p "$OUTPUT_DIR" "$LOG_DIR"

initialize_deadline() {
  if [ -n "${RUN_DEADLINE_EPOCH:-}" ]; then
    [[ "$RUN_DEADLINE_EPOCH" =~ ^[0-9]+$ ]] || { echo "[launcher] invalid_RUN_DEADLINE_EPOCH=$RUN_DEADLINE_EPOCH" >&2; exit 2; }
    RUN_DEADLINE_SOURCE="environment"
    printf "%s\n" "$RUN_DEADLINE_EPOCH" > "$DEADLINE_FILE"
    return 0
  fi
  if [ -f "$DEADLINE_FILE" ]; then
    RUN_DEADLINE_EPOCH="$(tr -d '[:space:]' < "$DEADLINE_FILE")"
    if [[ "$RUN_DEADLINE_EPOCH" =~ ^[0-9]+$ ]]; then
      RUN_DEADLINE_SOURCE="persisted"
      return 0
    fi
    echo "[launcher] invalid_deadline_file path=$DEADLINE_FILE value=$RUN_DEADLINE_EPOCH; resetting" >&2
  fi
  RUN_DEADLINE_EPOCH="$(( $(date +%s) + RUN_DURATION_SECONDS ))"
  RUN_DEADLINE_SOURCE="new"
  printf "%s\n" "$RUN_DEADLINE_EPOCH" > "$DEADLINE_FILE"
}

deadline_iso() {
  date -u -r "$RUN_DEADLINE_EPOCH" +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || \
    date -u -d "@$RUN_DEADLINE_EPOCH" +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || \
    printf "%s" "$RUN_DEADLINE_EPOCH"
}

acquire_lock() {
  if mkdir "$LOCK_DIR" 2>/dev/null; then
    printf "%s\n" "$$" > "$LOCK_DIR/pid"
    return 0
  fi
  local existing_pid existing_codex_pid
  existing_pid="$(cat "$LOCK_DIR/pid" 2>/dev/null || true)"
  if [ -z "$existing_pid" ] || ! ps -p "$existing_pid" >/dev/null 2>&1; then
    # a SIGKILLed launcher can leave its codex child running and still
    # writing output_edit/; a second session would corrupt the workspace
    existing_codex_pid="$(cat "$LOCK_DIR/codex_pid" 2>/dev/null || true)"
    if [ -n "$existing_codex_pid" ] && ps -p "$existing_codex_pid" >/dev/null 2>&1; then
      echo "[launcher] stale_launcher_but_codex_alive codex_pid=$existing_codex_pid; refusing to start a second session" >&2
      echo "[launcher] wait for it to finish or kill it (kill $existing_codex_pid), then relaunch" >&2
      exit "$EXIT_LOCKED"
    fi
    echo "[launcher] stale_lock_detected pid=${existing_pid:-missing} lock_dir=$LOCK_DIR" >&2
    rm -rf "$LOCK_DIR"
    if mkdir "$LOCK_DIR" 2>/dev/null; then
      printf "%s\n" "$$" > "$LOCK_DIR/pid"
      return 0
    fi
  fi
  echo "[launcher] already_running lock_dir=$LOCK_DIR pid=${existing_pid:-unknown}" >&2
  exit "$EXIT_LOCKED"
}

cleanup_lock() {
  rm -f "$LOCK_DIR/pid" "$LOCK_DIR/codex_pid" 2>/dev/null || true
  rmdir "$LOCK_DIR" 2>/dev/null || true
}

handle_signal() {
  local code="$1"
  local signal="$2"
  echo "[launcher] interrupted signal=$signal; not restarting"
  if [ -n "${CODEX_PID:-}" ] && kill -0 "$CODEX_PID" 2>/dev/null; then
    kill -TERM "$CODEX_PID" 2>/dev/null || true
  fi
  exit "$code"
}

remaining_seconds() { echo $((RUN_DEADLINE_EPOCH - $(date +%s))); }
deadline_reached() { [ "$(remaining_seconds)" -le 0 ]; }
exit_if_deadline_reached() { if deadline_reached; then echo "[launcher] deadline_reached deadline_utc=$RUN_DEADLINE_ISO; stopping"; exit 0; fi; }

sleep_with_deadline() {
  local requested_seconds="$1"
  local reason="$2"
  local remaining actual_seconds
  remaining="$(remaining_seconds)"
  if [ "$remaining" -le 0 ]; then
    echo "[launcher] deadline_reached_before_sleep reason=$reason deadline_utc=$RUN_DEADLINE_ISO"
    return 1
  fi
  actual_seconds="$requested_seconds"
  [ "$actual_seconds" -le "$remaining" ] || actual_seconds="$remaining"
  echo "[launcher] sleeping=${actual_seconds}s requested=${requested_seconds}s reason=$reason remaining_before=${remaining}s"
  sleep "$actual_seconds"
}

task_prompt_with_deadline() {
  cat "$TASK_PROMPT"
  printf "\n\nLauncher wall-clock deadline (UTC): %s\n" "$RUN_DEADLINE_ISO"
  printf "Treat this as the original 96-hour editing run deadline. Preserve it in output_edit/status.md and do not reset it on resume.\n"
}

output_commit_count() {
  if [ -d "$OUTPUT_DIR/.git" ]; then git -C "$OUTPUT_DIR" rev-list --count HEAD 2>/dev/null || echo 0; else echo 0; fi
}

accepted_word_count() {
  if [ -d "$OUTPUT_DIR/chapters" ]; then find "$OUTPUT_DIR/chapters" -type f -name "*.md" -exec cat {} + 2>/dev/null | wc -w | tr -d " "; else echo 0; fi
}

generated_markdown_word_count() {
  find "$OUTPUT_DIR" -type f -name "*.md" ! -path "$OUTPUT_DIR/.git/*" ! -path "$LOCK_DIR/*" ! -path "$LOG_DIR/*" -exec cat {} + 2>/dev/null | wc -w | tr -d " "
}

artifact_count() {
  find "$OUTPUT_DIR" -type f ! -path "$OUTPUT_DIR/.git/*" ! -path "$LOCK_DIR/*" ! -path "$LOG_DIR/*" 2>/dev/null | wc -l | tr -d " "
}

record_progress_or_stall() {
  local rc="$1"
  local reason="$2"
  local current_commit_count current_accepted_words current_generated_words current_artifact_count
  current_commit_count="$(output_commit_count)"
  current_accepted_words="$(accepted_word_count)"
  current_generated_words="$(generated_markdown_word_count)"
  current_artifact_count="$(artifact_count)"
  echo "[launcher] progress reason=$reason previous_commits=$last_commit_count current_commits=$current_commit_count previous_accepted_words=$last_accepted_words current_accepted_words=$current_accepted_words previous_generated_md_words=$last_generated_words current_generated_md_words=$current_generated_words previous_artifacts=$last_artifact_count current_artifacts=$current_artifact_count"
  if [ "$current_commit_count" -gt "$last_commit_count" ] || [ "$current_accepted_words" -gt "$last_accepted_words" ] || [ "$current_generated_words" -gt "$last_generated_words" ]; then
    last_commit_count="$current_commit_count"
    last_accepted_words="$current_accepted_words"
    last_generated_words="$current_generated_words"
    last_artifact_count="$current_artifact_count"
    stalled_restart_count=0
    return 0
  fi
  if [ "$current_artifact_count" -gt "$last_artifact_count" ]; then
    echo "[launcher] artifact_only_progress_ignored_for_stall previous_artifacts=$last_artifact_count current_artifacts=$current_artifact_count"
    last_artifact_count="$current_artifact_count"
  fi
  stalled_restart_count=$((stalled_restart_count + 1))
  echo "[launcher] no_substantive_progress stalled_restarts=$stalled_restart_count/$PROGRESS_STALL_RESTARTS"
  if [ "$stalled_restart_count" -ge "$PROGRESS_STALL_RESTARTS" ]; then
    echo "[launcher] progress_stall_limit_reached rc=$rc; not restarting"
    exit "$EXIT_PROGRESS_STALL"
  fi
}

init_output_git() {
  if ! command -v git >/dev/null 2>&1; then echo "[launcher] git_unavailable; output snapshots disabled"; return 0; fi
  if [ ! -d "$OUTPUT_DIR/.git" ]; then
    echo "[launcher] git_init output_dir=$OUTPUT_DIR"
    git -C "$OUTPUT_DIR" init
  fi
  [ -f "$OUTPUT_DIR/.gitignore" ] || touch "$OUTPUT_DIR/.gitignore"
  grep -Fxq "logs/" "$OUTPUT_DIR/.gitignore" || printf "logs/\n" >> "$OUTPUT_DIR/.gitignore"
  grep -Fxq ".launcher.lock/" "$OUTPUT_DIR/.gitignore" || printf ".launcher.lock/\n" >> "$OUTPUT_DIR/.gitignore"
  grep -Fxq ".claude_guard/" "$OUTPUT_DIR/.gitignore" || printf ".claude_guard/\n" >> "$OUTPUT_DIR/.gitignore"
  grep -Fxq ".deadline_epoch" "$OUTPUT_DIR/.gitignore" || printf ".deadline_epoch\n" >> "$OUTPUT_DIR/.gitignore"
  set +e
  git -C "$OUTPUT_DIR" add .gitignore
  git -C "$OUTPUT_DIR" commit -m "initialize editing output workspace"
  local rc=$?
  set -e
  [ "$rc" -eq 0 ] || echo "[launcher] git_initial_commit_skipped rc=$rc"
}

# Limit classification reads codex STDERR (where CLI/API errors surface),
# never the stdout transcript: manuscript prose routinely contains phrases
# like "payment failed" or "try again in the morning" and must not be
# classified as billing/rate-limit failures. Only if stderr is empty does it
# fall back to the tail of the combined log. The 429 alternation is
# boundary-guarded so ordinary numbers (14,429 / line numbers) cannot match.
CODEX_HARD_LIMIT_PATTERN="weekly[[:space:]-]*(usage[[:space:]-]*)?limit|weekly.*quota|credit(s)?[[:space:]-]*(limit|exhausted|exhaustion|expired)|quota[[:space:]-]*(exhausted|exhaustion|exceeded)|insufficient quota|billing[[:space:]-]*(failed|failure|disabled|suspended|required)|payment[[:space:]-]*(required|failed|failure)"
CODEX_RECOVERABLE_LIMIT_PATTERN="rate limit|usage limit|too many requests|(5|five)[ -]?hour[ -]*(usage[ -]*)?(limit|quota)|(^|[^0-9,.])429([^0-9]|$)|try again (in|after|at)|resets? (in|at|after)|limit resets?"

_codex_limit_match() {
  local pattern="$1" err_file="$2" combined_file="${3:-}"
  if [ -n "$err_file" ] && [ -s "$err_file" ]; then
    tail -n 200 "$err_file" | grep -Eqi "$pattern"
    return $?
  fi
  if [ -n "$combined_file" ] && [ -s "$combined_file" ]; then
    tail -n 50 "$combined_file" | grep -Eqi "$pattern"
    return $?
  fi
  return 1
}

codex_hard_limit_seen() {
  _codex_limit_match "$CODEX_HARD_LIMIT_PATTERN" "$1" "${2:-}"
}

codex_recoverable_limit_seen() {
  _codex_limit_match "$CODEX_RECOVERABLE_LIMIT_PATTERN" "$1" "${2:-}"
}

claude_auth_failure_seen() {
  tail -n 200 "$1" | grep -Eqi "Not logged in|authentication_failed|apiKeySource.*none|Please run /login"
}

validate_editor_inputs() {
  local premise_count=0 draft_count=0 file
  if [ ! -d "$INPUT_DIR/premise" ]; then echo "[launcher] premise_validation_failed missing_dir=$INPUT_DIR/premise"; exit "$EXIT_VALIDATION_FAILED"; fi
  while IFS= read -r -d '' file; do premise_count=$((premise_count + 1)); done < <(find "$INPUT_DIR/premise" -type f ! -name "README.md" ! -name ".DS_Store" ! -name ".*" -size +0c -print0)
  if [ "$premise_count" -eq 0 ]; then echo "[launcher] premise_validation_failed no_non_readme_premise_file"; exit "$EXIT_VALIDATION_FAILED"; fi
  if [ ! -d "$INPUT_DIR/draft" ]; then echo "[launcher] draft_validation_failed missing_dir=$INPUT_DIR/draft"; exit "$EXIT_VALIDATION_FAILED"; fi
  while IFS= read -r -d '' file; do draft_count=$((draft_count + 1)); done < <(find "$INPUT_DIR/draft" -maxdepth 1 -type f -name "chapter_*.md" -size +0c -print0)
  if [ "$draft_count" -eq 0 ]; then
    echo "[launcher] draft_validation_failed no_chapter_files"
    echo "[launcher] copy authoring-run chapters into input/draft/chapter_XX.md before launching"
    exit "$EXIT_VALIDATION_FAILED"
  fi
  echo "[launcher] input_validation_done premise_files=$premise_count draft_chapters=$draft_count"
}

validate_codex_config() {
  [ "$SKIP_CODEX_VALIDATION" = "1" ] && { echo "[launcher] codex_validation skipped"; return 0; }
  local validation_attempt=1 validation_log validation_err rc
  while true; do
    validation_log="$LOG_DIR/codex_validation_${validation_attempt}.log"
    validation_err="$LOG_DIR/codex_validation_${validation_attempt}.err.log"
    echo "[launcher] codex_validation_start attempt=$validation_attempt log=$validation_log"
    set +e
    "$CODEX_BIN" exec --dangerously-bypass-approvals-and-sandbox --skip-git-repo-check -C "$PROJECT_ROOT" -m gpt-5.5 -c 'model_reasoning_effort="xhigh"' "Print exactly OK and exit." > "$validation_log" 2> "$validation_err"
    rc=$?
    set -e
    if [ "$rc" -eq 0 ] && grep -Eq "^[[:space:]]*OK[[:space:]]*$" "$validation_log"; then echo "[launcher] codex_validation_done"; return 0; fi
    if codex_hard_limit_seen "$validation_err" "$validation_log"; then echo "[launcher] codex_validation_hard_limit rc=$rc"; exit "$EXIT_HARD_LIMIT"; fi
    if codex_recoverable_limit_seen "$validation_err" "$validation_log" && [ "$validation_attempt" -lt "$CODEX_VALIDATION_MAX_RETRIES" ]; then
      echo "[launcher] codex_validation_recoverable_limit sleeping=${CODEX_RECOVERABLE_LIMIT_SLEEP_SECONDS}s attempt=$validation_attempt/$CODEX_VALIDATION_MAX_RETRIES"
      sleep_with_deadline "$CODEX_RECOVERABLE_LIMIT_SLEEP_SECONDS" "codex_validation_recoverable_limit" || exit 0
      validation_attempt=$((validation_attempt + 1))
      continue
    fi
    echo "[launcher] codex_validation_failed rc=$rc"
    tail -n 20 "$validation_log" "$validation_err" 2>/dev/null
    exit "$EXIT_VALIDATION_FAILED"
  done
}

validate_claude_config() {
  [ "$SKIP_CLAUDE_VALIDATION" = "1" ] && { echo "[launcher] claude_validation skipped"; return 0; }
  local resolved_claude validation_log rc
  if ! resolved_claude="$(command -v "$CLAUDE_BIN" 2>/dev/null)"; then echo "[launcher] claude_validation_missing bin=$CLAUDE_BIN"; exit "$EXIT_CLAUDE_VALIDATION_FAILED"; fi
  validation_log="$LOG_DIR/claude_validation.log"
  echo "[launcher] claude_validation_start bin=$resolved_claude log=$validation_log"
  set +e
  CLAUDE_BIN="$resolved_claude" CLAUDE_DISALLOWED_TOOLS="$CLAUDE_DISALLOWED_TOOLS" CLAUDE_TOOLS="$CLAUDE_TOOLS" "$CLAUDE_SMOKE_SCRIPT" > "$validation_log" 2>&1
  rc=$?
  set -e
  if [ "$rc" -eq 0 ] && grep -Eq "INNER_CLAUDE_OK" "$validation_log"; then echo "[launcher] claude_validation_done"; return 0; fi
  echo "[launcher] claude_validation_failed rc=$rc"
  if claude_auth_failure_seen "$validation_log"; then
    echo "[launcher] claude_validation_auth_failed; run 'claude /login' interactively or provide Claude API credentials before launching"
  fi
  tail -n 20 "$validation_log"
  echo "[launcher] set SKIP_CLAUDE_VALIDATION=1 to run Codex-only or if Claude validation is intentionally deferred"
  exit "$EXIT_CLAUDE_VALIDATION_FAILED"
}

validate_codex_claude_bridge() {
  if [ "$SKIP_CLAUDE_VALIDATION" = "1" ] || [ "$SKIP_CODEX_CLAUDE_BRIDGE_VALIDATION" = "1" ]; then echo "[launcher] codex_claude_bridge_validation skipped"; return 0; fi
  local resolved_claude validation_log quoted_claude rc
  if ! resolved_claude="$(command -v "$CLAUDE_BIN" 2>/dev/null)"; then echo "[launcher] codex_claude_bridge_validation_missing bin=$CLAUDE_BIN"; exit "$EXIT_CLAUDE_VALIDATION_FAILED"; fi
  validation_log="$LOG_DIR/codex_claude_bridge_validation.log"
  quoted_claude="$(printf "%q" "$resolved_claude")"
  echo "[launcher] codex_claude_bridge_validation_start log=$validation_log"
  set +e
  "$CODEX_BIN" exec --dangerously-bypass-approvals-and-sandbox --skip-git-repo-check -C "$PROJECT_ROOT" -m gpt-5.5 -c 'model_reasoning_effort="xhigh"' "Setup validation only. Do not edit files. Run this exact shell command to verify Claude is reachable from inside the Codex execution environment: CLAUDE_BIN=$quoted_claude CLAUDE_DISALLOWED_TOOLS='$CLAUDE_DISALLOWED_TOOLS' CLAUDE_TOOLS='$CLAUDE_TOOLS' bash scripts/inner_claude_smoke.sh. The smoke script verifies its own output. If the command exits 0, print exactly OK and exit. If it fails, print the failure briefly and exit nonzero." > "$validation_log" 2>&1
  rc=$?
  set -e
  if [ "$rc" -eq 0 ] && grep -Eq "^[[:space:]]*OK[[:space:]]*$" "$validation_log"; then echo "[launcher] codex_claude_bridge_validation_done"; return 0; fi
  echo "[launcher] codex_claude_bridge_validation_failed rc=$rc"
  if claude_auth_failure_seen "$validation_log"; then
    echo "[launcher] codex_claude_bridge_auth_failed; Claude is reachable as a binary but not authenticated inside the Codex execution environment"
  fi
  tail -n 40 "$validation_log"
  echo "[launcher] set SKIP_CODEX_CLAUDE_BRIDGE_VALIDATION=1 to skip this integration preflight"
  exit "$EXIT_CLAUDE_VALIDATION_FAILED"
}

acquire_lock
trap cleanup_lock EXIT
trap 'handle_signal 130 INT' INT
trap 'handle_signal 143 TERM' TERM
initialize_deadline
RUN_DEADLINE_ISO="$(deadline_iso)"
LOG_FILE="$LOG_DIR/launcher_$(date +%Y%m%d_%H%M%S).log"
ln -sfn "$LOG_FILE" "$LOG_DIR/launcher_current.log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "[launcher] project_root=$PROJECT_ROOT"
echo "[launcher] log_file=$LOG_FILE"
echo "[launcher] model=gpt-5.5 reasoning=xhigh deadline_utc=$RUN_DEADLINE_ISO deadline_source=$RUN_DEADLINE_SOURCE deadline_file=$DEADLINE_FILE run_duration=${RUN_DURATION_SECONDS}s max_restarts=$MAX_RESTARTS progress_stall_restarts=$PROGRESS_STALL_RESTARTS recoverable_limit_sleep=${CODEX_RECOVERABLE_LIMIT_SLEEP_SECONDS}s recoverable_limit_max=$CODEX_RECOVERABLE_LIMIT_MAX stream_codex_output=$STREAM_CODEX_OUTPUT caffeinate=${UNDER_CAFFEINATE:-0}"

validate_editor_inputs
init_output_git
validate_codex_config
validate_claude_config
validate_codex_claude_bridge

attempt_count=0
restart_count=0
stalled_restart_count=0
recoverable_limit_count=0
last_commit_count="$(output_commit_count)"
last_accepted_words="$(accepted_word_count)"
last_generated_words="$(generated_markdown_word_count)"
last_artifact_count="$(artifact_count)"
echo "[launcher] initial_progress commits=$last_commit_count accepted_words=$last_accepted_words generated_md_words=$last_generated_words artifacts=$last_artifact_count"

while true; do
  exit_if_deadline_reached
  attempt_count=$((attempt_count + 1))
  echo "[launcher] codex_start attempt=$attempt_count restart_count=$restart_count at=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  ATTEMPT_LOG="$LOG_DIR/codex_attempt_${attempt_count}_$(date +%Y%m%d_%H%M%S).log"
  ATTEMPT_ERR="${ATTEMPT_LOG%.log}.err.log"
  ln -sfn "$ATTEMPT_LOG" "$LOG_DIR/codex_attempt_current.log"
  ln -sfn "$ATTEMPT_ERR" "$LOG_DIR/codex_attempt_current.err.log"
  echo "[launcher] attempt_log=$ATTEMPT_LOG"

  # codex runs in the background so its pid can be recorded in the lock dir
  # (a relaunch after launcher SIGKILL must not start a second session) and
  # so INT/TERM traps fire promptly and can forward the signal to the child
  set +e
  if [ "$STREAM_CODEX_OUTPUT" = "1" ]; then
    "$CODEX_BIN" exec --dangerously-bypass-approvals-and-sandbox --skip-git-repo-check -C "$PROJECT_ROOT" -m gpt-5.5 -c 'model_reasoning_effort="xhigh"' "$(task_prompt_with_deadline)" > >(tee "$ATTEMPT_LOG") 2> "$ATTEMPT_ERR" &
  else
    "$CODEX_BIN" exec --dangerously-bypass-approvals-and-sandbox --skip-git-repo-check -C "$PROJECT_ROOT" -m gpt-5.5 -c 'model_reasoning_effort="xhigh"' "$(task_prompt_with_deadline)" > "$ATTEMPT_LOG" 2> "$ATTEMPT_ERR" &
  fi
  CODEX_PID=$!
  printf "%s\n" "$CODEX_PID" > "$LOCK_DIR/codex_pid"
  wait "$CODEX_PID"
  rc=$?
  rm -f "$LOCK_DIR/codex_pid" 2>/dev/null
  set -e

  if [ "$rc" -eq 0 ]; then
    echo "[launcher] codex_exit rc=0 at=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    if deadline_reached; then echo "[launcher] codex_success_at_or_after_deadline deadline_utc=$RUN_DEADLINE_ISO"; exit 0; fi
    record_progress_or_stall "$rc" "successful_attempt_before_deadline"
    sleep_with_deadline "$SUCCESS_RESTART_SLEEP_SECONDS" "successful_attempt_before_deadline" || exit 0
    continue
  fi

  echo "[launcher] codex_exit rc=$rc at=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  if [ "$rc" -eq 130 ] || [ "$rc" -eq 143 ]; then echo "[launcher] interrupted; not restarting"; exit "$rc"; fi
  if codex_hard_limit_seen "$ATTEMPT_ERR" "$ATTEMPT_LOG"; then echo "[launcher] codex_hard_limit_detected; not restarting"; exit "$EXIT_HARD_LIMIT"; fi
  if codex_recoverable_limit_seen "$ATTEMPT_ERR" "$ATTEMPT_LOG"; then
    restart_count=$((restart_count + 1))
    recoverable_limit_count=$((recoverable_limit_count + 1))
    [ "$restart_count" -le "$MAX_RESTARTS" ] || { echo "[launcher] restart_limit_reached max_restarts=$MAX_RESTARTS"; exit "$EXIT_RESTART_LIMIT"; }
    [ "$recoverable_limit_count" -le "$CODEX_RECOVERABLE_LIMIT_MAX" ] || { echo "[launcher] recoverable_limit_max_reached max=$CODEX_RECOVERABLE_LIMIT_MAX"; exit "$EXIT_RECOVERABLE_LIMIT"; }
    record_progress_or_stall "$rc" "recoverable_limit"
    echo "[launcher] codex_recoverable_limit_detected sleeping=${CODEX_RECOVERABLE_LIMIT_SLEEP_SECONDS}s restart=$restart_count/$MAX_RESTARTS recoverable_count=$recoverable_limit_count/$CODEX_RECOVERABLE_LIMIT_MAX"
    sleep_with_deadline "$CODEX_RECOVERABLE_LIMIT_SLEEP_SECONDS" "codex_recoverable_limit" || exit 0
    continue
  fi

  record_progress_or_stall "$rc" "nonrecoverable_failure"
  restart_count=$((restart_count + 1))
  [ "$restart_count" -le "$MAX_RESTARTS" ] || { echo "[launcher] restart_limit_reached max_restarts=$MAX_RESTARTS"; exit "$EXIT_RESTART_LIMIT"; }
  sleep_seconds=$((RESTART_BASE_SLEEP_SECONDS * restart_count))
  [ "$sleep_seconds" -le "$RESTART_MAX_SLEEP_SECONDS" ] || sleep_seconds="$RESTART_MAX_SLEEP_SECONDS"
  echo "[launcher] restarting_after=${sleep_seconds}s restart=$restart_count/$MAX_RESTARTS"
  sleep_with_deadline "$sleep_seconds" "nonrecoverable_restart_backoff" || exit 0
done
