# Autonomous novel generation template

Premise-driven 96-hour autonomous novel-writing run. Codex (GPT-5.5, extra-high reasoning) is the author-editor, planner, continuity owner, and final integrator. Claude Fable 5 (xhigh effort) is an independent co-drafter and adversarial editor. Every committed chapter goes through cross-model adversarial synthesis.

## Structure

- `long_novel_task.md` — premise-agnostic task prompt passed to Codex on every launch. Process scaffolding only.
- `prompts/constitution.md` and `prompts/quality_brief.md` — premise-agnostic taste/craft lenses.
- `premise/` — drop the source premise here. Optionally include a `READING_GUIDE.md` for book-specific interpretation: voice rules, register, motifs, care-move table, tic catalog, form binding, length target, and architecture questions the agent must settle in Phase 2. The reading guide overrides any generic defaults in `long_novel_task.md`. If no reading guide is present, the agent derives one in Phase 1 and saves it as `output/reading_guide_derived.md`.
- `launch.sh` — caffeinated launcher: validates premise exists, validates Codex + Claude reachability, runs the Codex-to-Claude bridge check, restarts on recoverable failures up to the 96-hour deadline.
- `scripts/` — `claude_logged_call.sh` (Claude wrapper: serializes calls, logs provenance, extracts assistant text to markdown; no hard budgets), `quality_gate.sh` (wrapper for the shared tiered mechanical gate `../checks/quality_gate.py` — 208-pattern registry, BANNED/CAP/WATCH tiers), `dialogue_scene_manifest.sh` (inventories quoted-dialogue scenes), `prose_variability_audit.sh` (cross-chapter rhythm metrics), `inner_claude_smoke.sh` (Claude reachability test).
- `output/` — generated work lives here: planning artifacts, chapters, drafts, critiques, audits, trackers, logs, git history.
- `../checks/` — the shared check library: pattern registry + quality-gate engine, 79 judgment-audit templates scheduled by `audit_manifest.tsv` (core/risk/book tiers, codex/claude owners), drafting protocols (pre-draft / mid-draft / post-draft / final test), and workspace scaffold templates (master spec, character snapshots, world bible, NPC goals, thread ledger, canon sheet, continuity log, ...). The task prompt wires all of it in; see the root `COVERAGE_MATRIX.md` for the source of every check.

## Run

```bash
# 1. Drop a premise file (and optional reading guide) under premise/
cp /path/to/your/premise.txt premise/
cp /path/to/your/READING_GUIDE.md premise/   # optional

# 2. Launch
./launch.sh
```

Monitor:

```bash
tail -F output/logs/launcher_current.log
tail -F output/logs/codex_attempt_current.log
```

Stop with `Ctrl-C`; the launcher's signal handler releases the lock cleanly.

The first launch writes `output/.deadline_epoch`; relaunches reuse that original deadline rather than silently starting a fresh 96-hour clock. Delete `output/` artifacts for a truly cold new run.

## Design

The premise + reading guide carry all book-specific knowledge (voice, form, tics, motifs, care moves, length, architecture questions). The task prompt carries only premise-agnostic process: workspace layout, relaunch behavior, phase ordering, cross-model adversarial flow, brutal critique culture, per-chapter judgment, final-assembly conditions. The bet is that an Fable-5-and-GPT-5.5-class agent pair, given a rich premise and a comprehensive reading guide, will produce better work with less process scaffolding than with more. Calibration that matters lives in `premise/`; process that matters lives in `long_novel_task.md`; everything else is judgment.
