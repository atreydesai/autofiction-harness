#!/usr/bin/env bash
set -euo pipefail

CLAUDE_BIN="${CLAUDE_BIN:-claude}"
CLAUDE_DISALLOWED_TOOLS="${CLAUDE_DISALLOWED_TOOLS:-Agent,Task,TaskCreate,TaskGet,TaskList,TaskStop,TaskUpdate,TaskOutput,ToolSearch}"
CLAUDE_TOOLS="${CLAUDE_TOOLS:-Read,Bash,Grep,Glob}"

"$CLAUDE_BIN" -p \
  --model claude-opus-4-7 \
  --effort max \
  --tools "$CLAUDE_TOOLS" \
  --disallowedTools "$CLAUDE_DISALLOWED_TOOLS" \
  --output-format stream-json \
  --verbose \
  --no-session-persistence \
  --dangerously-skip-permissions \
  'Validation only. Do not edit files. In exactly two sentences, critique this sample for fake-sharp dialogue and generic menace prose: "Trouble?" she asked. "Debt." The man had hands clean in the way some knives were clean. End the second sentence with INNER_CLAUDE_OK.'
