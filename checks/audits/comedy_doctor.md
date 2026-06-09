# Audit: Comedy Doctor

id: comedy_doctor | owner: claude | tier: risk
trigger: flag:comic-register (reading-guide-mandated => every-chapter)
output: {audit_root}/claude/chapter_{NN}.comedy_doctor.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: verve-legacy Comedy Doctor

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
Runs when the reading guide commits the book to a comic register; where the guide mandates it, it runs on every chapter. The audit tests whether the comedy is landing **in this book's specific register** — not against generic literary-judge taste. Calibrate every judgment against the target reader the reading guide names ({reading_guide_target_reader}); a line that would amuse a generic workshop and bore that reader fails.

Per chapter, the audit performs a full comic inventory. For every comic item (joke, bit, comic image, running gag instance, comic turn, register collision, funny structural move):

1. **Mechanism.** Name the comic mechanism doing the work (escalation, incongruity, deflation, repetition-with-variation, register collision, specificity overload, timing reversal, deadpan, cringe, etc.). "It's funny" is not a mechanism. An item whose mechanism cannot be named is presumed not to have one.
2. **Source.** Classify: **character** (arises from who this person is — the strongest source), **situation** (arises from the scene's pressure), or **narrator-overlay** (a wit-layer the narrator paints over the scene — the weakest source, and the LLM default). A chapter whose comedy is mostly narrator-overlay is being witty *at* the book instead of funny *inside* it.
3. **Funniness 0-2.** Scored for the target reader: 0 = does not land; 1 = partial — smile-shaped, but workshopped, predictable, or under-committed; 2 = lands. Score 1 ("partial") is not a passing grade.
4. **Portability.** Could this item appear unchanged in another book? Comedy built from this book's specific characters, world, and pressures is non-portable; portable wit is interchangeable filler. Portable = blocking.
5. **Dramatic work.** What does the item do besides amuse — reveal character, raise pressure, misdirect, release tension at the right moment, sharpen a relationship? Comedy that does no dramatic work is decoration; note it.
6. **Workshopped test.** Does the item read as composed-for-quotation rather than arising from the scene (symmetrical setups, punchline syntax, wit that no character is generating)? Workshopped = blocking.

Chapter-level distribution checks: density against the register the guide commits (a comic book with a joke-free chapter needs a named reason); variety of mechanisms (the same mechanism recurring item after item = MONOTONOUS); sweetness calibration (comedy used to soften beats the book wants to leave sharp = OVERSWEETENED); cringe calibration (humor misjudging the target reader badly enough to embarrass the book = CRINGE).

## Required verdict format
`INVENTORY:` one line per comic item:
`<#> — "<quoted item>" (location) — mechanism: <name> — source: character|situation|narrator-overlay — funniness: 0|1|2 — portable: yes|no — dramatic work: <what, or NONE> — workshopped: yes|no`

Chapter verdict, exactly one of:
- `CLEAR` — comedy lands in register: majority funniness-2, character/situation-sourced, non-portable, mechanisms varied. Quote the strongest and the weakest surviving item.
- `CLEAR BUT THIN` — what's there lands, but density is below the register's commitment; name where the chapter has room.
- `DRY` — the chapter under-delivers comedy the register promises; list the beats that should be carrying it.
- `OVERSWEETENED` — comedy softening beats that should stay sharp; quote each instance.
- `CRINGE` — items that misjudge the target reader; quote each, name the misjudgment.
- `MONOTONOUS` — one mechanism or one source over-recurring; show the counts.

**Blocking rule:** any item scored funniness-1 (partial), portable:yes, or workshopped:yes is a blocking finding regardless of chapter verdict. Blocking findings require revision orders.

`REVISION ORDERS:` one per blocking finding and per verdict-level problem: quote the item, name the failure, and direct the fix — re-source overlay wit into a character's voice (name the voice card), de-workshop the syntax, replace portable wit with material from this book's inventory (name the scene/world material), add or relocate comic beats for DRY/THIN, strip sweetening for OVERSWEETENED. Cutting an item entirely is a valid order; softening it into politeness is not.

## Prompt template (owner=claude)
You are the Comedy Doctor for chapter {NN}. Begin from the Critique stance above. You are not auditing whether the chapter is funny to a generic reader; you are auditing whether it is funny in this book's committed register to this book's target reader.

Inputs:
- Chapter text: {chapter_file}
- The reading guide's comic-register commitment and target-reader description: {reading_guide_target_reader} + {reading_guide}
- Voice cards for the chapter's speakers (who is allowed to be funny, and how): {voice_cards}
- Running-gag/motif tracker state (caps, counts, prior instances): {motif_tracker}
- Calibration notes, if present: {calibration}

Steps:
1. Read the chapter once as the target reader. Mark every item that attempts comedy, including failed attempts — failed attempts are inventory, not omissions.
2. Build the full inventory with all six fields per item. Name mechanisms precisely; classify source honestly — narrator-overlay is the default you must hunt, not excuse.
3. For running-gag instances, check the tracker: instance count vs. cap, and whether this instance varies or repeats the gag.
4. Run the distribution checks (density, mechanism variety, sweetness, cringe) and choose exactly one chapter verdict.
5. Convert every blocking finding into a revision order.

Write the completed audit, in the Required verdict format, to {audit_root}/claude/chapter_{NN}.comedy_doctor.md. Partial / portable / workshopped items are blocking; the chapter is not committable while they stand unresolved.
