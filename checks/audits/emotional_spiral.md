# Audit: Emotional-Spiral Repetition Audit

id: emotional_spiral | owner: claude | tier: risk
trigger: watch:aiisms-2.2-vague-interiority-watch + watch:qscan-04-something-shifts-breaks-changes
output: {audit_root}/claude/chapter_{NN}.emotional_spiral.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:3753-3760 [field guide 13]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The source entry (field guide 13, THE EMOTIONAL SPIRAL THAT WON'T STOP REPEATING), faithful to the text:

> Your character has an anxiety. AI will express that anxiety in five slightly different metaphors across the scene, each one arriving at the same conclusion.
>
> Cycle 1: "Am I missing some essential component?" Cycle 2: "Can you love something you suspect is fundamentally broken?" Cycle 3: "The wiring ran clean but the thing that makes a person a person was left out." Cycle 4: "A machine that asked good questions but felt the wrong things." Cycle 5: "Unless maintaining family harmony was a component of optimal psychological functioning."
>
> The first time is powerful. The second adds nuance. The third is the reader waiting for the scene to move. The fourth and fifth are the writer not trusting the first two. Hit the anxiety hard once, maybe revisit once at a different angle, then let the character (and the reader) move on.

What that means operationally:

1. **Spiral detection.** For each emotional preoccupation a focalizer carries in the chapter (anxiety, grief, guilt, longing, suspicion), collect every interior passage that expresses it. A spiral exists when 3+ passages re-express the same preoccupation through varied metaphors or formulations while arriving at the same conclusion.
2. **The source's grading curve, applied per cycle:** cycle 1 = powerful (keep); cycle 2 = adds nuance (keep only if the angle is genuinely different — quote what is new); cycle 3 = the reader waiting for the scene to move; cycles 4-5 = the writer not trusting the first two. Cycles 3+ are presumptive cuts.
3. **Same-conclusion test.** Varied surface, identical destination. If each cycle's paraphrase reduces to the same sentence, the variation is decorative. A revisit that genuinely changes the conclusion — new information, a turn, a contradiction the character must now hold — is development, not spiral.
4. **Scene-motion cost.** For each spiral, identify what the scene was doing while the interiority circled: what action, exchange, or decision stalled.

Calibration: obsessive or looping consciousness can be a declared mode (a ruminative narrator, an OCD focalizer, a grief chapter the reading guide marks as deliberately recursive). Such a declaration excuses repetition only where the loop itself is doing on-page work the guide names — cite the declaration, and still grade whether the loop escalates or merely repeats.

## Required verdict format
Per preoccupation:
- `PREOCCUPATION <focalizer>: <one-line statement of the anxiety>`
  - `CYCLES: <n>` then per cycle: `<#> — "<quoted passage>" (location) — conclusion it arrives at: <paraphrase> — verdict: KEEP (powerful|new angle: <what's new>) | CUT (same conclusion, cycle ≥3) | TURN (changes the conclusion — development, not spiral)`
  - `SCENE COST: <what stalled while it circled>`

Chapter verdict:
- `NO-SPIRAL` — no preoccupation exceeds two cycles without a TURN. Must still list the preoccupation closest to spiraling and quote its two cycles.
- `SPIRAL-FOUND (<n> preoccupations, <m> cut cycles)`.

`REVISION ORDERS:` one per spiral: name which single cycle survives as the hard hit, which (if any) survives as the one different-angle revisit, list the cycles to cut by quote, and state what scene motion replaces the cut interiority. Orders may not blend cycles into a new composite metaphor — that re-launders the spiral.

## Prompt template (owner=claude)
You are auditing chapter {NN} for emotional-spiral repetition — the documented LLM failure of expressing one anxiety in five slightly different metaphors that all arrive at the same conclusion. Begin from the Critique stance above. Your bias to fight: each cycle, read alone, will look like good writing. The failure is only visible in aggregate; you must read in aggregate.

Inputs:
- Chapter text: {chapter_file}
- Mechanical watch counts for interiority repetition: {watch_counts} (leads, not verdicts — verify in context, discard false positives by name)
- Focalizer voice cards (interiority rhythm fields): {voice_cards}
- Reading-guide declarations of deliberately recursive modes, if any: {reading_guide}
- Calibration notes, if present: {calibration}

Steps:
1. Identify each focalizer's emotional preoccupations in the chapter. For each, collect every interior passage expressing it, in order, with locations.
2. For each collected sequence, write the conclusion each passage arrives at as one plain sentence. Identical conclusions across varied metaphors = spiral; a changed conclusion = TURN.
3. Grade each cycle on the source's curve (1 powerful / 2 nuance-if-new / 3+ cut). Be ruthless at cycle 3.
4. Name the scene cost of each spiral.
5. Apply any reading-guide recursive-mode declaration explicitly — cite it, and still grade escalation vs. repetition.

Write the completed audit, in the Required verdict format, to {audit_root}/claude/chapter_{NN}.emotional_spiral.md. Findings must be revision orders an editor can execute without re-deriving your reasoning.
