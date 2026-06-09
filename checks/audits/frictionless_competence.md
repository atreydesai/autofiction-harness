# Audit: Frictionless-Competence-Fantasy Audit

id: frictionless_competence | owner: codex | tier: risk
trigger: watch:competence-porn
output: {audit_root}/codex/chapter_{NN}.frictionless_competence.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:3588+ [field guide 16]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The source entry (field guide 16, THE FRICTIONLESS COMPETENCE FANTASY), faithful to the text:

> Your character notices a problem. It has already been solved.
> "Have it replaced." "Already prepared, Master. The new plate is in the workshop."
> Your character's bath is drawn perfectly. Their robe is laid out. The sandglass was turned at exactly the right time. Every servant anticipates every need. No plan encounters real resistance. No preparation is ever inadequate.
> This is AI's default because conflict is hard to generate and competence is easy to assert. The fix: let something go wrong. Let the character encounter a problem that hasn't been anticipated. Let a servant mess up. Let the plan be slightly inadequate and require adaptation.

Concrete patterns to hunt, per the source:

1. **Problem-already-solved beats.** A character notices a problem and a subordinate, system, ally, or coincidence has already handled it ("Already prepared, Master").
2. **Perfect-service texture.** Baths drawn perfectly, robes laid out, the sandglass turned at exactly the right time — world logistics that anticipate every need; the modern equivalents (the file already pulled, the contact already briefed, the gear already packed, the route already cleared) count equally.
3. **Resistance-free plans.** A plan is made and then executes without real resistance; no preparation ever proves inadequate; no step requires adaptation.
4. **Asserted competence.** Competence stated by the narrator or admired by other characters rather than demonstrated against friction.

The fix-direction (the source's, restated for revision orders): something must go wrong — an unanticipated problem, a subordinate's mistake, a plan slightly inadequate and requiring on-page adaptation.

Calibration: a single smooth beat is not a finding; the fantasy is cumulative. Deliberate frictionlessness that the book is setting up to break (a too-perfect operation before a collapse the chapter card promises) passes if the setup is named — cite the chapter card or {reading_guide}. Interpersonal/psychological over-competence belongs to the characters_wrong audit; this audit owns plans, logistics, service, and execution.

## Required verdict format
Per instance:
- `FRICTIONLESS — <pattern 1|2|3|4> — "<quoted passage>" (location) — what should have resisted: <the inadequacy/mistake/unanticipated problem the beat suppressed>`
- `EARNED-SMOOTH — "<quoted passage>" — why the smoothness is doing deliberate work (cite card/guide)`

Plan ledger (one line per plan or operation in the chapter):
- `PLAN <name/location>: resistance met: <quoted> | NONE — executed as conceived`

Chapter verdict:
- `FRICTION-PRESENT` — no pattern accumulation; every plan met resistance or its smoothness is earned. Must still quote the smoothest surviving beat and say why it stands.
- `COMPETENCE-FANTASY (<n> instances)` — accumulated frictionless beats and/or any plan with resistance NONE unearned.

`REVISION ORDERS:` one per finding: quote the beat, choose the fix mode (unanticipated problem / subordinate or system failure / plan inadequacy requiring adaptation), and state what the friction costs (time, trust, resources, injury, standing) so the fix cannot be cosmetic. "Add an obstacle" without a named cost is an invalid order.

## Procedure
1. Load the chapter, the chapter card (planned function and promised setups), {reading_guide} excerpts, the mechanical watch counts for competence-porn patterns ({watch_counts}), and {calibration} if present. Watch counts are leads, not verdicts — verify each in context.
2. Inventory every plan, task, operation, or service interaction in the chapter. For each, walk its execution and record every point of real resistance with a quote; if none exists, record `NONE`.
3. Sweep for the four patterns. Quote each instance. For problem-already-solved beats, quote both the noticing and the pre-solved response.
4. Test smooth beats against the earned-smoothness exception; require a named setup (chapter card or reading guide) to grant it.
5. Assemble the plan ledger and per-instance verdicts; rule the chapter verdict.
6. Convert findings to revision orders with named costs; write the report in the required format to the output path.
7. Queue COMPETENCE-FANTASY orders into the current revision round; record acceptance or rejection with reasons in the revision memo.
