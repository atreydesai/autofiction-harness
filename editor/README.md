# Autonomous Editor

96-hour autonomous editing run over a drafted manuscript. Codex (GPT-5.5, extra-high reasoning) is the editor-orchestrator; Claude Opus 4.7 (max effort) is an independent revision agent and adversarial auditor. Every committed chapter goes through cross-model audit stacks.

## Inputs

- `long_novel_editing.md` — autonomous editing task prompt. Premise-agnostic process scaffolding; reads from `input/`.
- `input/premise/` — the binding editorial standard:
  - Source premise file
  - `READING_GUIDE.md` (voice rules, register, motifs, form binding, length target)
  - Optional: calibration artifact (e.g., `*_register_calibration.md`) — observed drift, premise-specific Gates, inviolable elements
  - Optional: `reader_impressions.md` — author-direction reactions captured during drafting; treated as BINDING editorial direction
- `input/draft/` — the drafted manuscript as per-chapter Markdown files (one per chapter). The editor archives these to `output_edit/original_draft_archive/` before any edits.
- `input/artifacts/` — optional supporting artifacts from the drafting run (story_bible, continuity, skeleton, voice cards, tics, etc.). Treated as writer-intent evidence, not authority. **Note:** artifacts that prescribe specific chapter forms can bias the editor toward preserving those forms. Be selective about what you include.
- `scripts/claude_logged_call.sh` — Claude wrapper (Opus 4.7 max, logging, serialization, markdown extraction).
- `scripts/inner_claude_smoke.sh` — Claude reachability check.
- `launch.sh` — restartable 96-hour editor launcher.

## Run

```bash
# 1. Drop premise materials under input/premise/
# 2. Drop draft chapters under input/draft/
# 3. (Optionally) Drop drafting artifacts under input/artifacts/
# 4. Launch
./launch.sh
```

Monitor:

```bash
tail -F output_edit/logs/launcher_current.log
tail -F output_edit/logs/codex_attempt_current.log
```

Stop with `Ctrl-C`; the launcher's signal handler releases the lock cleanly.

## What the editor does

Six-phase architecture:

1. **Phase 1 — Cold diagnosis.** Read premise + manuscript without opening artifacts. Produce per-chapter classification, drift report, form-distribution baseline, and author-direction findings.
2. **Phase 2 — Re-architecture.** Open artifacts as writer-intent evidence. Build surgery plan: chapter cuts / merges / splits / additions / reorderings, subplot reweighting.
3. **Phase 3 — Calibration.** Extract verbatim Gates, inviolable elements, form rules, tic catalog, motif caps. Build trackers (subplot, continuity, motifs, voice cards).
4. **Phase 4 — Chapter revision.** Each chapter: Claude revision → Plain-Translation audit → Chaos-Up audit (raises integrated) → post-edit recheck → Codex audit stack (defensive, adversarial-register, chat-variety, comedy doctor, dialogue doctor, pacing, opening hook, surprise, set-piece intensity, counter-strip) → tracker updates → commit.
5. **Phase 5 — Cold reads + book-level audits.** Whole-manuscript passes. Author-direction address verification. Form-distribution audit. Motif audit. Ending-earn audit.
6. **Phase 6 — Final assembly.** Mandatory full-book Claude cold read. Final mechanical checks. Assemble final manuscript.

See `long_novel_editing.md` for the full process specification.
