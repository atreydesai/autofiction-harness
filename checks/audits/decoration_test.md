# Audit: Decoration Test (ornament vs work)

id: decoration_test | owner: codex | tier: risk
trigger: watch:figuration-density
output: {audit_root}/codex/chapter_{NN}.decoration_test.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:1854-1862 [BANNED Decoration Test]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The source test, applied verbatim:

* Does this metaphor / description / sensory detail clarify or just ornament?
* If it only ornaments, cut it.

Three element classes are in scope: metaphors (including similes and personification),
descriptions (of place, weather, light, objects, faces), and sensory details. For each
element, the question is whether it does **work** for the story or merely decorates it.

An element CLARIFIES when removing it would cost the reader something concrete:

- scene logistics (where bodies and objects are, what just changed)
- focalizer perception (what this character notices and why, under this pressure)
- plot-bearing information (a detail that pays off, foreshadows, or carries continuity)
- characterization (the detail is one only this character would register)
- calibrated register work the reading guide declares load-bearing (mood, comedy,
  menace executed in the book's declared register, not generic atmosphere)

An element ORNAMENTS when its only function is to make the prose feel written:
atmosphere stacked on a scene whose mood is already established, sensory inventory
present because description slots "should" be filled, figuration that intensifies
without adding new physical or psychological information, lyric texture in a passage
whose job is motion. The deletion test is decisive: remove the element and reread the
passage. If nothing is lost but word count and perfume, it only ornaments — and per the
source rule, the action is CUT, not soften, not trim, not "make it earn its place."
Rewrite-instead-of-cut is allowed only when the slot itself is load-bearing (the scene
genuinely needs the reader to see the room) and the order must then specify what the
replacement detail must clarify.

The reading guide is authoritative on register: if it binds the book to a dense, lyric,
or maximal register, density itself is not ornament — but each element must still pass
the deletion test against THAT register's purposes.

## Required verdict format

Per element:

- `CLARIFIES — "<quoted element>" — work done: <logistics | perception | plot | character | calibrated register> — what deletion would cost: <one line>`
- `ORNAMENT — "<quoted element>" — deletion test: passage loses nothing because <one line> — order: CUT (default) or REPLACE with detail that clarifies <named need>`

Chapter verdict:

- `WORKING` — all audited elements CLARIFIES. Quote the 3 closest calls and defend them.
- `DECORATED` — list every ORNAMENT with its CUT/REPLACE order and the resulting
  expected word-count delta.

## Procedure

1. Pull the watch:figuration-density hit list from the pattern registry for this
   chapter; add every metaphor/simile/personification, every description block over
   two sentences, and every sensory-detail cluster (two or more sense impressions in
   one paragraph).
2. Load the reading guide's register binding and any declared atmospheric/lyric
   license so calibrated register work is not misclassified as ornament.
3. For each element, run the deletion test: reread the passage without it and record
   concretely what (if anything) is lost, in which of the five work categories.
4. Issue per-element verdicts in the required format. Default action for ORNAMENT is
   CUT; justify any REPLACE by naming the load-bearing need the slot serves.
5. Compute the ornament ratio (ORNAMENT count / audited count). Above ~25%, escalate:
   recommend the chapter for a figuration_audit pass (Claude) in addition to the cuts,
   since the problem is systemic, not local.
6. Save the report to the output path and queue all CUT/REPLACE orders into the
   current revision round. DECORATED does not block commit by itself, but unexecuted
   orders must be carried in the revision plan, not dropped.
