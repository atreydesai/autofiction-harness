# Audit: Time-Visibility Audit

id: time_visibility | owner: codex | tier: risk
trigger: cadence:per-act
output: {audit_root}/codex/time_visibility_{act}.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:5153-5168 [Reddit 7 Fix 3: Make Time Visible]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Source, verbatim (Fix 3), including its session procedure:

> AI has no sense of time passing unless you tell it. Three sessions could be three hours or three months in your world. If you don't establish it, the AI defaults to "right after the last thing that happened."
> Be explicit:
> - "Two weeks have passed since the battle."
> - "It's now deep winter. The roads are nearly impassable."
> - "The festival I heard about last session should be starting soon."
> When time moves, the world has to move with it.
> Seasons change. Construction finishes. Wounds heal. Rumors spread. Prices shift. A two-week jump isn't just a number — it's an invitation for the AI to show you what changed. And imagine combining this with the "meanwhile" prompt :)
> I keep a simple timeline in my lore notes. Just key dates and what happened. When I start a new session, I tell the AI the current in-game date. It sounds small but does wonders.

Per-act checks:
1. **Legibility.** Chapter by chapter, can a reader state how much time has elapsed since the previous chapter? Build an elapsed-time table: chapter | on-page time marker (quoted) | inferred elapsed time | confidence. Any chapter whose elapsed time is only guessable is a finding — the manuscript has defaulted to "right after the last thing that happened."
2. **Tracker match.** Does each {timeline} entry match the on-page markers? Quote both sides for every mismatch (tracker says "three days later," chapter opens "that evening").
3. **Season/date/duration consistency.** Do seasons progress at the rate the dates imply? Do stated durations add up (a "two-week" journey that spans one night of story time)? Check weather, harvests, festivals, daylight against the running date.
4. **World moves with time.** For every jump of days or more: did anything visibly change — wounds healing, construction finishing, rumors spreading, prices shifting? Per source, a jump is "an invitation" — quote what changed, or flag the jump as a dead jump (number with no consequences).
5. **Healing/aging clocks.** Injuries, pregnancies, deadlines, countdowns established earlier: are they consistent with total elapsed time?

## Required verdict format

Open with the elapsed-time table for the act. Then per criterion:

`LEGIBILITY: PASS|FAIL — N of M chapter transitions legible; worst case: ch NN, "<quote or NO MARKER>"`
`TRACKER-MATCH: PASS|FAIL — mismatches listed as {timeline} "<quote>" vs ch NN "<quote>"`
`SEASON/DATE/DURATION: PASS|FAIL — each inconsistency quoted with the arithmetic shown`
`WORLD-MOVES: PASS|FAIL — per jump >1 day: "<quoted change>" or DEAD JUMP at ch NN`
`CLOCKS: PASS|FAIL — per running clock: established ch NN "<quote>", state at act end "<quote>", consistent? `

A PASS line must still quote the strongest counter-candidate examined (e.g., the vaguest transition that nonetheless resolves). PASS with no evidence = FAILED audit.

Close with:
1. **Act verdict:** TIME-VISIBLE / TIME-FOGGED (2+ criteria fail) / TIMELINE-BROKEN (tracker contradicts page — escalate to continuity_check_immediate scope).
2. **Revision orders:** per finding, the exact chapter and an explicit time-marker line to insert (in the source's idiom: "Two weeks have passed since the battle"-class sentences, adapted to the book's voice), plus {timeline} corrections where the tracker is wrong. For dead jumps, one concrete world-change beat to add.

## Edge cases and calibration

- **Deliberate ambiguity:** some books withhold dates on purpose (fog-of-war narration, unreliable narrator). That defends VAGUE markers only if the ambiguity is consistent and load-bearing — cite the design note in the reading guide/calibration files; otherwise illegibility is illegibility.
- **Continuous-action chapters:** back-to-back chapters in one continuous scene legitimately have zero elapsed time; mark them CONTINUOUS in the table rather than FAIL.
- **Flashbacks/non-linear structure:** anchor each non-linear chapter to its position in story time, not discourse time, before doing the arithmetic; a flashback is not a timeline break.
- **Marker style:** revision orders must match the book's voice — a diary novel gets a dateline, a close-third thriller gets an in-scene cue ("the stitches had come out by then"), never a bolted-on caption unless the book already uses captions.
- **Combine with the meanwhile ledger:** per source ("imagine combining this with the 'meanwhile' prompt"), every dead jump found here should be cross-filed as a meanwhile_audit surfacing opportunity for the same span.

## Procedure (owner=codex)
1. Read {timeline}, the full act's chapters, and meanwhile_ledger.md if present.
2. Build the elapsed-time table mechanically before judging anything; quote every on-page marker verbatim.
3. Run checks 1-5; do the date arithmetic explicitly in the report (show the addition, don't assert it).
4. Emit verdict lines, act verdict, and revision orders; write to the output path.
5. If TIMELINE-BROKEN, mark ACTIONABLE-IMMEDIATE: the orchestrator must fix chapter or tracker before further drafting, not defer.
