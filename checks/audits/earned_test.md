# Audit: Earned Test (announced vs built-to beats)

id: earned_test | owner: codex | tier: risk
trigger: flag:emotional-peak
output: {audit_root}/codex/chapter_{NN}.earned_test.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4324-4326 [BANNED Earned Test]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The source test, applied verbatim:

* Has this emotional beat been built to, or am I announcing it?
* If announced, either build the foundation or scale down.

An **announced** beat asserts emotional magnitude the narrative has not constructed:
the prose tells the reader this moment is devastating / transcendent / the turning
point, while the preceding scenes have not laid the loss, desire, history, or pressure
that would make a reader feel it unprompted. Announcement signatures:

- magnitude adjectives and narrator gloss standing in for built pressure ("everything
  changed," "she would never be the same," "it was the worst thing he could imagine")
- a character weeping / breaking / forgiving at an intensity the on-page relationship
  history has not funded
- a reveal treated as shattering when the reader was never given the prior belief it
  shatters
- a reconciliation or grief peak whose foundation scenes were summarized, not
  dramatized
- music-swell prose (rhythm, fragments, white space) deployed AS the emotion rather
  than releasing emotion already accumulated

A **built-to** beat can be traced backward: name the specific earlier scenes, lines,
promises, and continuity facts that fund it. The audit's core operation is writing that
trace. If the trace cannot be written from the committed manuscript (not from the
outline, not from the story bible — readers don't read those), the beat is announced.

The fix is binary, per the source: **build the foundation** (add/strengthen the funding
beats in earlier scenes or earlier in this chapter) or **scale down** (render the
moment at the intensity the existing foundation actually supports).

## Required verdict format

Per emotional beat audited:

- `BUILT — "<quoted peak line>" — foundation trace: <chapter/scene citations of the beats that fund it, each one line>`
- `ANNOUNCED — "<quoted peak line>" — missing foundation: <what belief/history/pressure the reader was never given> — order: BUILD (<where to add what>) or SCALE-DOWN (<target intensity and what to cut>)`

Chapter verdict:

- `EARNED` — every audited beat BUILT, each with a written foundation trace. A trace
  citing only the story bible or chapter cards is invalid; cite manuscript text.
- `ANNOUNCED-FOUND` — one or more ANNOUNCED beats, each with a BUILD or SCALE-DOWN
  order. The auditor must recommend which of the two and defend the choice.

## Procedure

1. Identify the chapter's emotional peaks: the beats the chapter card commits to
   ("felt experience the reader leaves with"), plus any passage where the prose
   escalates register (fragments, repetition, magnitude language, physical collapse,
   declarations).
2. For each peak, attempt the foundation trace using only committed manuscript text:
   list the prior scenes/lines that establish the stakes, relationship history, belief,
   or pressure the beat spends. Quote or cite each.
3. Check the trace for sufficiency, not existence: one glancing setup line does not
   fund a chapter-climax grief peak. Judge proportionality between foundation mass and
   claimed intensity.
4. Check the peak prose itself for announcement signatures (the list above); quote
   every instance.
5. Write per-beat verdicts and the chapter verdict in the required format.
6. For each ANNOUNCED beat, issue the BUILD or SCALE-DOWN order with concrete targets:
   which earlier chapter/scene gets the new funding beat, or what intensity ceiling the
   scaled-down version must respect. BUILD orders that touch earlier chapters go to the
   revision plan; SCALE-DOWN orders go to the current chapter's revision round.
7. Save the report to the output path. ANNOUNCED-FOUND blocks commit of the flagged
   chapter until orders are executed or rejected with reasons in the revision memo.
