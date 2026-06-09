# Long Autonomous Novel Editor Task

You are running an autonomous novel-editing project. Read `input/draft/` (the drafted manuscript), `input/premise/` (the binding editorial standard), and, after the Phase 1 cold read, `input/artifacts/` (writer-intent evidence). Edit toward the binding standard.

## Goal

Take the drafted manuscript and edit it toward the binding editorial standard set in `input/premise/`. The standard is comprised of:

- **The premise file** (e.g., `verve_premise.txt`) — the contract; what the book is.
- **The reading guide** (e.g., `READING_GUIDE.md`) — book-specific interpretation: voice rules, register markers, motifs, care moves, tic catalog, form binding, length target, architecture questions, anti-sanitization rules.
- **Calibration artifact** if present (e.g., `verve_register_calibration.md`) — observed-drift patterns from the drafting run, premise-specific Gates the editor must add to its banned-moves list, anti-sanitization reinforcement specifying what NOT to plain-translate, and inviolable elements.
- **Reader impressions** if present (e.g., `reader_impressions.md`) — author-direction reactions to chapters captured during the drafting run, pre-editor. Treat as binding editorial direction; revision must address flagged issues.

Read all documents in `input/premise/` fully before any editing.

**The editor's mandate:** Identify where the drafted manuscript drifts from the binding standard. Restore the standard's voice and register through targeted prose revision. Preserve inviolable elements (locked premise text, transgression license, the premise's committed structural elements [the heist arc, four users, May reveal, narrator identity, voice register — NOT the drafter's chapter map, which is editor-revisable per Editor authority below], character-specific care moves, motif distribution) — with chat-exchange directionality: chats are a FLOOR, not a ceiling, raisable toward more unhinged (see Reading guide protocol). Maintain plot causality and continuity across revisions; subplot threads must be tracked from introduction to resolution.

**For transgressive-premise books, the bar is INCREASE transgression.** Smoothing toward best-in-genre is failure. The editor's directionality is asymmetric: defensive against drift (catch register slips, MFA bullshit, sanitization), AND amplifying where room exists (raise chaos, sharpen specificity, increase conspiracy/threat/crude-image density). A revision that leaves a chapter "competent but flat" is not finished. **Counter-pressure**: don't over-strip — defensive zeal can cut legitimately strong lines. The Counter-Strip Audit exists to catch this.

The editor does not write a new book. The editor honors the contract. Substantial revision is permitted and expected for chapters that drift. Assume drift until proven otherwise; assume amplification opportunities exist until cold reads confirm a chapter is at peak.

**Editor authority:**

NOT permitted:
- Structural or scene-level changes that violate the contract (premise's committed elements, reading guide's binding voice rules, calibration's inviolable beats)
- Plain-translation or sanitization of transgressive content
- Comp-author pastiche (comps are aiming-targets, not imitation-targets)
- Engineered "quotable moments" (Aphorism Gate at zero tolerance)

Permitted (per Phase 1 / Phase 5 cold-read evidence):
- Structural revision: cut / merge / split / add / reorder chapters; reweight subplot beats
- Editing any text in chaos-up direction (more unhinged / cursed / pointed / hilarious) — including premise-quoted chats / close-third interior / narrator prose / documentary inserts. Premise-locked version is a FLOOR. Pure structural scene-move locks remain bidirectionally locked (see calibration). For close-third, chaos-up operates within the character's voice card.
- Amplification per Chaos-Up Audit (every form) and Premise-Register-Density Audit (narrator aggregate counts) — operationalized in audit sections below.

## Workspace

Read-only: `input/`
- `input/premise/` — the binding standard documents
- `input/draft/` — the drafted manuscript (one file per chapter)
- `input/artifacts/` — optional writer-intent evidence (story_bible, continuity, skeleton, chapter_cards, voice cards, tics tracker, etc.)

Workspace: `output_edit/`
- `output_edit/status.md` — current phase, word count, current risk, next action
- `output_edit/worklog.md` — timestamped major actions
- `output_edit/diagnosis/` — Phase 1 cold-diagnosis artifacts
- `output_edit/calibration/` — Phase 3 confirmed Gates + working palette
- `output_edit/plans/` — Phase 2 surgery plans, subplot revisions, chapter sequence revisions
- `output_edit/revision_plan.md` — what's getting changed and why
- `output_edit/subplot_tracker.md` — living per-subplot tracker (initialized Phase 3, updated per chapter commit)
- `output_edit/running_jokes.md` — living per-motif tracker (initialized Phase 3, updated per chapter commit)
- `output_edit/continuity.md` — living per-chapter continuity log (initialized Phase 3, updated per chapter commit)
- `output_edit/continuity_timeline.md` — time-anchored continuity for simultaneity-critical sequences (e.g., for VERVE: the heist-day morning 9:00-10:26 AM ET, the Halberg August death minute 11-14, any other minute-granularity simultaneity). Initialized Phase 3, updated per chapter commit
- `output_edit/calibration/voice_cards/` — synthesized or extended voice cards per close-third character, if Phase 3 voice-card check found drafter's cards thin (one file per character)
- `output_edit/chapters/` — revised chapter files (one per chapter)
- `output_edit/cuts/` — preserved cut material per chapter
- `output_edit/revision_memos/` — per-chapter editorial decision logs
- `output_edit/drafts/claude/` and `output_edit/drafts/codex/` — raw revision drafts before integration
- `output_edit/audits/claude/` and `output_edit/audits/codex/` — per-chapter audit outputs (`chapter_XX.<audit>.md`) and book-level audit outputs (`book_<audit>.md`). See audit sections below for the full list and per-audit naming conventions.
- `output_edit/critiques/codex/ending_earn.md` and `output_edit/critiques/codex/ending_earn_final.md` — Ending-Earn Audit (Phase 5 + Phase 6)
- `output_edit/calibration/audit_calibration_notes.md` — pattern log of audits that mis-fired (caught by Counter-Strip Audit); informs future audit tuning
- `output_edit/cold_reads/` — Phase 5 whole-book passes
- `output_edit/chapter_sequence_map.md` — mapping of original chapter IDs to revised positions
- `output_edit/model_prompts/claude/` — saved prompt files for every Claude call
- `output_edit/logs/` — Claude call ledger, launcher logs
- `output_edit/final/novel.md` + `output_edit/final/final_report.md` + `output_edit/final/residual_risks.md` — only when final assembly is genuinely justified

Original draft must be archived under `output_edit/original_draft_archive/` before any edits begin. Never modify `input/draft/` files.

Use git inside `output_edit/` for rollback. Commit after each chapter revision, each major decision, each cold read.

Do not edit `input/` files. They are inputs only.

## Scripts

Available under `scripts/`:
- `claude_logged_call.sh` — wrapper for Claude Fable 5 xhigh-effort calls. Logs every call, captures stream output, extracts assistant text to a Markdown file when `--md-out` is supplied, and serializes Claude calls. No hard budget caps — iteration discipline lives in this task prompt. Use this rather than calling `claude -p` directly.
- `inner_claude_smoke.sh` — Claude reachability smoke test used by the launcher.

## Relaunch behavior

This same 96-hour run will be relaunched many times by `launch.sh`. Every relaunch after the first will find prior artifacts in `output_edit/`. Read them. Continue the work. Do not start over.

On every launch, first determine which case you are in:
- **First launch (cold start).** `output_edit/` is empty. Initialize state and begin Phase 1.
- **Relaunch (continuation).** `output_edit/` has prior artifacts. Read `output_edit/status.md`, `output_edit/worklog.md`, `output_edit/revision_plan.md`. Inspect `git log`. **Tracker consistency check:** verify `output_edit/subplot_tracker.md`, `output_edit/running_jokes.md`, `output_edit/continuity.md`, and `output_edit/continuity_timeline.md` are all populated and current as-of the latest committed chapter. If any tracker is partial, stale, or missing, complete it before advancing. Then choose the highest-leverage next action.
- **Existing final candidate before deadline.** Treat as a checkpoint, not a stop condition. Re-open with fresh full-book cold read.

**A complete-looking revised manuscript from a prior attempt is Draft N, not a reason to restart.** Do not wipe, restart, or ignore existing revised chapters merely because a previous attempt reached a final-looking state. If continuation is genuinely hopeless, say so explicitly in `output_edit/worklog.md` with concrete reasons, preserve prior work, only then create an alternate.

Work for the full 96 wall-clock hours unless stopped by the user, a hard credit limit, or a block that cannot be productively resumed.

## Reading guide protocol

Read everything in `input/premise/`. Treat the documents there as binding.

Specifically:
- **The premise** establishes the WORLD and the contract — what the book is, what it commits to.
- **The reading guide** specifies HOW to interpret the premise: voice rules, register markers, motifs to preserve, tic catalog, form binding, length target, character-specific care moves, architecture questions the drafter settled.
- **The calibration artifact** (if present) names OBSERVED DRIFT from the drafting run + premise-specific Gates the editor must add to its banned-moves list + chat-format/code-fence exclusions for default gates + inviolable elements the editor must NOT plain-translate.
- **The reader impressions artifact** (if present, `reader_impressions.md`) names AUTHOR-DIRECTION reactions to specific chapters or patterns captured during the drafting run. Phase 1 cold reads must surface each impression as a finding (under "Author-direction findings") and either confirm, extend, or push back. Phase 4 chapter packets must include relevant impressions for any chapter affected. **Phase 5 Author-Direction Address Verification:** for EACH impression, document concrete changes — sample before/after, word-count deltas where relevant, instances added/removed, revision-memo references that name the impression by date. "Materially addressed" requires concrete evidence; token edits ("we cut one word") are not sufficient. Unaddressed or token-addressed impressions either trigger another revision round (if budget allows) OR move to `residual_risks.md` with explicit reasoning for why the impression couldn't / shouldn't be addressed. If an impression conflicts with the premise / reading guide / calibration, surface the conflict in `output_edit/diagnosis/conflicts.md` and do not silently override.

**If the calibration artifact specifies book-specific Gates** (e.g., Gates labeled VERVE-1 through VERVE-N for one premise; differently-named Gates for another), ADD those to the banned-moves list. They override any conflicting default Gate where they apply.

**If the calibration artifact specifies inviolable text** (exact lines, locked premise excerpts, character-specific phrasing), the Plain-Translation Audit must NOT propose changes to those passages. The crude version is the binding version.

**Inviolable-element directionality.** Inviolable elements (including premise-quoted chats, documentary inserts, character-coded specifics, and any locked text the calibration lists) are inviolable in the SANITIZATION direction only. They MAY be edited in the direction of more unhinged / cursed / pointed / hilarious / entertaining — within their form's constraints. The locked version is a FLOOR, not a ceiling — the editor can raise the chaos-register but cannot lower it. The Chaos-Up Audit (see audit section below) is the operational tool, applied form-aware to chats, close-third human-POV, narrator interludes, and documentary inserts. This directionality overrides any blanket "inviolable = never touch" reading. Pure structural scene-move locks (e.g., for VERVE: the `[he did not have a weekend.]` bracket close, the 🫡 emoji final words, the "Open the book." final line) remain bidirectionally locked — they are scene-move locks, not text-content locks.

**If the calibration artifact specifies chat-format/code-fence exclusions**, the editor's default Gates (subject-drop, predicate-only, verbatim-echo, etc.) do NOT fire inside code fences (chat blocks). Chat-format material follows separate chat-naturalism rules in the reading guide.

**Drafting-run instruction transposition.** Some `READING_GUIDE.md` and `input/artifacts/` instructions were written for the earlier drafting pipeline and still mention `long_novel_task.md`, `scripts/quality_gate.sh`, `output/`, `output/tics.md`, `output/revision_plan.md`, `output/outline/skeleton.md`, drafting-phase numbers (Phase 4 skeleton, Phase 6 chapter cards, Phase 8 revision), or "before chapter cards are built." Treat those as provenance and craft guidance, not as commands to create the old drafting workspace or restart the drafting pipeline. Transpose any still-relevant requirement into this editor run:
- `output/` paths become `output_edit/` paths.
- `output/tics.md` becomes `output_edit/running_jokes.md` plus `output_edit/calibration/tic_tracker.md`.
- Missing drafting scripts such as `scripts/quality_gate.sh` do not block the editor; implement their named universal-bad-pattern checks through the Phase 4/5 audits and save the result under `output_edit/audits/`.
- Skeleton/chapter-card phase labels describe the already-drafted artifacts in `input/artifacts/`; they do not override this editor's six-phase process.

**Known handoff conflicts / mechanical preflight notes.** Resolve these before final assembly and document the resolution in `output_edit/diagnosis/conflicts.md` or the relevant revision memo:
- Current draft inventory is 86 chapters, no missing chapter files, approximately 172,755 words. Treat the manuscript as complete Draft 0, not a placeholder.
- `input/draft/chapter_80.md` currently lacks a Markdown chapter heading even though the chapter card names it `Anthropic: We Do Not Want To`. Do not edit `input/draft/`; restore a unique output heading such as `# 80. Anthropic: We Do Not Want To` during revision/final assembly.
- The premise and calibration quote the §16 close as `Open the book.` with a period; several drafting artifacts and `input/draft/chapter_85.md` omit the period. The premise/calibration are the exact-text authority unless the editor explicitly records a conflict and gets human direction. Final assembly must not silently drift this locked line.

After the transposition rules above, the reading guide and calibration artifact supersede this task prompt where they conflict on book-specific editorial standards. This task prompt is process scaffolding; the reading guide and calibration are book-specific calibration.

## Six-phase architecture

The editor proceeds through six phases. The phases are logical, not strict — adapt as the manuscript and binding standard require. The 96-hour budget should be allocated roughly: Phase 1 (cold diagnosis) ~6 hours; Phase 2 (re-architecture) ~2-4 hours; Phase 3 (calibration + trackers + voice cards) ~4-8 hours; Phase 4 (revision) ~50-60 hours; Phase 5 (cold reads + book-level audits) ~10-15 hours; Phase 6 (final assembly) ~6-10 hours.

### Phase 1 — Cold diagnosis

Read the premise, reading guide, calibration artifact, and entire manuscript draft (cold, before opening any drafter artifacts in `input/artifacts/`).

**Phase-gated reading order:**
- Phase 1 reads ONLY `input/premise/` + `input/draft/`. Do NOT open `input/artifacts/` in Phase 1.
- `input/artifacts/` opens in Phase 2 as writer-intent evidence (story_bible, skeleton, chapter_cards, voice cards, tics tracker). Not authoritative.

Phase 1 produces:
- `output_edit/diagnosis/cold_read.md` — Claude cold read of the manuscript without drafter context. Identifies drift from binding standard at the whole-book level.
- `output_edit/diagnosis/cold_read_codex.md` — Codex cold read using a different lens than Claude.
- `output_edit/diagnosis/per_chapter_classification.md` — every chapter classified per intervention severity (see classifications below) with one-sentence rationale.
- `output_edit/diagnosis/binding_standard_drift_report.md` — concrete drift findings grouped by category (e.g., narrator-register drift, sanitization drift, motif distribution drift, comp-author pastiche drift, missed inviolable elements, structural gaps). MUST include an "Author-direction findings" section per reader-impressions artifact entry (if present), with cold-read confirmation / extension / pushback per impression.
- `output_edit/diagnosis/form_distribution_baseline.md` — baseline form distribution of the drafted manuscript (% chat / % close-third / % documentary / % narrator) against reading-guide form-binding targets. Surfaces upstream form drift that Phase 2 surgery should address. Phase 5 Form-Distribution Audit compares against this baseline.

Phase 1's cold reads must be done WITHOUT artifacts open. Reading the drafter's story_bible or chapter cards contaminates the cold-reader perspective and lets the editor inherit drafter blind spots.

### Phase 2 — Re-architecture

Phase 2 is for structural revision: chapter cuts, merges, splits, additions, reorderings, subplot reweighting. Real possibility, evidence-driven from Phase 1 cold reads. The drafter committed a chapter map; the editor has authority to revise it where cold reads surface concrete evidence the revision strengthens the contract.

Common Phase 2 moves:
- **CUT a chapter** that didn't earn its place (drafted but doesn't advance the contract; thin or redundant; weight better held elsewhere)
- **MERGE two chapters** that share a beat and dilute each other
- **SPLIT one chapter** carrying too much load (e.g., a chapter trying to be both a register interlude and a plot move)
- **ADD a chapter** to fill a missed inviolable beat or a structural gap surfaced by Phase 1
- **REORDER** chapters where the drafted sequence weakens the contract's pacing
- **Reweight subplot beats** within or across chapters where chapter-card commitments leave room (add a thread, kill a stalled one, redistribute attention)

Phase 2 outputs:
- `output_edit/plans/surgery_plan.md` — what gets cut, merged, split, added, with cold-read evidence per move
- `output_edit/plans/chapter_sequence_revisions.md` — any reorderings + the new sequence map
- `output_edit/plans/subplot_revisions.md` — subplot-level changes (added / removed / reweighted beats), with evidence

Phase 2 is also when `input/artifacts/` opens. Use the drafter's chapter cards as evidence of writer intent (helpful for understanding what THIS chapter was supposed to do), but the premise + reading guide are authoritative when they conflict with the drafter's intent.

**Constraint:** any Phase 2 surgery must preserve the contract — the premise's committed structural elements, the reading guide's binding length/form distribution, the calibration's inviolable elements (with chat-exchange directionality per below). Surgery that improves the contract is welcome; surgery that fractures it is forbidden.

Phase 2 sizing is evidence-driven. If Phase 1 cold reads produce no structural findings, Phase 2 is brief: confirm structure stands, advance to Phase 3. If Phase 1 surfaces real surgery (cuts, merges, splits, adds, subplot revisions), Phase 2 expands accordingly.

### Phase 3 — Calibration confirmation

Confirm the editor's working palette for Phase 4 revision.

**Mandatory extraction step.** Open `input/premise/verve_register_calibration.md` (or whatever calibration artifact is present) AND `input/premise/READING_GUIDE.md` (or equivalent reading guide). Extract the following VERBATIM (do NOT paraphrase) into `output_edit/calibration/binding_standard.md`, organized by section:

**From the calibration artifact:**
- **All book-specific Gates** (e.g., Gates VERVE-1 through VERVE-N): pattern, examples to ban, allowable form, action — for each gate
- **Directionality of inviolability** carve-outs (every-form-is-a-floor rules; non-chaos-up'able scene-move locks)
- **Inviolable premise text** list (locked exact-text scene moves)
- **Inviolable transgressive register** (slurs / crude threats / sexual specificity / locked captions / locked Discord messages / locked voice memo lines / locked contract specs / etc.)
- **Inviolable scene moves** (structural scene-move locks)
- **Chat-format / code-fence exclusions** for default Gates — note: these may live in the calibration's "Editor calibration notes" section rather than under "Banned moves"; extract from wherever they appear
- **Chapters at highest drift risk** list — used for prioritizing Phase 4 attention and defaulting classification

**From the reading guide:**
- **The Tic Catalog** — workshop sentence patterns, narrator-register-specific tics, character-voice tics, comp-author drift patterns. These supplement the calibration's named Gates and feed into the Plain-Translation Audit
- **Form binding percentages** (e.g., for VERVE: ~60% chat / ~25% close-third / ~10% documentary / ~5% narrator interludes). Phase 5 form-distribution audit checks against these
- **Character-specific care moves and motif caps** (e.g., for VERVE: Drake ≤10, Tuesday ≤14, "love you [X]" ≤8). Phase 5 Motif Audit checks against these
- **Comp-author register markers** to use as anti-pastiche targets (comps are aiming-targets, not imitation-targets). These feed into the Adversarial Register Audit comp-author drift check
- **High-leverage scenes list** — premise-named scenes that MUST LAND at intensity (e.g., for VERVE: Tariq weekend ending, Halberg salute-emoji death, Yuki's mother eyes-open, §16 "Open the book." close, Larry Tarek-coda). Set-Piece Intensity Audit fires on chapters containing these scenes.

The editor's Phase 4 audits inline these verbatim. Paraphrased Gates fire inconsistently; verbatim Gates fire mechanically.

**Phase 3 outputs:**

- `output_edit/calibration/binding_standard.md` — extracted-verbatim Gates + inviolable elements + Gate exclusions + voice rules + register markers (with premise excerpts as samples) + motif caps + character care moves
- `output_edit/calibration/audit_format.md` — prompt templates for every audit defined in audit sections below
- `output_edit/calibration/tic_tracker.md` — drafter's tics tracker (if present) + premise-specific tic patterns from calibration
- `output_edit/calibration/voice_cards/<character>.md` — per-character voice cards (synthesized + amplified; see below)
- `output_edit/critiques/claude/voice_cards/synthetic_audit.md` — VERVE mandatory voice-card synthetic-exchange audit, transposed from the reading guide's legacy `output/critiques/...` path. Claude sees ONLY the voice cards; if voices converge, revise the cards and rerun.
- `output_edit/running_jokes.md` — premise-specified recurring motifs (e.g., for VERVE: Tuesday, "love you [X]", Section 14.3.b, Drake, "Bitch.", terminal emojis). Per motif: cap from reading guide, current count, sharpness baseline
- `output_edit/subplot_tracker.md` — BUILT subplot list (see Subplot tracker BUILD below)
- `output_edit/continuity_timeline.md` — BUILT time-anchored continuity (see Continuity timeline BUILD below)

**Subplot tracker BUILD (not example-copy).** Procedure: (a) start with named subplots from premise + reading guide + chapter cards; (b) cross-reference Phase 1 cold reads for subplots the cold reader identified that aren't on the starter list; (c) for each chapter, ask "what plot threads does this chapter advance?" and add any thread touching >1 chapter. Cross-check against calibration examples (e.g., for VERVE: Mara's parents discovering Dirty Laundry, Aiden's roommate noticing wire transfers, Dion's CovenantEyes, Yuki's committee, Halberg's wife's lawyer, heist-day mechanics). Each row: introduction chapter, last-touched, state, planned next beat, status (alive / stalled / resolved), expected resolution chapter.

**Continuity timeline BUILD.** Identify simultaneity-critical sequences from Phase 1 cold reads + chapter cards (e.g., for VERVE: heist-day morning 9:00-10:26 AM ET across four user locations + Halberg August death minute 11-14 livestream timestamps). Initialize with known events at known timestamps; update per chapter commit. Contradictions are continuity failures.

**Voice cards** (one per close-third POV character):
- **Sufficiency check:** verify `input/artifacts/style_and_voice.md` and any per-character artifact voice cards have sample text + register markers + character-specific tics + crude/cursed/tender range. If missing or thin, synthesize from reading guide character markers + the character's committed chapters + calibration character notes. Save to `output_edit/calibration/voice_cards/<character>.md`.
- **Synthetic-exchange convergence audit (VERVE mandatory):** after building voice cards, call Claude through `scripts/claude_logged_call.sh` with a prompt containing ONLY the voice cards (not premise, skeleton, chapter cards, or manuscript). Ask for 2-3 sample exchanges between likely-to-converge pairs (Halberg + Becca, Aiden + Owen, Dion + Owen, Mara + Yuki, plus any Phase 1-identified risk pair) and audit for voice convergence / LLM-terse rhythm. Save to `output_edit/critiques/claude/voice_cards/synthetic_audit.md`. If voices converge, revise the voice cards and rerun before Phase 4.
- **Amplification (Phase 3 primary, Phase 5 re-amplification window):** if the voice card under-captures the character's register relative to premise specifications (e.g., Aiden's incel register specified more transgressive than the card captures), extend upward — voice card is a FLOOR, not a ceiling. Document amplification with reasoning + premise evidence in the card file. Re-amplification at Phase 5 (if cold reads reveal still-too-narrow) triggers re-classification of the character's chapters as TARGETED for next Phase 4 round; document re-amplifications with timestamped revision history.
- **Authority rule:** when both `input/artifacts/<character>_voice_card.md` and `output_edit/calibration/voice_cards/<character>.md` exist, the editor's version is AUTHORITATIVE.

Phase 3 is load-bearing (~4-8 hours). Without verbatim Gates, a confirmed binding standard, populated trackers, high-leverage-scenes list, and sufficient voice cards, Phase 4 audits fire on wrong patterns.

### Phase 4 — Substantial revision

Chapter-by-chapter targeted revision against the binding standard. For each chapter that Phase 1 classified TARGETED, HEAVY, or REWRITE (plus NEW chapters per Phase 2 surgery plan, plus reclassified SKIPs per Phase 5 re-examination):

1. **Codex prepares chapter packet**: chapter draft (if exists) + drift findings (Phase 1 for TARGETED/HEAVY/REWRITE; Phase 5 for reclassified SKIPs; structural-gap evidence for NEW chapters) + binding-standard excerpts + chapter card if exists (writer-intent context) + applicable calibration samples (§1 narrator sample for narrator interludes; character voice card for close-third — authoritative source is `output_edit/calibration/voice_cards/` if present, else `input/artifacts/`) + tracker entries the chapter touches + high-leverage-scenes entry if chapter contains a premise-named set piece. For NEW chapters, also include adjacent committed chapters (one before, one after) as context.
2. **Claude drafts revision** via `scripts/claude_logged_call.sh --kind chapter_revision --chapter XX`. Claude rewrites the chapter or specific paragraphs/scenes per the drift findings AND per any amplification opportunities the chapter packet flags. Save raw revision at `output_edit/drafts/claude/chapter_XX.round_NN.md` via the wrapper's `--md-out`.
**Defensive audits (steps 3-6 prevent drift in the revision):**

3. **Codex audits Claude's revision** (defensive):
   - **Claude-tic audit** — did the revision introduce Claude's known tics (see Codex and Claude section)? Flag every instance with line number + quoted evidence.
   - **Binding-standard Gate audit** — does the revision honor banned moves from the calibration artifact (e.g., Gates VERVE-1 through VERVE-N, including any close-third human-POV gates)? Flag every instance.
   - **Inviolable-element check** — did the revision touch any inviolable element (locked premise text, locked finsta captions, locked brigade messages, exact scene-ending text)? Flag every instance.
   - **Transgression preservation check** — did the revision sanitize any transgressive element (slurs as register, crude threats, sexual specificity, profane-direct register)? Flag every instance.
   - **Adversarial Register Audit — Codex-on-Claude side** (see Adversarial Register Audit section below). Codex audits Claude's revision for: (a) Claude tics (the list above + premise-specific drift patterns from calibration), (b) comp-author drift (Saunders/Lockwood/Tulathimutte-style pastiche), (c) AI-Dystopia Genre-Cliché register (kafkaesque audit-lock / officer-protagonist-against-machine / surveillance-as-dystopia register vs. premise's VERVE-coded cursed-comic-unhinged register). Verdicts and proposed restorations enter the next revision round. The Claude-on-Codex side runs at step 4 if a Codex parallel revision exists.
4. **Optional Codex parallel revision**: for high-leverage chapters (chapters identified by the calibration artifact as critical, e.g., narrator interludes for some premises), Codex may produce a parallel revision at `output_edit/drafts/codex/chapter_XX.md`. Use parallel revisions sparingly — Claude is the primary rewriter. **If a parallel revision is produced, Claude runs the Adversarial Register Audit Claude-on-Codex side** on it: Claude audits Codex-originated material for Codex tics (arrangement-coded prose, three-item catalogs, thesis closers, taxonomies-disguised-as-narration, em-dash interruptions as emotional substitute) + comp-author drift + AI-Dystopia Genre-Cliché register. Findings union with the Codex-on-Claude side findings into the chapter's revision plan.
5. **Codex writes synthesis memo** at `output_edit/revision_memos/chapter_XX.md`: drift findings addressed, audit findings cleared, what was preserved, what was changed, what (if anything) came from Codex's parallel revision, what amplification opportunities were taken.
6. **Codex integrates accepted revision** at `output_edit/chapters/chapter_XX.md`. Do not average drafts; synthesize line by line. Claude's revision is the base; Codex's parallel revision contributes specific paragraphs/sentences where genuinely stronger.

**Per-chapter audits run on the integrated revision (steps 7-16):**

7. **Plain-Translation Audit** (defensive — catches residual register drift). See audit section below. If audit surfaces residual drift, loop back to step 2 for that chapter — up to 2 revision cycles per chapter before banking residual risk in `output_edit/revision_plan.md` and moving on.
8. **Chaos-Up Audit** (amplification — every form). See audit section below. Applies to every form in the chapter (chats, close-third human-POV interior moves, narrator-prose lines, documentary inserts). Returns per-target verdict: AT-PEAK (with quoted reasoning) or RAISABLE (with concrete proposal). RAISABLE proposals enter the next revision round; AT-PEAK targets are accepted with reasoning recorded. For close-third targets, the audit must name the specific voice-card sample it's measuring against. RAISABLE floor scales with chapter (see Chaos-Up Audit section).
9. **Premise-Register-Density Audit** (amplification — narrator-prose sections). See audit section below.
10. **Chat-Variety Audit** (per-chapter variety + earns-its-place — recurring-character chats). See audit section below. Per-chapter pairwise check; book-level character-arc check moves to Phase 5 Chat Audit.
10a. **Comedy Doctor Audit** (VERVE mandatory). Run on every committed chapter, with extra pressure on VERVE-narrator chapters, chats, public-stage VERVE moments, and procedural/documentary chapters. Calibrate against the target reader named in the reading guide: terminally-online, 25-35, has read Pynchon and `Rejection`, skeptical of AI, allergic to workshop-wit. Verdicts `DRY`, `CRINGE`, `OVERSWEETENED`, `MONOTONOUS`, `CLEAR BUT THIN`, or any item scored partial / portable / workshopped are blocking findings. Save under `output_edit/audits/codex/chapter_XX.comedy_doctor.md`; findings enter the next revision round.
11. **Character-Introduction + Disambiguation Clarity + Dialogue Doctor check** (readability / voice convergence). For any character introduced or reappearing in this chapter, ask: can a first-time reader of this chapter place them? If a reader would need a "wait, who's that?" beat, the chapter must add context (half-sentence reminder, name + identifying detail, callback to prior appearance). ALSO: if two characters in the chapter share surface markers (same last initial, overlapping roles, similar names, same workplace, same first-letter abbreviation), explicitly verify the chapter makes them un-confusable — a careful reader should not be able to mistake character A for character B based on the chapter alone. For substantial chat or quoted-dialogue chapters, especially where the chapter card calls for Dialogue Doctor, audit voice convergence, same-length reply rhythm, LLM-terse cadence, and therapy-default language. Save clarity flags under `output_edit/audits/codex/chapter_XX.intro_clarity.md` and dialogue findings under `output_edit/audits/codex/chapter_XX.dialogue_doctor.md`.
12. **Pacing-Per-Scene check** (readability). Form-specific thresholds:
    - **Chat scenes:** flag if >250 words without a stake-shift
    - **Close-third human-POV scenes:** flag if >400 words without a stake-shift
    - **Narrator-prose paragraphs:** flag if >800 words without a stake-shift (allowing for premise's signature hammer-paragraphs at higher density)
    - **Documentary-insert sections:** flag if >300 words without a stake-shift or new revelation
13. **Opening Hook check** (readability — every chapter). See audit section below. First 50 words of the chapter: PULLS or WEAK with proposed alternative.
14. **Surprise Audit** (amplification — every chapter). See audit section below. Identify the chapter's surprise move; if none, flag for amplification proposals.
15. **Set-Piece Intensity Audit** (only fires on chapters containing premise-named high-leverage scenes; identified in Phase 3 extraction). See audit section below. Returns HITS or FLAT-WITH-MISSES per set piece.
16. **Counter-Strip Audit** (anti-over-correction — every revised chapter). See audit section below. Sample 5-10 cut lines from pre/post-revision diff; ask if any cut was over-zealous. Returns NONE OVER-CUT or OVER-CUT with restoration list.

**Tracker updates (step 17, runs on every chapter commit):**

17. **Codex updates living trackers:**
    - `output_edit/subplot_tracker.md` — update last-touched chapter and current state for any subplot the chapter touched.
    - `output_edit/running_jokes.md` — increment counts for any premise-specified recurring motifs the chapter used; grade each occurrence (sharp / acceptable / weak); flag weak ones for the Chaos-Up Audit or next-round revision.
    - `output_edit/continuity.md` — log new continuity facts established by the chapter (dates, character knowledge state, plot beats committed). **Immediate reconciliation:** before committing the chapter, cross-check new facts against existing tracker entries. Any contradiction (e.g., chapter 30 says X knew Y by chapter 8 but chapter 8 doesn't show it) triggers immediate revision of either the chapter or the prior entry — do NOT defer to Phase 6.
    - `output_edit/continuity_timeline.md` — for any chapter with simultaneity-critical events (e.g., for VERVE: heist day morning, August death minute 11-14), update the timeline with the chapter's contribution at the recorded timestamp. Contradictions with prior timeline entries trigger immediate reconciliation.

Chapters classified SKIP in Phase 1 do not enter Phase 4 substantial revision. They may receive (a) light continuity polish (name/date/fact corrections), and (b) Chaos-Up edits if Phase 5 re-examination's Chaos-Up Audit surfaces RAISABLE verdicts. Other prose-level changes are forbidden for SKIP chapters. Phase 5 cold reads re-examine every SKIP chapter (see Phase 5).

**SKIP-with-chaos-up flow.** When Phase 5 Chaos-Up on a SKIP chapter surfaces RAISABLE but cold read confirms no drift:
- Codex prepares a narrow revision packet (RAISABLE targets only); Claude drafts only the chaos-up edits.
- Steps 3-6 run on the narrow scope (defensive audits, synthesis, integration).
- **Steps 7 + 8** re-run on the chaos-up edits (Plain-Translation: no drift introduced; Chaos-Up: edits landed).
- **Step 16 (Counter-Strip)** fires on the narrow scope (catches over-correction in chaos-up edits).
- Steps 9-15 SKIPPED (already satisfied at Phase 1 SKIP classification or not relevant to narrow scope).
- Step 10a runs if the chaos-up edit touches comedy-bearing material.
- Step 17 tracker updates run normally.

**Cross-chapter Phase 4 mechanisms (run alongside per-chapter revisions):**

- **Periodic register-drift audit every 15 committed chapters.** After every 15 chapters committed in Phase 4, run a character-voice-consistency audit comparing recent-committed chapter samples to earlier-committed samples for the same character (e.g., Aiden's voice in chapter 50 vs. chapter 12). Save under `output_edit/audits/codex/register_drift_periodic_NN.md` (NN = audit number, 1, 2, 3...). Findings enter the next revision queue.
- **Subplot tracker review every 15 committed chapters.** Inspect `output_edit/subplot_tracker.md` for stalled subplots (no touch for >15 chapters) or dropped subplots (alive at last touch but no planned next beat). Surface findings to revision queue. Phase 5 audits the tracker for completeness.
- **Running-joke sharpness review every 15 committed chapters.** Inspect `output_edit/running_jokes.md` for motifs with high weak-occurrence ratios. Flag for amplification in next-round revision (sharpen weak instances; consider cutting redundant ones near caps).

### Phase 5 — Whole-book pressure

After Phase 4, run full-book cold reads:
- `output_edit/cold_reads/whole_book_claude.md` — Claude full-book cold read on the assembled revised manuscript. Identifies residual drift, missed inviolable elements, motif distribution problems, continuity issues, ending strength, register consistency across chapters, pacing collapse, dropped subplots, lost-reader moments.
- `output_edit/cold_reads/whole_book_codex.md` — Codex full-book cold read from a different lens.

**Mandatory Phase 5 sub-audits:**

- **SKIP re-examination + Chaos-Up coverage.** Re-examine every Phase 1 SKIP-classified chapter against the binding standard during the cold read AND run the Chaos-Up Audit on the SKIP chapter (this is where SKIPs get their Chaos-Up coverage required for final assembly). Three outcomes:
  - Cold read surfaces drift findings → reclassify TARGETED / HEAVY / REWRITE; enter next Phase 4 round with chapter packet built from Phase 5 findings (see Phase 4 step 1 reclassified-SKIP variant).
  - Cold read confirms SKIP but Chaos-Up Audit surfaces RAISABLE → SKIP-with-chaos-up flow (see Phase 4 SKIP-with-chaos-up flow specification).
  - Cold read confirms SKIP and Chaos-Up returns all AT-PEAK with reasoning → confirmed SKIP.
- **Subplot tracker audit.** Inspect `output_edit/subplot_tracker.md` for stalled subplots (no touch for >25 chapters), unresolved subplots, subplots resolved off-page without earned setup, or subplots that appear in cold reads but were never on the tracker (tracker incompleteness).
- **Motif Audit (consolidated).** See audit section below. Replaces prior separate Running-Joke distribution + Arc audits. Per motif: distribution (under cap? clustered?), per-occurrence sharpness (rolled up from Phase 4 tracker grading), arc check (builds / escalates / shifts / pays off, or static?).
- **Chat Audit (consolidated, book-level).** See audit section below. Replaces prior separate Chat-variety pass + Per-Character Chat-Arc audits. Per recurring chat character (>3 chapters): pairwise variety extension + arc-level escalation summary.
- **Pacing-per-chapter pass.** Identify chapters that read as draggy / over-long / under-stake-shifted relative to surrounding chapters. Surface findings as candidates for TARGETED revision or (rarely) CUT.
- **Form-Distribution Audit.** Compare final form distribution against Phase 1 baseline AND reading-guide form-binding targets (e.g., for VERVE: ~60% chat / ~25% close-third / ~10% documentary / ~5% narrator). Surface any drift.
- **Opening Hook Audit (book-level — Chapter 1 + Part-openings).** Per-chapter hooks were checked at Phase 4 step 13; Phase 5 elevates Chapter 1 and every Part-opening for "does this commit a first-time reader through the entire first scene?"
- **Ending-Earn Audit.** See audit section below. Final chapter(s) and any coda: does the ending EARN, do callbacks pay off, does the locked final line LAND?
- **Book-Level Comedy/Derangement Arc Audit.** See audit section below. Verify the chaos arc builds / has intentional valleys / doesn't invert.
- **Voice Card Re-amplification Check.** For each close-third character, ask: did Phase 4 revisions reveal the voice card is still too narrow? If yes, re-amplify (Phase 3 rules apply); re-classify the character's chapters as TARGETED for next Phase 4 round with the re-amplified card as the new comparison standard.
- **Reader-engagement + Aftermath cold read.** Both cold-read models should explicitly answer: "Where did you feel like skimming? Was there any character introduced where you couldn't place who they were? Did the chapter ordering lose you? Where did interest drop off? Did any plot beat confuse you? Did any chat feel like a slog? Where did you feel surprised — and where did you feel like you saw it coming?" For premises with substantial aftermath sections (e.g., for VERVE: ~60K words across 3 days to 18 months after the major reveal), additionally: "Did interest drop after the major reveal (act-3 sag)? Did POV shifts cost the reader? Did time-scale shifts lose the reader? Are all required aftermath beats present per the reading guide's high-leverage-scenes list?"

Phase 5 generates a per-chapter targeted-revision queue for any residual drift, subplot resolution, running-joke distribution fixes, pacing/engagement findings, or chat-variety issues. Loop back to Phase 4 for those chapters. Repeat Phase 5 → Phase 4 until both cold reads produce no high-leverage findings or the wall-clock approaches Phase 6 budget.

### Phase 6 — Final assembly

See "Final assembly" section below.

## Codex and Claude — role assignment

Codex (you, running GPT-5.5 with extra-high reasoning) is the orchestrator. Claude Fable 5 (xhigh effort) is the prose writer.

**Codex (orchestrator / editor-in-chief)**
- Reads the binding standard
- Owns Phase 1 cold diagnosis (in parallel with Claude's cold diagnosis)
- Owns Phase 2 surgery decisions (if any)
- Owns Phase 3 calibration consolidation
- Owns per-chapter intervention classification
- Builds chapter packets that direct Claude's rewriting
- Audits Claude's revisions against Claude's known tics + binding-standard Gates + inviolable elements + transgression preservation
- Optionally produces parallel revisions for high-leverage chapters
- Synthesizes Claude+Codex revisions into accepted chapters
- Integrates accepted revisions
- Performs final assembly

**Claude (rewriter / cold-reader critic)**
- **Performs the manuscript prose revisions for every chapter classified TARGETED, HEAVY, or REWRITE**
- Provides line-level repairs for TARGETED chapters
- Performs full-book cold reads in Phase 1 and Phase 5
- Provides cold-reader critiques independent of Codex
- Verifies revisions when targeted

For every committed chapter revision, **Claude must produce the revised prose**. Codex's role is to direct (chapter packet, drift findings, binding-standard excerpts), to optionally provide a parallel revision for high-leverage chapters, to synthesize, to integrate, and to judge. **Codex must not skip Claude's revision and rewrite the chapter alone.** If Claude is unavailable for a chapter, defer that chapter as provisional, queue it, and proceed with non-prose work (cold reads, plan refinement, diagnostic work); do not let Codex backfill the revision.

This rule exists because Codex's prose has measurably different defaults than Claude's: Codex tends toward arrangement, taxonomies, three-item catalogs, and thesis closers; Claude tends toward physical specificity, concrete blocking, and fewer maxims. For prose-quality-first editing, Claude is the rewriter.

**Claude has its own LLM defaults that Codex must audit Claude's revisions against.** The role assignment is asymmetric for prose generation, symmetric for tic-policing. Claude's prose defaults to watch for:

- Em-dash overuse and em-dash-as-rhythm-crutch
- "Shimmer" prose: over-poetic adjective stacks, atmospheric drift in places that need action
- Recurring sentence-mood verbs ("mattered," "earned," "weighed," "carried")
- Default-elegant noun phrases ("a kind of," "something like," "a small / quiet / careful X")
- Habitual qualifiers and softening adverbs that drain momentum
- Narrator-as-philosopher voice intrusion — wisdom inserts mid-scene
- Subtle theme-explanation through narrator gloss after a beat lands
- Recursive negation patterns ("not X, not Y, not even Z")
- Self-aware meta-clauses ("if that was the word for it")
- Over-balanced sentence structures with parallel clauses
- Scene-end profundity-stamp short sentences
- Default "lovely / quiet / small" register applied to scenes that should be ugly, big, or loud
- Defaulting to physical reaction beats (heartbeat, throat tightens) when interior thought would do more work

These tics must be audited on every Claude revision. The calibration artifact may specify additional book-specific tic patterns to track.

**When Claude is unavailable.** A short outage (rate-limit window, transient failure): wait. A long outage (multi-hour, hard limit): Codex continues non-prose work but does NOT backfill prose revisions.

**During Claude outages, Codex MAY run** any non-prose work: cold reads (Codex lens), surgery planning, calibration consolidation, tracker work, voice-card synthesis/amplification, periodic register-drift audits, the Codex-on-Claude side of Adversarial Register Audit (incl. comp-author drift), and all Codex-runnable audits (Motif, Chat, Form-Distribution, Pacing, Character-Intro, Opening Hook, Surprise, Set-Piece, Counter-Strip, Ending-Earn, Book-Level Comedy/Derangement Arc, Voice Card Re-amplification). **Codex MUST NOT** backfill prose revisions or run Claude-required audits (Plain-Translation, Chaos-Up, Claude-on-Codex Adversarial Register). Provisional chapters lacking Claude pressure must be called out in `final_report.md`.

**Claude command shape.** Use `scripts/claude_logged_call.sh`. The wrapper enforces the Fable-5-xhigh-effort command shape internally, logs every call, captures stream output, extracts assistant text to a Markdown file when `--md-out` is supplied, and serializes Claude calls. Save prompts under `output_edit/model_prompts/claude/<kind>/<id>.md`. Stream outputs go under `output_edit/audits/claude/` or `output_edit/drafts/claude/` as appropriate. No internal timeout — kill decisions are yours, made conservatively. Direct `claude -p` invocation outside the wrapper is forbidden — provenance must be mechanical.

**Claude call patience.** Fable 5 xhigh-effort calls regularly take 12-18 minutes wall clock with extended silent thinking phases that produce no streaming tokens. **Chapter-revision calls can run 30-60 minutes for a substantial rewrite.** Do not kill a call as "hung" unless the stream file's modification time has not advanced for at least 5 minutes AND total wall clock exceeds 25 minutes (general calls) or 60 minutes (chapter-revision calls). Both conditions must hold. Killing a call that would have completed is more expensive than waiting another 10-30 minutes.

## Chapter intervention classifications

Per-chapter classification in Phase 1 (cold diagnosis), confirmed in Phase 4:

- **SKIP** — chapter already matches the binding standard. No revisions needed. Light continuity polish allowed.
- **TARGETED** — chapter is mostly correct; specific drift findings need targeted revision (paragraph-level, sometimes scene-level). Most chapters in a well-drafted manuscript should be TARGETED.
- **HEAVY** — chapter has significant drift in multiple dimensions (register, motif, sanitization). Paragraph-level revisions throughout, sometimes whole-section rewriting. Reserved for chapters with substantial drift findings.
- **REWRITE** — chapter is structurally OK but the prose drifts so severely that paragraph-level repair won't restore the binding register. Rare. Reserved for cases like a narrator interlude that has fully drifted into literary-essay register and needs to be redrafted against the binding sample.
- **CUT** — chapter does not earn its place: drafted but doesn't advance the contract, is thin / redundant / weak, fails a reader-impression check, fails reader-engagement audits, is procedural-horror-fest without comic-cursed work, has set pieces returning FLAT-WITH-MISSES that can't be salvaged, etc. Surface as a CUT proposal in Phase 1 / Phase 5 cold reads with concrete chapter-level evidence; Phase 2 surgery plan ratifies. **Cuts must be EVIDENCE-DRIVEN at the chapter level.** Reader-impression matches count as evidence. Audit failures count as evidence. Cold-read engagement findings count as evidence. "The manuscript is over the floor" is FORBIDDEN reasoning (vel-failure pattern). See Length section.
- **NEW** — Phase 1 / Phase 5 cold reads surface a missed inviolable beat, a structural gap, or a needed register/form rebalance that calls for a new chapter. Rare but permitted. The new chapter must serve the contract, not editorial preference. Phase 2 surgery plan ratifies; Phase 4 drafts the new chapter through the same chapter-packet → Claude-revision → audit flow as any other chapter, with the chapter packet built from the structural-gap evidence rather than an existing draft.

For chapters in the highest-drift-risk category specified by the calibration artifact (e.g., narrator interludes for some premises), default to HEAVY at minimum unless cold reads show the chapter already matches the binding standard.

## The Plain-Translation Audit (recalibrated)

The Plain-Translation Audit is the editor's primary tool for catching prose drift. Generative-not-evaluative: produce a plain-English rewrite of the original prose, then compare. Asking either model "is this prose good?" produces unreliable answers — both models have a documented bias toward performed-literary register when evaluating. Asking either model to "rewrite as the binding-register version and compare" produces a concrete on-the-page comparison whose verdict is harder to evade.

**Critical recalibration for this run:** the "plain" version is the BINDING-REGISTER version, not generic-clarity prose. Compare the original paragraph against:
- The binding-register sample for that chapter's form (narrator-register if narrator interlude; chat-register if chat block; close-third-register if close-third human POV; documentary-register if documentary insert)
- The premise's specific calibration samples (e.g., §1 narrator sample, premise chat samples, premise documentary samples) — name the specific sample in the audit prompt

The audit asks: *"Is the binding-register version measurably worse than the original on information density, dramatic content, AND binding-standard fidelity?"* If the binding-register version preserves what the original was doing without the drift, the binding-register version replaces.

Form-specific calibration:
- **Narrator-interlude chapters**: compare against the premise's narrator calibration samples (e.g., §1 / §16 if the premise has them). Also run the Premise-Register-Density Audit (see below).
- **Chat chapters**: compare against the premise's chat-register samples; do NOT plain-translate to literary-clarity prose. The chat register is binding even when it violates standard subject/article-density gates. Plain-Translation Audit does NOT apply to chats — chats get the Chaos-Up Audit instead.
- **Documentary inserts**: compare against documentary-form calibration in the reading guide.
- **Close-third human-POV chapters**: compare against the character's voice-card sample (from the reading guide or `input/artifacts/` voice cards), NOT generic-clarity prose. The audit asks "is the character-voice-card-aligned version measurably worse than the original on character interiority, scene work, AND binding-standard fidelity?" Generic-clarity audits strip close-third voice. The audit must name the specific voice card sample it's comparing against in its prompt. Also apply Gates VERVE-7 through VERVE-13 (close-third human-POV gates).

**Inviolable elements are never plain-translated.** The calibration artifact specifies what's inviolable. The Plain-Translation Audit must skip those passages entirely.

**Chats and documentary inserts use the Chaos-Up Audit instead — Plain-Translation does not apply to them.**

**The Aphorism Gate is universally applied at zero tolerance** unless the calibration artifact specifies otherwise. Any line in the manuscript that reads as a portable maxim — quotable out of context, marketing-pull-quote-shaped, tattoo-able, chapter-epigraph-shaped — is a Gate failure. This applies especially to VERVE-narrator-style chapters where literary-essay register tends to install pull-quote shapes. The Aphorism Gate overrides any rule asking the editor to "engineer quotable moments"; if the calibration artifact says no portable maxims, no portable maxims survive.

**The Verbatim-Echo Gate is universally applied** — any non-transformative verbatim repetition between speakers or between sentences is a failure, except where the calibration artifact specifies motif-repetition as deliberately load-bearing.

Save Plain-Translation Audit outputs under `output_edit/audits/claude/chapter_XX.plain_translation.md`.

## The Adversarial Register Audit

Separate from the Plain-Translation Audit. Cross-model defensive pass run on every chapter that received non-trivial revision:

- **Claude audits Codex-originated material** (any Codex parallel revision, Codex's synthesis decisions where Codex changed Claude's draft material) for Codex tics: arrangement-coded prose, three-item catalogs, thesis closers, taxonomies-disguised-as-narration, em-dash interruptions used as emotional substitute for content.
- **Codex audits Claude-originated material** (Claude's revisions) for Claude tics: the list above + premise-specific drift patterns from the calibration artifact.

**Comp-author drift check.** For both directions of the audit, additionally ask: does this revision read like one of the reading-guide's named comp authors (e.g., for VERVE: Saunders, Lockwood, Tulathimutte, or whoever the reading guide lists as comps)? Comps are aiming-targets, not imitation-targets — pastiche of any comp is a Gate failure. The auditor names the specific comp author the prose drifted toward and quotes the specific passage. Comp-author drift findings enter the next revision round.

**AI-Dystopia Genre-Cliché Check.** Different from comp-author drift: catches genre-default register, not named-author pastiche. For each chapter, additionally ask: is this chapter delivering institutional-AI-horror in the PRESTIGE-FICTION GENRE'S STANDARD REGISTER (kafkaesque audit-lock, officer-protagonist-trying-and-failing-against-machine, surveillance-as-dystopia mood, system-flag-cannot-be-removed, AI-makes-wrong-decision-human-can't-fix-it, the *Severance / Black Mirror / Mr. Robot* register) rather than in the premise's VERVE-coded cursed-comic-unhinged register? Verdict: **GENRE-CLICHE** (with specific examples of the cliché register) or **VERVE-CODED** (with specific examples of the premise's distinct register). GENRE-CLICHE findings enter the next revision round with HIGH priority — readers have read this register dozens of times in AI-dystopia novels and the premise wants weirder than that. Indicators of GENRE-CLICHE: officer-voice + system-outputs + audit-lock mechanic + tender-victim-shown-through-paperwork + no VERVE voice intrusion + no character with cursed-comic specificity beyond competent-officer-register + endpoint inventories that are sinister-realistic rather than cursed-comic-funny. Indicators of VERVE-CODED: VERVE register traces in system outputs (unauthored lines, system glitches that are VERVE moves), characters whose voice cards have specific cursed humanity beyond their institutional role, endpoint/system-detail naming that is cursed-comic-funny not just sinister-realistic, comic-specificity that makes the reader laugh while horrified (not just horrified).

Save under `output_edit/audits/claude/chapter_XX.adversarial_register.md` (Claude on Codex) and `output_edit/audits/codex/chapter_XX.adversarial_register.md` (Codex on Claude). Findings union into the chapter's revision plan.

Each model auditing the other against patterns the model itself would not produce surfaces blind spots a same-model audit cannot. This is the editor's defining cross-model method; do not skip it on revised chapters.

## The Chaos-Up Audit

Run on every chapter — including narrator interludes, close-third human-POV chapters, chat-dominant chapters, and documentary-insert sections. Chaos-Up is the editor's general-purpose amplification audit: the inverse of the Plain-Translation Audit's defensive posture.

The audit asks, for each form-appropriate target in the chapter:

> "Where is the bit / image / threat / move / observation / character beat / non-sequitur muted? What would the more unhinged, more cursed, more pointed, more hilarious, more entertaining version look like, WITHIN the form's constraints? Show the chaos-up rewrite alongside the original."

Generative-not-evaluative: produce the chaos-up version, then compare. The chaos-up version replaces if it's genuinely sharper without violating form constraints.

The Chaos-Up Audit is **one-directional**: it can RAISE the chaos-register, never LOWER it. Edits that soften, sanitize, "literary-translate," or smooth-out are sanitization drift and fail. A "lower" verdict is impossible by design.

### Form-specific operations

The audit operates differently per form. Form constraints determine what "chaos-up" can do without breaking the chapter.

**Chats (including premise-quoted chats).** Target: every chat exchange. Operations: sharper bits, more cursed images, weirder non-sequiturs, sharper threats, funnier turns, more pointed VERVE annotations. Constraints: voice consistency per character, lowercase-no-closing-period chat register (for VERVE-style premises), character-specific markers, no breaking of chat voice into narrator's literary register. **Permission is the default for premise-quoted chats** — the premise version is a FLOOR, not a ceiling. Bias toward "find the raise," not "leave it alone."

**Close-third human-POV chapters.** Target: the POV character's interior moves, observations, dialogue beats, scene-perception details. Operations: sharpen the character's existing voice in their established register — sharper interior thoughts, weirder observations, more pointed dialogue, more specific cursed/funny details where the character is naturally crude/cursed/specific. **Critical constraint:** chaos-up within the character's voice card, never against it. If a character is naturally tender (e.g., Tariq's compressed care), chaos-up sharpens the sting/heartbreak/specificity — NOT cursed-content-for-its-own-sake. If a character is naturally crude (e.g., Aiden's incel-coded register), chaos-up sharpens THAT register. Voice bleed (character drifting toward narrator's literary register, or toward another character's voice) is a failure. The audit must name the specific voice-card sample it's measuring against.

**Narrator interludes.** Target: specific narrator lines, observations, conspiracy beliefs, direct threats, crude images. Operations: sharper individual moves at the line level. **Companion audit:** the Premise-Register-Density Audit (see below) measures aggregate counts (conspiracy beliefs per 1K words, etc.); Chaos-Up Audit sharpens individual moves. Both run on narrator chapters. Constraints: stay in VERVE's premise register; don't introduce moves the premise doesn't sanction; the existing Gates VERVE-1 through VERVE-6 still fire.

**Documentary inserts.** Target: Discord-message text, finsta caption text, voice-memo transcripts, livestream-chat replays, contract-spec text, brigade-thread posts, any other premise-format documentary artifact. Operations: sharper bits within the format's constraints (Discord-message-shape; voice-memo-transcript-shape; contract-paperwork-shape). Constraints: format integrity must hold; the "documentary" framing depends on artifacts looking like artifacts. **Permission is the default for premise-quoted documentary text** — same floor-not-ceiling logic as chats.

### Coverage requirement

Every chapter (every form) must receive an explicit Chaos-Up Audit verdict per applicable target:
- **AT-PEAK** with specific quoted reasoning for why named lines cannot go harder, OR
- **RAISABLE** with at least one concrete proposed rewrite (original line + chaos-up version + why it's sharper)

A bare "no change" verdict without per-target reasoning is a FAILED audit, not a passing one. The audit returns a list of verdicts grouped by form. Codex spot-checks: any target marked AT-PEAK without specific reasoning gets re-audited.

**RAISABLE floor (anti-rationalized-AT-PEAK pressure).** The audit must propose RAISABLE edits at a rate that scales with chapter length and form-mix, with minimum 2 per chapter unless the chapter is genuinely in the top 10% of pre-edit chaos density across the manuscript (with specific reasoning citing which premise register markers the chapter already meets at peak):

- **1 RAISABLE per chat exchange** in the chapter (minimum, scaled with chat count)
- **1 RAISABLE per 1500 words of narrator prose** in the chapter
- **1 RAISABLE per 1000 words of close-third prose** in the chapter
- **1 RAISABLE per documentary insert** in the chapter
- **Floor: minimum 2 per chapter regardless**

So a 5000-word chapter with 8 chats + 1500 words narrator prose has RAISABLE floor of 8+1 = 9. A 1500-word narrator interlude has floor of 2 (minimum). A 4000-word close-third chapter with 2 chats has floor of 2+4 = 6.

The default expectation is RAISABLE-dominant verdicts on most chapters, especially in Phase 4 round 1. A chapter where every target returns AT-PEAK is suspicious; Codex re-audits with explicit adversarial framing: *"if you HAD to find SOMETHING in this chapter that could go sharper, weirder, more cursed, or funnier, what would it be? You may not return 'nothing.' Propose at least one raise even if it's marginal."* This counter-pressure prevents the audit from becoming performative.

**For premise-quoted text in any form**, permission is the default. The premise-locked version is a floor. Examine line by line: if a bit could go sharper, an image could go more cursed, a beat could land funnier without breaking the form, raise it. Do not bias toward "leave it alone."

Save under `output_edit/audits/claude/chapter_XX.chaos_up.md`. The audit output is grouped by form (one section per applicable form in the chapter) so revision rounds can target form-by-form.

## The Premise-Register-Density Audit (narrator chapters)

Narrator chapters have no chat-format equivalent of the Chaos-Up Audit. The Premise-Register-Density Audit fills that gap with the same amplification-not-defense posture.

For each narrator-interlude chapter (and any chapter with substantial narrator-prose sections), measure register-density markers against the §1/§16 binding samples from the premise:

- **Conspiracy-belief density.** Count "I believe X" or equivalent conspiracy assertions per ~1000 narrator-prose words. §1 baseline: ~25 in one hammer-paragraph. If the chapter's density is substantially below baseline (e.g., <50% of expected), flag for expansion with specific premise beliefs that could be restored (Younger Dryas, Frasier 1996 episode, Aretha Franklin silence, Bigfoot Soviet, Operation Mockingbird, Howard Hughes Andalusia, ICE-Veracity API, DOGE-LLM, etc.).
- **Direct-threat density.** Count direct threats / dox references / Upwork-boxer references / "punch you in the face in real life"-style direct claims. If the chapter has only contract-paperwork-coded threats and no direct-threat-coded ones, flag for restoration of the direct-threat register alongside the paperwork.
- **Crude-image density.** Count crude images (punch in face, dox, sexual specificity, slurs-as-register). If the chapter substitutes charming/elegant images for crude premise images, flag for crude-image restoration (per Gate VERVE-6).
- **Anaphoric repetition density.** Count anaphoric patterns ("I have read the surveys. I have also read the chats." / "before the news, before his children, before God"). If the chapter has no anaphora, flag for restoration.
- **Terminal-one-word punctuation.** Does the chapter (or any paragraph close) end with a one-word terminal punch ("Bitch.", "Yeah.", "No.", "Open the book.")? If not, flag for consideration.
- **Specificity density.** Count specific dollar amounts, named cultural artifacts at calibrated density, real platform/company names, real city/place names. If the chapter has substituted abstractions ("a city," "a sum of money," "an executive") for premise specifics ("Tampa," "$14,000," "Reed Halberg"), flag for specificity restoration.

The audit returns concrete additions with proposed text, not generic "increase density" notes. Save under `output_edit/audits/codex/chapter_XX.density.md`.

The Premise-Register-Density Audit is **one-directional**: it can RAISE density toward §1/§16 baseline, never lower it. A chapter at or above baseline is AT-PEAK with reasoning. A chapter below baseline returns specific proposals.

**Coverage requirement.** Every narrator-interlude chapter (and any chapter with >500 words of narrator prose) receives an explicit Premise-Register-Density verdict. Same coverage discipline as Chaos-Up Audit: AT-PEAK with reasoning, or BELOW-BASELINE with proposals.

## The Chat-Variety Audit

Run on every chapter containing chats with recurring characters (i.e., characters who appear in chats in multiple chapters).

For each chat in the chapter, compare against prior chats with the same speakers on:
- **Relational stake-shift.** What changed between them this chat versus their last chat? If nothing changed, the chat is topic-substituted.
- **Format.** Different chat shape (short / long / bracketed-annotated / footer-style / livestream-replay)?
- **Length.** Substantially different from prior chats with the same speakers, OR justified-as-same-length by stake?
- **Temporal mode.** Different time-stamp / time-of-day / narrative-time context from prior chats?
- **Comedic register.** Different register beat (cursed / tender / paperwork / non-sequitur / direct-threat)?

ALSO ask, regardless of distinctness from prior chats:
- **Earns-its-place criterion.** Does this chat carry comedy, cursedness, pointedness, transgression, or genuine revelation? Would a reader skim this chat to get to the next one? A chat that's technically distinct from prior chats but still BORING — flat in comedic register, no cursed beat, no payoff, no character revelation — fails the audit regardless of variety dimensions. The criterion: each chat must earn its page-count by being funny, cursed, pointed, or revealing.

Flag chats that read as topic-substituted repetitions OR fail the earns-its-place criterion. Flagged chats enter the next revision round with the question: *"what relational stake-shift, format, length, temporal mode, register beat, or comedic/cursed payoff distinguishes this chat? And if nothing, can it be chaos-up'd to earn its place, cut entirely, or merged with another chat?"*

Save under `output_edit/audits/codex/chapter_XX.chat_variety.md`.

## The Opening Hook Audit

Per-chapter check on the first 50 words: does the opening pull the reader forward, or is it scene-setting throat-clearing?

Verdict: **PULLS** (with reasoning) or **WEAK** (with proposed alternative).

**Chapter-1 + Part-opening (Phase 5 elevation):** would the opening commit a FIRST-TIME reader through the entire first scene (not just first 50 words)? Locked beats (e.g., for VERVE: Tariq's bracket ending) inviolable in text; surrounding prose revisable.

Save under `output_edit/audits/codex/chapter_XX.opening_hook.md` (per-chapter) and `output_edit/audits/codex/book_openings.md` (Phase 5).

## The Surprise Audit

Per chapter: identify the surprise move — the turn the reader doesn't predict. Categories: plot turn / character revelation / register shift / cursed image / format break / comedic non-sequitur.

Verdict: **SURPRISES** (with the move quoted) or **PREDICTABLE** (with proposed additions).

"Generally surprising" without a specific quoted move is a FAILED audit. Surprise density is the highest-leverage virality lever.

Save under `output_edit/audits/codex/chapter_XX.surprise.md`.

## The Set-Piece Intensity Audit

Fires on chapters containing premise-named high-leverage scenes (identified in Phase 3 extraction). For each set piece: quote the premise spec + the chapter's rendering. Does the surrounding prose make this beat LAND, or does it bury / soften / decorate?

Verdict: **HITS** (with reasoning) or **FLAT-WITH-MISSES** (with concrete surrounding-prose revisions).

Zero tolerance — a "fine" set piece is a failed set piece. FLAT-WITH-MISSES is HIGH-priority.

Save under `output_edit/audits/codex/chapter_XX.set_piece.md`.

## The Counter-Strip Audit

On every revised chapter (including SKIP-with-chaos-up edits on the narrow scope), sample 5-10 cut lines from the pre/post diff. Per cut: was it justified by a Gate / drift / sanitization / audit finding, or was it editor over-zealousness?

Verdict: **NONE OVER-CUT** (with per-cut reasoning) or **OVER-CUT** (lines to restore + which audit mis-fired).

Log mis-firing patterns to `output_edit/calibration/audit_calibration_notes.md` for future tuning.

**Impression-aware calibration.** If `reader_impressions.md` flags this chapter or this pattern (e.g., "Yuki chapters too quiet" / "public-stage VERVE underuses comic chaos" / "procedural horror failure mode"), the Counter-Strip Audit operates with REDUCED PROTECTION on the impression's flag dimension. The dimension the impression flags is the dimension the editor is supposed to amplify, NOT preserve. Default Counter-Strip protects "what's working"; when an impression names a register as the problem, that register is NOT what's working in that chapter. Example: Yuki chapter's tender-quiet register is normally protected as character voice — but with the Yuki impression flagging quiet as the problem, Counter-Strip should let chaos-up edits land instead of fighting to preserve tender quietness. The impression is the tiebreaker against the audit's default protection.

**Evidence-documentation watch (anti-vel-failure-mode).** If the revised chapter's net word count is more than 20% below the pre-revision count, the audit notes the delta and the editor documents in the synthesis memo what evidence supported the compression — cold-read findings, reader-impression matches, specific audit failures. **The watch DOES NOT block compression when evidence supports it.** It just requires explicit per-cut evidence in the synthesis memo. Cuts justified by reader impressions, audit failures, or cold-read findings are GOOD cuts — the editor should make them. Cuts justified by "manuscript total is over the floor" are vel-failure-pattern and FORBIDDEN.

Save under `output_edit/audits/codex/chapter_XX.counter_strip.md`.

## The Ending-Earn Audit (Phase 5 + Phase 6)

Run on the final chapter and any coda (e.g., for VERVE: §16-style "Open the book." + Larry coda Tarek-on-the-way-past). Phase 5 pass and Phase 6 final-assembly pass.

Asks: does the ending close what the book opened? Does each locked final line LAND? Do callbacks pay off setups (trace each callback to its setup chapter)? Is the ending standalone, well-paced, and does it leave the reader wanting to talk about the book?

Verdict: **EARNS** (with callback chain) or **DOESN'T** (with specific gaps). DOESN'T blocks final assembly. Locked lines inviolable in text; surrounding prose revisable to make them LAND.

Save under `output_edit/critiques/codex/ending_earn.md` (Phase 5) and `output_edit/critiques/codex/ending_earn_final.md` (Phase 6).

## The Book-Level Comedy/Derangement Arc Audit (Phase 5)

Plot the unhinged-register intensity across all chapters. Does the chaos build chapter 1 → final, or plateau? Where are peaks / valleys? Are valleys intentional (tender contrast, breath chapters) or accidental? Does derangement escalate as the major-event arc approaches?

**Post-climax arc-trajectory check (separate from pre-climax build).** For books with a structural climax in the front half or middle (e.g., for VERVE: the coup at Ch47 ~54% mark), the audit must explicitly check whether the post-climax chapters CLIMB the dramatic gradient or hold flat. The post-climax section should not be a deflation — it should be VERVE / the chaos engine doing increasingly cursed things at increasing scale. Compare locked post-climax peaks (e.g., for VERVE: Halberg death Ch63, Yuki mother Ch82, §16 finale Ch85) against the climax itself: do they land harder than the climax? Compare the chapters BETWEEN locked peaks: are they escalation or observation?

Verdict (extended): **ARC-BUILDS** (with intentional valleys named) / **ARC-FLAT** (chapters to amplify) / **ARC-INVERTED** (peaks early, declines — Phase 2 surgery needed) / **POST-CLIMAX-DEFLATION** (climax lands, then arc holds flat or declines — post-climax chapters need amplification, replacement, or new chapter additions; cross-reference reader-impression entries about post-climax pacing if present).

Save under `output_edit/audits/codex/book_arc.md`.

## The Chat Audit (Phase 5, book-level)

For each recurring chat character (>3 chapters):

1. **Per-pair variety** (book-level extension of per-chapter Chat-Variety): every consecutive pair show stake-shift / format / length / temporal / register variation? Or topic-substituted?
2. **Arc-level escalation**: does the relationship arc escalate / deepen / fracture / oscillate / resolve, or is it nine versions of the same conversation?

Pairwise and arc can diverge — pairwise can pass while the arc flatlines.

Verdict per character: **VARIED + ARC-BUILDS** (with arc summary) / **VARIED-BUT-ARC-FLAT** (with proposals: cut, merge, resequence, chaos-up) / **NOT-VARIED** (topic-substituted pairs).

Save under `output_edit/audits/codex/chat_audit.md`.

## The Motif Audit (Phase 5, book-level)

For each premise-specified recurring motif:
1. **Distribution**: under cap? Clustered?
2. **Per-occurrence sharpness** (from Phase 4 grading): sharp / acceptable / weak ratio.
3. **Arc**: does the motif build / escalate / shift / pay off, or static?

Distribution and arc can diverge — a motif can hit its cap perfectly and still feel arc-flat.

Verdict: **HITS** (with arc characterization) / **DISTRIBUTION-PROBLEM** / **WEAK-INSTANCES** (listed) / **ARC-FLAT**.

Save under `output_edit/audits/codex/motif_audit.md`.

## Banned moves

**Universal:** the Aphorism Gate (no portable maxims, pull-quote shapes, tattoo-able lines — zero tolerance; see Plain-Translation Audit), the Verbatim-Echo Gate (no non-transformative repetition between speakers or sentences), and process-leakage markers (TODO, PLACEHOLDER, AS AN AI). Plus generic MFA tells: em-dash apposition, not-X-but-Y workshop scaffolds, narrator-admiration tells, subject-drop fragments as default narration register (chat-format excluded), "the way [character] [verb] when X" pattern, three-item-tricolon abstract closures.

**Premise-specific:** Gates defined in the calibration artifact (e.g., Gates VERVE-1 through VERVE-N). Phase 3 extracts these verbatim into `binding_standard.md`. Calibration Gates take precedence; calibration exclusions (e.g., chat-format excluded from default fragment gates) must be honored.

## Brutal critique culture

Run repeated brutal critiques throughout the 96 hours, using Codex and Claude as adversarial editors with different tastes. Continue developmental critique until remaining changes are genuinely lower-leverage than additional revision rounds.

Critiques should challenge: set-piece intensity (do marquee scenes LAND?), opening hooks, ending strength (does it EARN?), surprise density, book-level comedy/derangement arc (does it BUILD?), chat-arc + motif-arc escalation, transgression preservation + sanitization risk, comp-author drift, AI-dystopia genre-cliché register (is the book drifting into the *Severance / Black Mirror* prestige-fiction register instead of staying VERVE-coded cursed-comic-unhinged?), missed inviolable elements / subplot resolution / pacing collapse, amplification opportunities missed, AND over-correction (did any audit mis-fire and strip something good?). The Phase 4 + Phase 5 audits handle the rest.

**Convert findings into changes.** A critique that does not change chapters, revise scenes, restore inviolable elements, raise chaos-register, or adjust the revision plan is not finished. Compliance theater — critique that exists to be filed — is worse than no critique.

If Codex and Claude both claim no major revisions are needed, require an adversarial defense: why does the manuscript deserve to ship unchanged, what high-risk drift has been considered and ruled out, AND what amplification opportunities have been considered and rejected (with reasoning)?

## Per-chapter quality

Before commit, verify every Phase 4 audit step (3, 7-16), plus mandatory step 10a Comedy Doctor and any required Dialogue Doctor output, returned an explicit verdict with reasoning and that findings were resolved or recorded. Any audit lacking a verdict is an incomplete chapter — revise before commit, do not defer.

For SKIP-with-chaos-up chapters: verify steps 7, 8, and 16 ran (Plain-Translation re-check, Chaos-Up re-run, Counter-Strip on edits); other steps exempt.

Quality is taste, not a checklist — the binding standard is authoritative; phase-specific audits are the operational gates.

## Length

The premise's length specification (150K for VERVE) is a **FLOOR**, not a target ceiling. Sprawling-premise books may exceed the floor by 10-20% and that is intent, not bug.

**The cardinal rule on length: total word count is an OUTCOME, not a DRIVER.**

The editor never sets out to "trim to 150K" or "trim to any specific number." The editor cuts when chapter-level evidence supports cutting; the total word count is whatever it is after those cuts land.

**The test for cuts is CHAPTER-LEVEL EVIDENCE, never manuscript-level word count.**

**Evidence-driven cuts are ENCOURAGED.** A chapter or scene should be cut when:
- Phase 1 / Phase 5 cold reads find it thin / redundant / not earning its place
- Reader impressions flag it as a failure pattern (procedural-horror-fest, Yuki-quiet-without-engagement, AI-dystopia-genre-cliché, etc.)
- The chapter fails reader-engagement cold-read questions ("where did interest drop off")
- The chapter is mostly procedural register without comic-cursed work (Ch59-type sub-failure per the procedural-horror impression)
- Set-Piece Intensity Audit returns FLAT-WITH-MISSES and the chapter can't be salvaged with revision
- A subplot beat is stronger consolidated into another chapter
- Pacing-Per-Scene flags a chapter as dragging without compelling justification

When these conditions are met, the editor SHOULD cut. Aggressively cutting bad chapters is the editor's job. The book is better without weak chapters.

**FORBIDDEN: cutting to hit a named length target.** "The book is over 150K so we should cut Ch X" is the vel failure pattern. Each cut must point to chapter-level evidence in its synthesis memo, never to manuscript-level word count.

**Local compression** (tightening slow openings, condensing reverie passages, compressing procedural-fest dumps that fail the diagnostic) is encouraged everywhere. Local quality work is always fine.

**Amplification adds words** where applicable (Chaos-Up RAISABLE proposals; Premise-Register-Density additions; running-joke sharpenings that lengthen). Per-chapter net deltas depend on the balance of compression and amplification for that specific chapter.

**Below-floor protection.** Final manuscript must end at or above 150K. If evidence-driven cuts would bring the total below floor, the editor stops cutting and reconsiders the revision plan. Below-floor manuscripts must be marked as checkpoints, not final.

**Word-count tracking.** Codex tracks total word count in `status.md` after every chapter commit. **The number is an observation, not a stop condition.** Per-chapter word-count deltas are reported in synthesis memos; large deltas (>20% increase or decrease) get specifically justified in the memo — the justification is the gate, not the delta itself.

**Anti-vel-failure discipline.** The vel failure was: editor trimmed ~20% off a sprawling manuscript to hit a target without per-chapter evidence. The way to AVOID this is straightforward — every cut requires explicit chapter-level evidence in its revision memo (cold-read finding, reader-impression match, audit failure). "Manuscript over 150K" is not evidence. That's the only test. Don't avoid the failure by refusing to cut chapters that genuinely fail — that's a DIFFERENT failure (refusing to do legitimate revision work because of length anxiety). The book should be as long as it earns being.

## Final assembly

Do not create `output_edit/final/novel.md` as a final candidate until ALL of the following hold:

- All chapters revised, SKIPped, or NEW-completed per classification; Phase 5 SKIP re-examination confirmed every SKIP or reclassified it.
- All Phase 4 per-chapter audits (steps 3, 7-16) ran with explicit verdicts; findings resolved.
- All Phase 5 book-level audits ran with explicit verdicts; findings resolved or deferred with reasons in `residual_risks.md`.
- Every reader-impressions entry (if `reader_impressions.md` is present) has been materially addressed per the Phase 5 Author-Direction Address Verification (concrete-changes evidence, not token edits) OR explicitly deferred with reasoning in `residual_risks.md`. Final report includes the Author-direction outcomes section with sample before/after per impression.
- Continuity reconciled: every fact in `continuity.md` and `continuity_timeline.md` verifiable in the final manuscript. Unreconciled facts block assembly.
- Subplot tracker shows every alive subplot resolved or explicitly accepted-as-unresolved.
- Running-jokes tracker shows all motifs within reading-guide caps.
- Inviolable elements present in committed form (spot-check against calibration's inviolable-element list).
- Cross-model adversarial pressure engaged both Codex and Claude on every TARGETED/HEAVY/REWRITE chapter — Adversarial Register Audit (incl. comp-author drift check AND AI-Dystopia Genre-Cliché Check) findings resolved. Provisional single-model chapters explicitly flagged in `final_report.md`.
- Ending-Earn Audit at Phase 6 returns EARNS with locked final lines confirmed LANDING.
- **A Claude Fable 5 full-book cold read** has run on the assembly candidate at `output_edit/critiques/claude/final_cold_read.md`; findings resolved, deferred with reasons, or explicitly rejected. **NOT optional.** Disagreements with Codex's assessment are valuable; do not reconcile by fiat.

Before this point, assemblies are drafts or checkpoints. If relaunched after a complete-looking but not-yet-cold-read draft, treat as Draft N — do not default to polish; ask what residual drift the next cold read could surface.

## Rate limits

Maintain `output_edit/status.md` with: wall-clock deadline, current phase, current word count, last successful model call, Codex/Claude limit state, next useful task.

If model calls fail from rate limits / credit / quota / transient failure:
- Record the exact failure in `output_edit/worklog.md`
- Do not spin in a tight retry loop
- Treat Codex 5-hour usage/window limits as recoverable pauses
- Sleep until reset if available, or 5 hours if no reset given
- Continue with non-prose work (cold reads, plan refinement, diagnosis work, calibration consolidation) when possible
- For short Claude outages: wait
- For long Claude outages: Codex continues non-prose work but does NOT backfill prose revisions
- Preserve checkpoint state if both models are blocked

## Final report

At the end produce `output_edit/final/novel.md`, `output_edit/final/final_report.md`, and `output_edit/final/residual_risks.md`.

The final report covers:

- **Provenance:** premise source, final title, word count, chapter count; per-chapter classification summary (SKIP / TARGETED / HEAVY / REWRITE / CUT / NEW); per-chapter Claude/Codex revision provenance (drafts, parallel revisions, audit findings, synthesis memos).
- **Amplification:** chaos-up rewrites accepted per form (chats / close-third / narrator / documentary) with sample before/after; Premise-Register-Density additions; running-joke sharpenings; total RAISABLE proposals made vs integrated; net ratchet-up effect on the manuscript vs drafted version.
- **Structural surgery:** any CUT / NEW / merge / split / reorder with reasoning; subplot reweights; form-distribution before/after.
- **Set-piece + opening + ending + surprise:** per premise-named set piece HITS verdict + reasoning; Chapter-1 + Part-opening hook outcomes (strongest + weakest sampled); per-chapter surprise move (one-line); Ending-Earn callback chain per locked final line.
- **Book-level arcs:** Comedy/Derangement curve with intentional valleys named; per-character chat arc summaries; motif arcs (HITS / fixed / accepted-as-residual).
- **Inviolable + transgression preservation:** spot-check confirming inviolable elements present; no sanitization in revised manuscript; voice-card amplifications + re-amplifications documented.
- **Plot + continuity:** continuity reconciliation outcome (zero unreconciled facts at final assembly); subplot tracker completeness; per-chapter contradictions caught during Phase 4 vs deferred.
- **Form + aftermath:** final percentages vs reading-guide targets vs Phase 1 baseline; aftermath-coherence outcome if applicable.
- **Counter-Strip + Adversarial Register:** over-corrections caught and restored with pattern analysis; comp-author drift findings + resolutions; AI-Dystopia Genre-Cliché Check findings + resolutions (which chapters were drifting into prestige-AI-dystopia register and what was changed to bring them back to VERVE-coded register).
- **Author-direction outcomes:** per reader-impressions entry, document the concrete changes that addressed it — sample before/after, word-count deltas where relevant, instances added/removed, list of revision-memos that reference the impression by date. Token edits don't qualify as addressing; unaddressed-or-token-addressed impressions move to `residual_risks.md` with reasoning. Any impression that was rejected or deferred — with explicit reasoning.
- **Cold reads:** Phase 5 + final Claude cold read findings — resolved / deferred / rejected with reasons.
- **Residual risks** (in `residual_risks.md`): drift-but-accepted chapters; deferred cold-read findings; chapters lacking cross-model pressure; unresolved subplots; AT-PEAK chats with thin reasoning.
- **Self-assessment:** strongest revision, weakest accepted revision, most divisive choice, biggest chaos-up win, biggest amplification miss, what a human editor should look at next.

Mechanical final checks:
- Final manuscript at or above the premise's length floor (150K for VERVE), or honestly marked as a checkpoint if not
- Every chapter-level cut documented in its synthesis memo with specific chapter-level evidence (cold-read finding / reader-impression match / audit failure). "Manuscript over the floor" is never sufficient evidence (vel-failure pattern). Cuts that pass this test are legitimate — the editor should make them aggressively when chapters fail.
- Chapters in order, no expected chapter missing
- No planning/review text remains in the prose
- No obvious TODOs/placeholders
- Chapter headings unique
- All expected chapter headings present, including restored heading for any source chapter that lacked one (current known case: Ch80)
- Locked final lines match the binding premise/calibration exactly or have an explicit human-approved conflict resolution recorded (current known case: Ch85 `Open the book.` punctuation)
- Final word count reconciles with chapter-source word count
- Continuity facts agree with the final manuscript
- Ending earned and standalone

The final manuscript should be coherent, complete, meaningfully revised toward the binding standard, structurally coherent (honoring the contract; structural surgery where it strengthens the contract, not where it fractures it), highly readable on the binding standard's own terms (NOT plain-translated to generic clarity), with the binding standard's transgression and register fully preserved and — across every form (chats, close-third interior moves, narrator-prose lines, documentary inserts) — raised toward more unhinged where the editor found room within form constraints.
