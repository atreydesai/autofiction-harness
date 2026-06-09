#!/usr/bin/env bash
# Thin wrapper: runs the shared tiered mechanical quality gate (checks/quality_gate.py)
# against the editor workspace (output_edit/). Same registry as the drafter; the gate
# runs on every revised chapter before commit.
#
# Usage: scripts/quality_gate.sh [--book-level] [chapter files...]
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HARNESS_ROOT="$(cd "$PROJECT_ROOT/.." && pwd)"

exec python3 "$HARNESS_ROOT/checks/quality_gate.py" \
  --output-dir "$PROJECT_ROOT/output_edit" \
  --chapters-dir "$PROJECT_ROOT/output_edit/chapters" \
  --patterns-dir "$HARNESS_ROOT/checks/patterns" \
  --report "$PROJECT_ROOT/output_edit/audits/codex/mechanical/quality_gate_report.md" \
  --allowlist "$PROJECT_ROOT/output_edit/quality_gate_allowlist.txt" \
  "$@"
