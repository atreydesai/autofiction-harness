# Audit: Surprise Audit (the unpredicted move)

id: surprise_audit | owner: codex | tier: core
trigger: every-chapter
output: {audit_root}/codex/chapter_{NN}.surprise_audit.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: legacy editor Surprise Audit

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Per chapter: identify the **surprise move** — the turn the reader doesn't predict.
Default-register model output is predictable beat-to-beat; a chapter with no unpredicted
move reads as machinery. Surprise density is one of the highest-leverage levers for
reader engagement.

Categories of surprise move (the move must belong to at least one):

1. **Plot turn** — an event the prior pages did not telegraph.
2. **Character revelation** — a character does or wants something that reframes them.
3. **Register shift** — the prose register breaks pattern at a chosen moment.
4. **Striking image** — an image too specific and too odd to have been predicted.
5. **Format break** — the chapter's form itself does something unannounced.
6. **Comedic non-sequitur** — a swerve that earns its laugh by being unforecastable.

Hard rule from the source: **"Generally surprising" without a specific quoted move is a
FAILED audit.** The auditor must either quote the move or return PREDICTABLE. Vague
credit ("the chapter has good energy," "several unexpected touches") is the exact
agreement-bias failure this audit exists to block.

A candidate move does not count if: (a) a first-time reader tracking the chapter cards
would see it coming, (b) it is a stock genre beat dressed in local vocabulary, or (c) it
surprises only by being arbitrary — surprise must still be retrospectively coherent with
established character and world.

## Required verdict format

- `SURPRISES — category: <one of the six> — THE MOVE: "<quoted text of the move, exact>" — location: <scene/paragraph> — why unpredicted: <what the prior pages led the reader to expect instead> — why coherent: <what already-established material retroactively supports it>`
- `PREDICTABLE — strongest candidate considered: "<quote>" — why it fails: <telegraphed | stock beat | arbitrary> — PROPOSALS: at least two concrete surprise-move proposals, each tagged with a category, placed at a named location in the chapter, and consistent with {calibration} register and continuity`

A chapter may log multiple SURPRISES lines (one per genuine move). One genuine quoted
move is sufficient to pass; zero is PREDICTABLE.

Then `REVISION ORDERS`: for PREDICTABLE chapters, convert each proposal into a numbered
order (insertion point, the move, what surrounding prose must change to absorb it). For
SURPRISES chapters with a single thin move, an optional amplification order is allowed
but must be marked OPTIONAL.

## Procedure

1. Load the chapter text, the chapter card, {calibration} (register commitments — a
   register shift only counts as surprise relative to the calibrated baseline), and
   prior-chapter context sufficient to know what a reader already expects.
2. Read the chapter as a first-time reader; at each scene boundary, write down the
   expected next beat before reading on. A move that matches your written expectation is
   not a surprise.
3. Collect candidate moves; test each against the six categories and the three
   disqualifiers (telegraphed / stock / arbitrary). Quote every surviving move exactly.
4. If no candidate survives, the verdict is PREDICTABLE. Draft at least two proposals in
   distinct categories, each placed at a named location and checked against continuity
   and {calibration}. Proposals that "raise the stakes generally" are not proposals.
5. Write the verdicts and revision orders in the Required verdict format.
6. Write the completed audit to {audit_root}/codex/chapter_{NN}.surprise_audit.md. A
   PREDICTABLE chapter is not committable until an order is executed or rejected with
   reasons in the revision memo.
