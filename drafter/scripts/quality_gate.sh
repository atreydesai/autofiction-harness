#!/usr/bin/env bash
# Thin wrapper: runs the shared tiered mechanical quality gate (checks/quality_gate.py)
# against the drafter workspace. Legacy grep gate replaced by the data-driven registry
# under checks/patterns/ (see COVERAGE_MATRIX.md for pattern provenance).
#
# Usage: scripts/quality_gate.sh [--book-level] [chapter files...]
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HARNESS_ROOT="$(cd "$PROJECT_ROOT/.." && pwd)"

exec python3 "$HARNESS_ROOT/checks/quality_gate.py" \
  --output-dir "$PROJECT_ROOT/output" \
  --patterns-dir "$HARNESS_ROOT/checks/patterns" \
  --patterns-dir "$PROJECT_ROOT/premise/patterns" \
  --report "$PROJECT_ROOT/output/critiques/codex/mechanical/quality_gate_report.md" \
  --allowlist "$PROJECT_ROOT/output/quality_gate_allowlist.txt" \
  "$@"
