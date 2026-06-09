# Verve Pipeline — Drafter + Editor

Two-stage autonomous novel pipeline. Both stages use Codex (GPT-5.5 extra-high) as the orchestrator and Claude Opus 4.7 (max effort) as the independent revision agent / adversarial auditor.

## Contents

- **`drafter/`** — Phase 1: generate a complete novel manuscript from a premise. Premise + optional reading guide go in; an 86-ish chapter manuscript comes out. ~96-hour autonomous run.
- **`editor/`** — Phase 2: edit a drafted manuscript against the binding editorial standard. Drafted manuscript + premise + impressions go in; revised final manuscript comes out. ~96-hour autonomous run.

The two stages are independent. You can run the drafter alone, the editor alone (on any manuscript), or chain them (drafter output becomes editor input).

## Each subfolder is self-contained

Each subfolder has its own `README.md`, `launch.sh`, task prompt, and scripts. Read the subfolder README before running.

## What's NOT included

- Premise files
- Reading guides
- Reader impressions
- Calibration artifacts
- Manuscript chapters (drafted or revised)
- Output artifacts (audits, trackers, logs, revision memos)
- Intermediate drafts

The packaging is intentional: just the pipeline scaffolding (task prompts, code, scripts, launchers, README docs). Drop your own premise/manuscript into the appropriate `input/` directories and run.

## Requirements

- Codex CLI installed and authenticated
- Claude Code CLI installed and authenticated (`claude` on PATH)
- macOS or Linux shell (zsh / bash)
- `caffeinate` (macOS) — optional; the launcher uses it to prevent sleep
- Git (the editor uses git inside its output dir for rollback)

## Notes on premise-specific content in the prompts

The task prompts (`long_novel_task.md` in drafter, `long_novel_editing.md` in editor) contain some premise-agnostic process scaffolding and may reference VERVE-specific examples (e.g., book-specific Gate naming conventions like "VERVE-1 through VERVE-N"). The prompts are designed to read the actual premise from `input/premise/` files at runtime — they do NOT contain the VERVE premise content itself, only the pipeline structure. Adapt example references if/when you bring a different premise.
