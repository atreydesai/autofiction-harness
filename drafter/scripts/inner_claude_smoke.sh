#!/usr/bin/env bash
set -euo pipefail

# Production-parity smoke test: same env-resolved CLAUDE_MODEL/CLAUDE_EFFORT
# and the same stdin --input-format text path that claude_logged_call.sh uses,
# so preflight exercises the call shape the run actually executes. The result
# event is verified directly — a marker echoed inside thinking/transcript text
# does not count. Exits 0 only on a verified INNER_CLAUDE_OK final response.
CLAUDE_BIN="${CLAUDE_BIN:-claude}"
CLAUDE_MODEL="${CLAUDE_MODEL:-claude-fable-5}"
CLAUDE_EFFORT="${CLAUDE_EFFORT:-xhigh}"
CLAUDE_DISALLOWED_TOOLS="${CLAUDE_DISALLOWED_TOOLS:-Agent,Task,TaskCreate,TaskGet,TaskList,TaskStop,TaskUpdate,TaskOutput,ToolSearch}"
CLAUDE_TOOLS="${CLAUDE_TOOLS:-Read,Bash,Grep,Glob}"

command -v python3 >/dev/null 2>&1 || { echo "[inner_claude_smoke] python3 is required" >&2; exit 1; }

printf '%s' 'Validation only. Do not edit files. In exactly two sentences, critique this sample for fake-sharp dialogue and generic menace prose: "Trouble?" she asked. "Debt." The man had hands clean in the way some knives were clean. End the second sentence with INNER_CLAUDE_OK.' | \
"$CLAUDE_BIN" -p \
  --model "$CLAUDE_MODEL" \
  --effort "$CLAUDE_EFFORT" \
  --tools "$CLAUDE_TOOLS" \
  --disallowedTools "$CLAUDE_DISALLOWED_TOOLS" \
  --input-format text \
  --output-format stream-json \
  --verbose \
  --no-session-persistence \
  --dangerously-skip-permissions | \
python3 -c '
import json, sys
ok = False
for line in sys.stdin:
    stripped = line.strip()
    if not stripped:
        continue
    sys.stdout.write(line)
    try:
        event = json.loads(stripped)
    except json.JSONDecodeError:
        continue
    if event.get("type") == "result":
        ok = (not event.get("is_error")) and "INNER_CLAUDE_OK" in (event.get("result") or "")
print("[inner_claude_smoke] INNER_CLAUDE_OK verified" if ok else "[inner_claude_smoke] verification failed: no clean result event containing INNER_CLAUDE_OK", file=sys.stderr)
sys.exit(0 if ok else 1)
'
