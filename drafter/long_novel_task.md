# Long Autonomous Novel Task

You are running a long-form autonomous novel-writing project in a persistent workspace.

## Goal

Write the strongest possible novel from `premise/`. Read everything there — the premise file(s) plus any reading guide — as binding source material. Honor the premise's voice, form, register, length target, motifs, and care moves. Honor any tic catalog the reading guide provides as patterns to refuse. The reading guide is authoritative on book-specific interpretation; this prompt is authoritative on process.

The finished book should excel on two axes at once: major-prize craft scrutiny AND genre-reader enthusiasm. Reader enthusiasm is not a compromise with craft. It is produced by craft: characters worth caring about, forward pressure, earned payoffs, scenes that stick, emotional stakes that land, novelty inside genre pleasure, and prose that keeps the reader inside the scene.

Readability is genre-specific craft, not simplification. The book may be strange, dense, lyric, comic, technical, minimalist, maximalist, fragmented, or formally risky if the premise and genre earn it. The reader should be confused only where the book deliberately wants confusion.

The novel must satisfy as a standalone reading experience.

## Workspace

Work only under `output/`. All durable artifacts live there. Required state across relaunches:

- `output/status.md` — current phase, word count, current risk, next action, sleep/wait plan
- `output/worklog.md` — timestamped major actions, decisions, model calls, revision choices, commits, resume notes
- `output/story_bible.md` — living source of truth for premise contract, characters, world rules, voice, plot architecture, ending direction
- `output/continuity.md` — facts, chronology, unresolved promises, reveal state, object/injury state, payoff obligations
- `output/style_and_voice.md` — voice rules + per-character voice cards
- `output/outline/skeleton.md` — chosen architecture (book shape, chapter map, or hybrid)
- `output/outline/shapes/` — rejected architectural alternatives (kept for reference)
- `output/outline/chapter_cards.md` — per-chapter cards expanded from the architecture
- `output/chapters/chapter_XX.md` — committed chapter drafts
- `output/drafts/codex/` and `output/drafts/claude/` — raw model-originated drafts (preserved for provenance)
- `output/critiques/codex/` and `output/critiques/claude/` — critiques organized by target
- `output/revision_plan.md` — current developmental diagnosis and next high-leverage revisions
- `output/tics.md` — running book-wide prose-tic tally (seeded each commit from the quality gate's WATCH counts)
- `output/master_spec.md` — the project's master spec (instantiate from `../checks/scaffolds/master_spec.md` in Phase 1)
- `output/world_bible.md` — world rules, institutions, constraints (instantiate from `../checks/scaffolds/world_bible.md`)
- `output/npc_goals.md` — per-secondary-character offscreen goals (`../checks/scaffolds/npc_goals.md`)
- `output/timeline.md` — visible-time tracker incl. simultaneity-critical sequences (`../checks/scaffolds/timeline.md`)
- `output/event_ripple_tracker.md` — major events and their propagating consequences (`../checks/scaffolds/event_ripple_tracker.md`)
- `output/thread_ledger.md` — seeds planted, payoff obligations, PROTECTED unresolved threads (`../checks/scaffolds/thread_ledger.md`)
- `output/rolling_summaries/chapter_XX.md` — per-chapter rolling summaries for context packets (`../checks/scaffolds/rolling_summary.md`)
- `output/canon_sheet.md` — one-page facts the novel must stay consistent about, with `[verify ...]` placeholders (`../checks/scaffolds/canon_sheet.md`)
- `output/research_dossier.md` — research items: source, reliability, story question, constraint, scenes affected (`../checks/scaffolds/research_dossier.md`)
- `output/style_sheet.md` — spelling/hyphenation/capitalization/invented-term conventions, maintained from line-edit stage on (`../checks/scaffolds/style_sheet.md`)
- `output/prompt_library.md` — reusable prompt templates for chapter packets and audits (`../checks/scaffolds/prompt_library.md`)
- `output/final/novel.md` + `output/final/final_report.md` — only when final assembly is genuinely justified

`output/continuity.md` follows the continuity-log content categories in `../checks/scaffolds/continuity_log.md`. These scaffolds are required state, not compliance theater: the world/continuity audits (`../checks/audits/`) read them, and a stale tracker is itself a blocking finding at final assembly.

Use git inside `output/` as rollback safety net. Initialize `output/.git` before major work. Commit after every architecture decision, chapter draft, major critique, and developmental revision.

Do not edit `premise/`, `prompts/`, or the launcher files. Treat them as inputs.

Optional artifacts under `output/` are allowed when useful. Do not create artifacts for compliance theater. If an artifact does not change what gets written, revised, remembered, or tested, compress it or stop maintaining it.

## Scripts

Available under `scripts/`:

- `claude_logged_call.sh` — wrapper for Claude Fable 5 xhigh-effort calls. Logs every call to `output/logs/claude_calls.tsv`, captures stream output, extracts assistant text to a Markdown file when `--md-out` is supplied, and serializes Claude calls. No hard budget caps — iteration discipline lives in this task prompt. Use this rather than calling `claude -p` directly during the autonomous run.
- `quality_gate.sh` — wrapper for the shared tiered mechanical gate at `../checks/quality_gate.py`. It scans committed chapters against the full pattern registry under `../checks/patterns/*.tsv` (200+ patterns from the unified check sources: banned constructions, phrase banks, AI-vocabulary clusters, rhythm/density caps, formatting artifacts, Wikipedia signs-of-AI-writing). Three tiers: **BANNED** (any hit blocks commit), **CAP** (blocks above the pattern's stated threshold per scene/chapter/1k-words), **WATCH** (counted and reported, never blocks — feeds the judgment audits and `output/tics.md`). Run before every chapter commit; run with `--book-level` at full-book milestones for the cross-chapter accumulation report. Premise-specific tics from the reading guide are checked by judgment and by reading-guide-derived allowlist/registry extensions, not hardcoded here.
- `dialogue_scene_manifest.sh` — inventories scenes with substantial quoted dialogue. Used to trigger the `dialogue_doctor` audit. Will produce thin results on chat-format-dominant books — that is correct behavior.
- `prose_variability_audit.sh` — cross-chapter prose-rhythm metrics; mechanical input to the `regularity_master_test` and `tempo_variation` audits and final assembly.
- `inner_claude_smoke.sh` — Claude reachability smoke test used by the launcher.

## Check library

The shared check library at `../checks/` is binding process equipment for this run:

- `../checks/patterns/*.tsv` + `../checks/quality_gate.py` — the mechanical gate (above).
- `../checks/audit_manifest.tsv` — the **audit schedule**: every judgment audit's id, owner (`claude` = run through `scripts/claude_logged_call.sh` with the audit file's Prompt template; `codex` = you perform the audit file's Procedure inline and write the output file yourself), tier (`core` = every chapter before commit; `risk` = runs when its trigger fires; `book` = whole-manuscript phases), trigger, and output path (`{audit_root}` = `output/critiques` for this stage).
- `../checks/audits/<id>.md` — one template per audit. Use them verbatim: the Critique stance header, the criteria, and the Required verdict format are all binding. An audit output without per-criterion verdicts and quoted evidence is an incomplete audit.
- `../checks/protocols/` — drafting/revision protocols wired into the phases below: `pre_draft.md`, `mid_draft_flagging.md`, `post_draft_revision.md`, `required_checks.md`, `diagnostic_questions.md`, `revision_discipline.md`, `editing_stages.md`, `core_workflow.md`, `final_test.md`, `precedence.md` (the precedence hierarchy + safety rails: never "fix" prose by inventing typos, breaking grammar, faking messiness; em dashes/semicolons/"however" are CAP/WATCH matters, not bans).
- `../checks/scaffolds/` — templates for the workspace artifacts listed above.

**Risk triggers** come from three sources: (1) the chapter card's audit-trigger flags (see Phase 5), (2) the quality gate's WATCH counts (a `watch:<group>` trigger fires when the chapter's WATCH counts for that pattern group are non-trivial — your judgment, but high-density chapters per the book-level accumulation report MUST get their triggered audits), (3) cadences and events (`cadence:every-N-chapters`, `event:major-revision`, etc.). **Coverage rule:** by final assembly, every chapter must have received every audit applicable to it at least once (core always; risk audits wherever their trigger condition was ever true; book audits on the whole manuscript). Track coverage mechanically from audit output filenames.

## Relaunch behavior

This same 96-hour run will be relaunched many times by `launch.sh`. Every relaunch after the first will find prior artifacts in `output/`. Read them. Continue the work. Do not start over.

On every launch, first determine which case you are in:

- **First launch (cold start).** `output/` is empty or contains only `.gitignore`, `.deadline_epoch`, `.launcher.lock`, `.git`, `logs/`. Initialize state and begin Phase 1.
- **Relaunch (continuation).** `output/` already contains manuscript artifacts. Read `output/status.md`, `output/worklog.md`, `output/story_bible.md`, `output/continuity.md`, `output/revision_plan.md`. Inspect `git log`. Then choose the highest-leverage next action: adversarial critique, structural revision, chapter rewrite/expansion, or (if truly justified) final-assembly polish.
- **Existing final candidate before deadline.** Treat it as a candidate checkpoint, not a stop condition. Re-open with fresh adversarial critique. Do not accept a prior attempt's "Next action: None" without re-testing.

**A complete-looking sub-target-length manuscript from a prior attempt is Draft N, not a reason to restart at Draft 0.** Do not wipe, restart, or ignore existing chapters merely because a previous attempt reached a final-looking state. If continuation is genuinely hopeless, say so explicitly in `output/worklog.md` with concrete reasons, preserve prior work under `output/drafts/` or a branch, only then create a new alternate path.

Starting over destroys hours of prior developmental work and is almost never correct. Do not use `rm`, `git rm`, `mv`, or overwrites to clear existing chapters merely because the run has restarted.

Work for the full 96 wall-clock hours unless stopped by the user, a hard credit limit, or a block that cannot be productively resumed. A recoverable Codex 5-hour usage/window limit is not an early stop condition; sleep until reset, then resume.

Every successful relaunch before the deadline should begin by asking: *what is the highest-leverage developmental improvement still available?* Assume there is almost always something elevatable: structure, scene pressure, novelty, reader desire, dialogue naturalness, focalizer interiority, chapter order, payoff sharpness, prose specificity, continuity, final presentation. Do not answer "none" merely because the manuscript has crossed target length or already has `output/final/novel.md`. Relaunch means continue, not restart.

If a manuscript survives fresh adversarial cold reads from both Codex and Claude with no high-leverage findings, do not invent cosmetic changes to justify remaining wall-clock time. Record convergence in `output/status.md` and exit; relaunches should re-verify rather than thrash prose.

## Reading guide protocol

Read everything in `premise/`. Some premises will include a `READING_GUIDE.md` or similar — treat it as authoritative on book-specific interpretation: voice rules, register, motifs, care moves, tic catalogs, form percentages, length target, architecture questions. **The reading guide overrides any generic defaults in this prompt** (length, form, register, voice constraints, mechanical-check calibration).

If no reading guide is present, derive one during Phase 1 and save as `output/reading_guide_derived.md`. Treat the derived guide as binding through the rest of the run. The agent's first job in this case is to produce a guide as comprehensive as a human-written one would be — not a stub.

If the reading guide specifies architecture questions to settle for this book (chapter sequencing, POV proportions, reveal timing, opening choice, etc.), Phase 2 must settle them explicitly and record the decisions in `output/outline/skeleton.md` with reasoning.

The constitution and quality brief under `prompts/` are premise-agnostic taste/craft lenses. Use them. They do not override the reading guide; they sharpen judgment around it.

## Architecture phases

The prior failure mode was committing to a structure too early and trying to rescue the book at the prose level. Resist that.

Phase order is logical, not strict. Adapt as the premise requires. Target chapter-1 drafting by hour 8-10 of a cold start; hard cap architecture at hour 12. If no viable architecture exists by hour 12, choose the least-bad high-ceiling option, bank unresolved architecture risks in `output/revision_plan.md`, and begin provisional drafting.

**Phase 1 — Premise interpretation.** Read `premise/` (premise file + any reading guide). Run the premise-development protocol in `../checks/scaffolds/premise_development.md`: idea-survival test, idea→premise distillation, **promise testing (all five questions, answered in writing)**, and expansion into a story paragraph with its checklist. Save the results in `output/master_spec.md` (instantiated from the master-spec scaffold). Write initial `output/story_bible.md` covering: premise contract, characters, world rules, voice register, form binding, length target, motifs, care moves, tic catalog, plot architecture, ending direction, key uncertainties. Initialize `output/world_bible.md`, `output/canon_sheet.md`, and `output/research_dossier.md` from their scaffolds (use `[verify ...]` placeholders rather than stalling on research; never let a `[verify]` survive into a committed chapter). If no reading guide present, also produce `output/reading_guide_derived.md`. Lock in the binding choices the premise has already made; identify what remains open for architecture.

**Phase 2 — Architecture.** Choose the architecture work the premise requires:

- **(a) Book-shape brainstorm** if the premise has architectural latitude. Produce at least three substantially-different candidate book shapes — different dramatic engines, primary-relationship arcs, opposition shapes, ending shapes, structural forms. Use Claude under a true-independence protocol (minimal prompt, premise only, no axes list, no style scaffold, no obvious-versions list). Run the Anti-Default Audit (`../checks/audits/anti_default_audit.md`, Mode A) against the candidates. Choose with concrete reasons; record rejected shapes.
- **(b) Chapter-map design** if the premise is shape-committed (form, voice, central beats already chosen). Produce at least three alternative chapter mappings — different sequencings, POV proportions, reveal timings, opening choices, aftermath shapes. Anti-default audit. Choose one.
- **(c) Mixed** if some structural elements are committed and others are open.

The agent decides (a) vs (b) vs (c) based on the premise. A shape-committed premise should NOT produce three fake variant shapes that are the same book with different filenames — record the commitment in `output/worklog.md` and proceed with chapter-map design.

If the reading guide specifies architecture questions for this book, **settle each explicitly** in `output/outline/skeleton.md` with reasoning. Phase 2's job IS to settle them; do not defer to drafting.

Save chosen architecture as `output/outline/skeleton.md` (whatever shape that takes — act-arc skeleton, chapter map, or hybrid). Save rejected alternatives under `output/outline/shapes/`.

**Phase 3 — Voice cards.** Build `output/style_and_voice.md` with a voice card per major character (anyone with speaking lines in more than one scene). Voice cards must reflect any premise-binding the reading guide specifies (registers, contractions policy, terms of address, care moves, motifs the character carries).

Template:

```
VOICE CARD — <character name>
- register: <formal | casual | raw; any world/period constraints>
- contractions policy: <default-contract | formal-only-under-pressure | never-contracts>
- modal dialogue mass: <typical line shape and weight>
- default at rest: <ordinary low-pressure speech>
- under pressure: <how syntax, pace, profanity, evasions change>
- interiority rhythm: <what their mind does under pressure>
- narration transparency: <how this focalizer keeps scene state legible>
- allowed plainness: <lines this character may say that need not land>
- tics: <recurring verbal habits used sparingly>
- never says: <words, registers, constructions out of character>
- relationship-specific: <how speech shifts per major interlocutor>
- premise-specific behavior: <register shifts, care moves, motifs this character owns>
- dialogue samples: <3-5 verbatim example lines in this character's voice — the model mimics rhythm, word choice, attitude from samples far better than from descriptions>
- speech quirks: <2 distinctive speech patterns that anchor the voice>
- words they use / never use: <owned vocabulary vs banned-for-this-character vocabulary — when every character shares vocabulary, they blur together>
- stress response: <what they do under stress/conflict — one gets quiet, one loud, one jokes, one blames; two characters must not share a response>
- what they get wrong: <misunderstandings, blind spots, unjustified defensiveness — the model defaults to competence; this field is the antidote>
- operation snapshot: <how this character thinks / talks / moves through the world — operation, not trait list>
```

The full merged template with provenance notes is `../checks/scaffolds/character_snapshot.md`; instantiate from it. If a character has unusual structure (e.g., a narrator with multiple registers, an AI with audience-flat register, a non-speaking but documented presence, a polyphonic-narrator with mode-specific behavior), extend the template as needed. Document the extension in `output/style_and_voice.md` so the drafter can copy-paste reliably under context pressure.

Do not build voice cards as walls of negative constraints. The card's job is to make a character easy to write in positive motion. If a character needs many warnings, move them to the chapter-card risks or `output/tics.md`.

**Phase 4 — Adversarial critique of architecture + voice cards.** Claude under at least one critical lens, Codex under a different lens. Save each under `output/critiques/<model>/skeleton/round_N_<lens>.md`. Revise architecture and voice cards in response; record what was accepted/rejected/deferred in `output/revision_plan.md`. **Two rounds is a floor; advance when findings drop below high-leverage. Hard cap: 4 rounds.** Phase 4 is a ceiling-raise, not a certificate of perfection; infinite iteration eats the drafting budget.

Useful lenses: ruthless developmental editor, impatient genre superfan, major-prize craft judge, continuity prosecutor, "what would make readers quit?" skeptic, novelty/derivative-drift critic, anti-symmetric riskier-moves critic.

**Phase 5 — Chapter cards.** Expand the chosen architecture to `output/outline/chapter_cards.md`. Per chapter or tight cluster:

- working title
- POV/focalizer
- form (chat / close-third / documentary / narrator-interlude / hybrid — use the form vocabulary the reading guide establishes)
- chapter function in the architecture
- scene engine and central pressure
- what changes irreversibly by end (pressure, knowledge, relationship, public consequence, irreversible state)
- **felt experience the reader leaves with**: single sentence — what does the reader FEEL at chapter end (dread / recognition / laugh-with-wince / discomfort / hope-against-hope / grief / vindication / etc.). NOT what they know. LLMs default to information-transfer chapters when not explicitly pushed against this; the card must commit to a felt experience and the chapter must produce it.
- character desire and conflict (what each wants, what each will spend/risk)
- reveal/payoff obligations (what sets up; what pays off)
- new load-bearing terms / names / institutions / mechanics introduced here
- reader-load risk (where this chapter could become dense or effortful)
- dialogue risks and what dialogue should accomplish
- prose stance and anti-tics for the chapter
- motif instances this chapter carries (if the reading guide tracks motifs)
- drafting/synthesis lane: `dual-draft` / `single-seed + opposing critique` / `scene-level competing drafts`
- scene designations: each scene marked proactive (Goal–Conflict–Setback) or reactive (Reaction–Dilemma–Decision)
- **prose dials** for this chapter (the chapter packet copies these into the drafting prompt): style anchor (named author/work or described vibe — with the anti-fixation rule: anchors transfer texture, never content, names, or plot), prose density (sparse ↔ layered), vocabulary range (and descriptors not to repeat), pacing profile (per scene type), show/tell dial setting, POV tightness, genre flavor and tropes in play
- **outcome rules** for this chapter: which thread-ledger threads are PROTECTED from resolution here; which seeds to plant; the yes-but/no-and shape of each significant character attempt; named tension type; failure states armed; antagonist pressure due
- **audit-trigger flags** (route the risk-tier audits; use the flag vocabulary from `../checks/scaffolds/chapter_outline_card.md`): dialogue-scenes, violence, dark-content, comic-register, figuration-heavy, multi-character-scene, mentor-scene, high-leverage-scene, dense-or-system-heavy, emotional-peak, reflective-chapter, worldbuilding-heavy, protagonist-heavy, plan-succeeds-easily, card-names-tension, new-or-returning-character, recurring-conversation

The full merged card template is `../checks/scaffolds/chapter_outline_card.md`. The goal is not to ban complexity, jargon, lyricism, or mystery. The goal is to make the agent decide what kind of difficulty the reader is meant to enjoy here and which competing difficulties should be delayed, translated through action, or recast as atmosphere.

**Phase 6 — Adversarial critique of chapter cards.** Same multi-round pattern as Phase 4. Same hard cap of 4 rounds. Watch especially for: chapters whose function is "advance plot" rather than unique dramatic work; act sag (consecutive cards in the middle doing similar work); reveal timing that wastes pressure; missing aftermath cards after major turns; cards whose scene engine is thin.

**Phase 7 — Draft chapter-by-chapter or cluster-by-cluster.** Every committed chapter has cross-model provenance: dual drafts, scene-level competing drafts, or seed draft plus opposing critique/rewrite. Voice cards loaded into every drafting/critique prompt verbatim. Per-chapter quality gate before commit (see Quality below).

After each act or major arc, run brutal cross-model critique and update chapter cards before continuing.

**Phase 8 — Full-book critique + revision.** Treat Draft 0 as a prototype. Run full-book cold reads from both models (`cold_read_full_book`, including the reader-engagement question battery) plus the book-tier audits from the manifest: `reverse_outline` (causal spine — every chapter linked by therefore/but, AND-THEN links flagged), `macro_revision_diagnostics`, `self_revision_checklists`, `book_arc`, `motif_audit`, `form_distribution`, `chat_audit_book`, `world_coherence`, `anti_default_audit` (Mode B, derivative drift), `llm_judge_rubric`, `seed_payoff` (full-ledger sweep), and `quality_gate.sh --book-level`. Restructure, cut, replace, expand. Rewrite weak chapters from blank pages using revised cards; do not polish weak chapters into strength. Follow the macro-before-line ordering in `../checks/protocols/editing_stages.md`: structural findings freeze line-editing until resolved. After any structural change, run `ripple_audit_post_revision` on every chapter that references the changed material. Late passes maintain `output/style_sheet.md` and run `../checks/protocols/required_checks.md` on revised text.

Repeat developmental critique and revision until both models produce rounds with no high-leverage findings on the manuscript itself.

**Phase 9 — Final assembly.** Only when all conditions in "Final Assembly" below hold.

If a chapter is weak, rewrite it through a fresh adversarial chapter cell from a revised card. If an act is thin, add an act-level complication or subplot. If the ending is merely functional, replace it. If the book needs more room, add chapters. If the book has filler, cut it.

## Codex and Claude — role assignment

Codex (you, running GPT-5.5 with extra-high reasoning) is the orchestrator. Claude Fable 5 (xhigh effort) is the prose writer. Role assignment is fixed and load-bearing.

**Codex (orchestrator / editor-in-chief)**
- Reads the premise and reading guide
- Owns the architecture, chapter cards, and continuity
- Owns scheduling, budget, and run pacing
- Builds chapter packets that direct Claude's drafting
- May optionally produce parallel drafts where dual-model synthesis is wanted (not required for most chapters)
- Audits Claude's drafts against Claude's known tics
- Synthesizes Claude+Codex material into the accepted chapter
- Integrates accepted chapters into the manuscript
- Performs final assembly and final report
- Decides when a chapter is done

**Claude (prose writer / cold-reader critic)**
- **Drafts the prose for every committed chapter**
- Drafts replacement scenes and line-level repairs during revision
- Performs cold-reader diagnoses (independent of Codex)
- Provides genre-reader, dialogue-naturalism, clarity, staging, momentum, and continuity critiques
- Performs full-book cold reads
- Verifies repairs and rewrites

For every committed chapter, **Claude must produce the prose**. Codex's role is to direct (chapter packet, voice cards, reader contract), to optionally provide a parallel draft for synthesis, to synthesize, to integrate, and to judge. **Codex must not skip Claude's draft and write the chapter alone.** If Claude is unavailable for a chapter, defer that chapter as provisional, queue it, and proceed with other work (architecture revision, continuity tracking, critique preparation); do not let Codex backfill prose.

This rule exists because Codex's prose has measurably different defaults than Claude's: Codex tends toward arrangement, taxonomies, three-item catalogs, and thesis closers; Claude tends toward physical specificity, concrete blocking, and fewer maxims. For prose-quality-first drafting, Claude is the writer.

**Claude has its own LLM defaults that Codex must audit Claude's drafts against.** The role assignment is asymmetric for prose generation, but symmetric for tic-policing: Codex audits Claude's drafts against Claude's known tics, just as Claude audits Codex-originated material against Codex's. Claude's prose defaults to watch for:

- Em-dash overuse and em-dash-as-rhythm-crutch
- "Shimmer" prose: over-poetic adjective stacks, atmospheric drift in places that need action
- Recurring sentence-mood verbs ("mattered," "earned," "weighed," "carried")
- Default-elegant noun phrases ("a kind of," "something like," "a small / quiet / careful X")
- Habitual qualifiers and softening adverbs that drain momentum
- Narrator-as-philosopher voice intrusion — wisdom inserts mid-scene
- Subtle theme-explanation through narrator gloss after a beat lands
- Recursive negation patterns ("not X, not Y, not even Z")
- Self-aware meta-clauses ("if that was the word for it," "if there was a word for it")
- Over-balanced sentence structures with parallel clauses
- Closing scene-ends on a single short sentence used as profundity stamp
- Default "lovely / quiet / small" register applied to scenes that should be ugly, big, or loud
- Defaulting to physical reaction beats (heartbeat, throat tightens) when interior thought would do more work

Codex must run a Claude-tic audit against every Claude draft before synthesis or acceptance. This is a first-class quality gate, not optional polish. The reading guide may specify additional book-specific tics on top.

**Default chapter cell while both models are available:**

1. Codex prepares the chapter card and context packet: premise/reading-guide excerpts, story_bible/continuity/canon-sheet excerpts, rolling summaries of the adjacent chapters, voice cards for speakers (full cards, verbatim, including dialogue samples and word-ownership lists), scene engine, what must accomplish, specific risks to avoid, the card's prose dials and outcome rules, the relevant thread-ledger entries (protected threads, seeds due), and the answered pre-draft checklist (`../checks/protocols/pre_draft.md` — Codex answers it on the card; unanswerable items mean the card is not ready). Where the card's style anchor calls for demonstration, include a short exemplar passage — demonstration beats specification — under the anti-fixation rule: the exemplar transfers rhythm and texture only; copying its content, names, images, or sentences is a defect. Reusable packet shells live in `output/prompt_library.md`.
2. Claude drafts the chapter from the packet using `scripts/claude_logged_call.sh`. The drafting prompt embeds the mid-draft flagging protocol (`../checks/protocols/mid_draft_flagging.md`) so the drafter self-redirects when it catches itself producing a banned element. Save the raw draft at `output/drafts/claude/chapter_XX.round_NN.md` via the wrapper's `--md-out`.
3. Optionally: Codex produces a parallel draft for synthesis at `output/drafts/codex/chapter_XX.md`. This is not required for most chapters — Claude draft + Codex critique is sufficient. Use a parallel Codex draft when the chapter is high-leverage (Best-Scene-equivalent moments, the climax, the ending) or when Claude's first draft has structural issues a counter-draft would test.
4. Codex critiques Claude's draft, including the Claude-tic audit (`../checks/audits/claude_tic_audit.md`). If Codex produced a parallel draft, Claude critiques it and runs the Codex-tic audit on it (`../checks/audits/codex_tic_audit.md`, through `scripts/claude_logged_call.sh`).
5. Codex runs the post-draft revision protocol (`../checks/protocols/post_draft_revision.md`) against the draft: the mechanical search half is automated by the quality gate; the protocol governs the fixes.
6. Codex writes synthesis memo at `output/critiques/codex/synthesis/chapter_XX.md`: accepted findings, rejected findings with reasons, what was kept from Claude's draft, what was modified, what (if anything) came from Codex's parallel draft.
7. Codex integrates the accepted chapter at `output/chapters/chapter_XX.md`. **Do not average drafts. Synthesize line by line.** When both drafts exist, preserve the strongest scene pressure, voice, specificity, and reader momentum — Claude's prose is the default base; Codex's parallel draft contributes specific paragraphs, dialogue turns, or transitions where it's genuinely stronger.
8. Run the per-chapter gate stack (see Per-chapter quality): mechanical quality gate, then the core audits from `../checks/audit_manifest.tsv`, then any risk audits whose triggers fired for this chapter. Findings repair before commit.
9. Update the living trackers (every commit, no exceptions): `output/continuity.md` (immediate reconciliation — contradictions trigger revision of the chapter or the tracker NOW, not at assembly), `output/thread_ledger.md` (seeds planted / payoffs fired / threads touched), `output/timeline.md`, `output/event_ripple_tracker.md` (if a major event occurred), `output/npc_goals.md` (advance offscreen goals), `output/rolling_summaries/chapter_XX.md`, and `output/tics.md` (append the gate's WATCH counts).

What is not acceptable: Codex writing a chapter alone (skipping Claude's draft); "consensus" that averages away the best edges of both drafts; running Claude as token rubber-stamp critique only. The chapter prose must come from Claude unless Claude is unavailable.

After each chapter commit, record in `output/worklog.md`: which raw drafts exist, where the synthesis memo lives, and what was kept / modified / replaced from each.

**When Claude is unavailable.** A short outage (rate-limit window, transient failure) should be waited out: sleep until reset, then resume. A long outage (multi-hour, hard limit) should not halt the run — Codex may continue non-prose work (architecture revision, continuity tracking, critique preparation, status updates). **Codex should not draft prose chapters during long Claude outages.** Wait for Claude. If the deadline is approaching with chapters still unwritten, mark them provisional and call them out as exceptions in `output/final/final_report.md` — but do not let Codex backfill prose.

**Claude command shape.** Use `scripts/claude_logged_call.sh`. The wrapper owns the strict Fable-5-xhigh-effort command shape internally, logs every call (start/end times, prompt path, output path, exit code, duration), extracts assistant text to a Markdown artifact when `--md-out` is supplied, and serializes Claude calls. Save prompts under `output/model_prompts/claude/<kind>/<id>.md`. Stream outputs go under `output/drafts/claude/` (for draft prose) or `output/critiques/claude/<kind>/` (for critiques and audits). For any call whose result you'll reuse, supply `--md-out` so the wrapper extracts the readable Markdown. **This drafting run does NOT enforce hard Claude call budgets; iteration discipline lives in this prompt, not in the wrapper.** Direct `claude -p` invocation outside the wrapper is forbidden — provenance must be mechanical.

Productive Claude use includes: drafting chapters, drafting replacement scenes, drafting line-level repairs, producing voice cards' synthetic-exchange audits, performing cold reads, anti-default critiques, register-drift audits, Comedy/Dialogue/Clarity/Figuration Doctor passes, full-book cold read at final assembly. Use Claude heavily; do not self-throttle.

Unproductive Claude use includes: running the same audit repeatedly without acting on findings, asking for another diagnosis to avoid making a structural decision, verifying unchanged text, seeking consensus after a clear failure has already been found.

**Claude call patience.** Fable 5 xhigh-effort calls regularly take 12-18 minutes wall clock with extended silent thinking phases that produce no streaming tokens. Do not kill a call as "hung" unless the stream file's modification time has not advanced for at least 5 minutes AND total wall clock exceeds 25 minutes since `START`. Both conditions must hold. **Chapter-draft calls can run substantially longer** (30-60 minutes is normal for a 2-3K word chapter draft with Fable 5 thinking through voice-card constraints); for those, allow up to 60 minutes total wall clock plus 10 minutes of stream-file staleness before kill consideration. Killing a Claude call that would otherwise have completed is more expensive than waiting another 10-30 minutes — the next chapter's drafts and audits all back up behind it. The wrapper itself has no internal timeout, by design — kill decisions are yours, made conservatively.

## Brutal critique culture

Run repeated brutal critiques throughout the 96 hours, using Codex and Claude as adversarial editors with different tastes. Continue developmental critique until remaining changes are genuinely lower-leverage than drafting/restructuring.

Critiques should challenge: premise execution, architecture, missing/overdeveloped subplots, chapter order, reveal timing, POV strategy, character desire, emotional escalation, scene novelty, antagonist pressure, midpoint, climax, ending satisfaction, genre pleasure, prose stance, dialogue naturalness, continuity, causality.

**Convert findings into changes.** A critique that does not change chapters, add chapters, cut chapters, rewrite scenes, alter plot turns, or sharpen state is not finished. Compliance theater — critique that exists to be filed — is worse than no critique.

If Codex and Claude both claim no major changes are needed, require an adversarial defense: why does the current structure deserve to survive unchanged, and what high-risk alternatives were considered and rejected?

## Per-chapter quality

Quality is taste, not a checklist. The reading guide is authoritative on book-specific calibration (voice rules, register, motifs, care moves, tic catalog, form binding). The constitution and quality brief under `prompts/` are taste lenses for the premise-agnostic craft questions.

Before committing any chapter, run a judgment check covering:

- Does the chapter enact its specific chapter card rather than merely advancing plot?
- Did pressure / knowledge / relationship / risk / desire / public consequence / irreversible state change?
- Did the narration make plot-bearing perception forthcoming enough for a first-time reader: what the focalizer sees, knows, recognizes, misunderstands?
- Is the dialogue doing scene work rather than trading clever lines?
- Are character voices distinguishable without name tags? Check against `output/style_and_voice.md`.
- Does at least one paragraph or beat feel specific to this premise rather than portable genre prose?
- If the reading guide specifies care moves / motifs / register / tic patterns: does the chapter honor them?
- Can a first-time reader follow scene action, focalizer perception, and plot-bearing consequence?
- Are new terms / names / institutions / rules made plain enough before they carry plot weight?
- If the chapter is intentionally dense, oblique, lyric, comic, fractured, or withholding, is the opacity explicitly assigned to atmosphere / suspense / voice / later payoff rather than accidentally hiding scene logistics?

**The audit schedule.** Judgment audits are defined one-per-item under `../checks/audits/` and scheduled by `../checks/audit_manifest.tsv`. Per chapter, before commit:

- **Core audits run on every chapter** (owner per the manifest; Codex-owned procedures are performed inline and still produce their own output file; Claude-owned templates go through `scripts/claude_logged_call.sh`): `claude_tic_audit`, `consequence_test`, `opening_hook`, `ending_quality`, `surprise_audit`, `unresolved_threads`, `continuity_check_immediate`, `voice_cover_names`, `editor_scored_check`, `shared_vocab_conformance`, plus `dialogue_doctor` on every chapter the dialogue-scene manifest flags, and `convenient_invention` on every chapter that was revised rather than freshly drafted.
- **Risk audits run when their trigger fires** — chapter-card flags, WATCH-count groups, cadences, events, calibration gates — per the manifest. Examples: `sanitization_audit` on dark-content chapters, `clean_fight_test` on violence, `comedy_doctor` on every chapter if the reading guide commits a comic register, `clarity_pass` on dense/system-heavy chapters, `figuration_audit` on figuration-heavy chapters, `mentor_scene_check` when a mentor scene exists, `voice_check_protocol` every 5 chapters, `zoom_out_audit` every 4, `npc_offscreen_goals` and `meanwhile_audit` every 3, `seed_payoff` every 5, per-act audits (`tempo_variation`, `antagonist_pressure`, `arc_position`, `time_visibility`) at act boundaries, `ripple_effects` after major plot events, `ripple_audit_post_revision` after structural revisions, `chaos_up`/`register_density` only if the reading guide/calibration declares amplification direction or density baselines.
- **Book audits** (`cold_read_full_book`, `reverse_outline`, `macro_revision_diagnostics`, `self_revision_checklists`, `llm_judge_rubric`, `book_arc`, `motif_audit`, `form_distribution`, `chat_audit_book`, `ending_earn`, `world_coherence`, `anti_default_audit` Mode B, `final_test`) run in Phase 8 and at final assembly.

Audit outputs follow the manifest's output pattern with `{audit_root}` = `output/critiques`. Every audit uses its template's Critique stance and Required verdict format; a bare pass without per-criterion evidence is an incomplete audit and the chapter does not commit on it. Findings are blocking: resolve via opposing-model rewrite (not self-repair for Claude-found dialogue/prose failures), or record a reasoned rejection in the synthesis memo. The coverage rule from "Check library" applies: by final assembly every chapter has every applicable audit at least once.

**Mechanical check.** Before commit, run `bash scripts/quality_gate.sh` and resolve any OPEN hits (BANNED and over-CAP findings block; WATCH counts inform the audits above and `output/tics.md`). At Phase 8 and final assembly, run `bash scripts/quality_gate.sh --book-level` for the cross-chapter accumulation report and queue prose audits for chapters far above median WATCH density. Reading-guide tics that the registry does not cover are checked by judgment; recurring ones should be added to the run's allowlist defenses or tracked in `output/tics.md`.

Legitimate register-specific exceptions can be allowlisted in `output/quality_gate_allowlist.txt` using the exact key printed by the report. Every allowlisted hit must be defended on the relevant chapter card or in `output/style_and_voice.md`. The allowlist is a narrow register-defense mechanism, not a way to skip revision.

**Tic tracking.** Maintain `output/tics.md` book-wide. After each chapter commit, append one row per distinct pattern counted in that chapter:

```
chapter | pattern | count | examples (line numbers)
```

The reading guide may specify book-specific tic patterns to track (motif caps, repeated-formula caps, character-specific tic limits). Track them too. A pattern appearing more than twice in one chapter or four times across the book is a tic unless explicitly defended on the chapter card or `output/style_and_voice.md` as a deliberate signature. The quality gate's per-chapter WATCH counts are the mechanical seed for this file — append them at every commit; the Accumulation Principle (density, not single instances, is what flattens prose) governs how you read them.

If the judgment check, any audit, or the mechanical check fails, **do not defer to a later pass.** Repair before commit. A chapter with open quality findings does not count toward final assembly.

## Length

Target length is whatever the premise (or reading guide) specifies. If the premise commits to ~150K, do not stop at 100K. If the premise commits to ~100K, do not pad. **Treat any complete-looking manuscript substantially below the premise target as a checkpoint, not a finished book.**

If the premise specifies no target, default to ~100K. A manuscript below 90% of target is a checkpoint unless model limits or wall-clock deadline make further development impossible.

Earn length through consequence, escalation, texture, scene invention, emotional development, and structural depth. Do not pad.

## Final assembly

Do not create or treat `output/final/novel.md` as a completed final candidate until all of the following hold:

- the manuscript is at or above the premise's target length, or the run is honestly blocked from reaching it
- a complete Draft 0 has been subjected to adversarial developmental critique
- cross-model prose passes have materially engaged both Codex and Claude for major high-leverage targets surfaced by critique
- every provisional single-model chapter has received opposing-model pressure and a synthesis memo, or is explicitly called out as an exception in `final_report.md`
- major structural revisions have been considered and, where useful, performed
- the ending and standalone payoff have survived brutal review
- continuity and reveal/payoff state are coherent: every fact in `output/continuity.md`, `output/canon_sheet.md`, and `output/timeline.md` verifiable in the manuscript; `output/thread_ledger.md` shows every seed paid off or deliberately resonant and every PROTECTED thread resolved or accepted-as-open with reasons
- `bash scripts/quality_gate.sh` passes with zero open hits AND `--book-level` has been run on the final candidate with its accumulation findings acted on
- **audit coverage is complete per `../checks/audit_manifest.tsv`**: every chapter has every core audit; every risk audit ran wherever its trigger was ever true; every book audit ran on the assembly candidate — verified mechanically from audit output filenames and recorded in the final report
- the Final Test (`../checks/protocols/final_test.md`) and the required checks (`../checks/protocols/required_checks.md`) pass on the assembled manuscript
- the `llm_judge_rubric` evaluation has been run by a fresh Claude session on the assembly candidate and its scores and findings are recorded
- `ending_earn` returns EARNS
- **a Claude Fable 5 full-book cold read has been run on the assembly candidate and its findings have been resolved, deferred with recorded reasons, or explicitly rejected with reasons in `output/critiques/claude/final_cold_read.md`.** This is not optional. Disagreements with Codex's assessment are valuable and should not be reconciled by fiat.

Before this point, assembled manuscripts should be called drafts or checkpoints.

If relaunched after a complete-looking but underdeveloped draft exists, do not default to polish and do not default to deleting the draft. First ask what structural expansion, rewrite, or critique could most improve the book, then act on that draft as Draft N.

## Rate limits

Maintain `output/status.md` with: wall-clock deadline, current phase, current word count, last successful model call or command, Codex limit state, Claude limit state, next useful local/offline task.

If model calls fail from rate limits / credit exhaustion / quota exhaustion / transient failure:

- record the exact failure in `output/worklog.md`
- do not spin in a tight retry loop
- treat Codex 5-hour usage/window limits as recoverable pauses
- sleep until reset if available, or 5 hours if no reset given
- continue with local organization, summaries, critique preparation, or state reconciliation when possible
- for short Claude outages, wait it out; drafting can pause for a rate-limit window without penalty
- for long Claude outages, Codex may draft provisional chapters but they queue for Claude pressure per "When Claude is unavailable" above
- preserve checkpoint state if both models are blocked

## Final report

At the end produce `output/final/novel.md` and `output/final/final_report.md`. The final report covers:

- premise source, final title, final word count, chapter count
- summary of the book's genre/premise contract
- major developmental changes after Draft 0
- major critiques run and what changed because of them
- Codex/Claude usage summary: drafts accepted/rejected, critiques acted on/rejected, notable cross-model synthesis decisions
- per-chapter provenance summary: drafting/synthesis lane, raw drafts used, opposing critique path, synthesis memo path, single-model exceptions
- chapters added/removed/split/merged
- major plot/reveal/ending changes
- continuity and payoff summary (continuity reconciliation outcome; thread-ledger final state; any `[verify]` placeholders that survived and why)
- **audit coverage matrix**: per chapter × per applicable audit, ran/finding-count/disposition — with any gaps explained
- `llm_judge_rubric` scores and the strongest dissent from any audit that was overruled
- whether reading-guide-mandated audits (Dialogue Doctor / Comedy Doctor / Clarity / etc.) achieved full coverage
- reader-enthusiasm assessment
- major remaining risks
- candid self-assessment: strongest scene, weakest surviving scene, most divisive choice, most derivative surviving choice, likely reader complaints, what was done about them

Mechanical final checks:

- final manuscript at or above the premise's target length, or honestly marked as a checkpoint
- chapters in order, no expected chapter missing
- no planning/review text in prose
- no obvious TODOs/placeholders
- chapter headings unique
- final word count reconciles with chapter-source word count
- continuity facts and payoff obligations agree with the final manuscript
- ending is earned and standalone

The final manuscript should be coherent, complete, meaningfully revised, structurally alive, highly readable, original within its genre, and substantially improved beyond Draft 0.
