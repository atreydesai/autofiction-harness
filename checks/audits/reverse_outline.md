# Audit: Reverse-Outline / Structural Audit

id: reverse_outline | owner: codex | tier: book
trigger: phase:full-book-critique
output: {audit_root}/codex/book.reverse_outline.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:5466-5478 [Academic manual causal spine]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The source criteria (Academic novel manual, "Structure, outline, and the causal spine"):

- You do not need a rigid formula, but you do need a **causal spine**. Structure means
  the ordering of decisions, reversals, revelations, and consequences so that each
  major movement arises from prior conditions rather than authorial convenience.
- Forster: plot is narrative with causality foregrounded. Many draft problems diagnosed
  as "pacing" or "middle sag" are actually structural problems in which **events are
  adjacent but not causally loaded.**
- A robust structure identifies: **the opening disturbance; the first committed action;
  the first irreversible complication; the midpoint reframe or revelation; the point at
  which retreat becomes harder than action; the crisis decision; the climactic
  confrontation; and the post-climax settlement.** Their function is diagnostic: if you
  do not know where your protagonist stops being able to go back, you may not yet have
  stakes; if you do not know what they learn or mislearn halfway through, you may not
  yet have a developing argument.
- The **reverse logic test**: take the ending in one paragraph, then ask of each
  earlier major turn: what must be true for this ending to become inevitable but still
  surprising? If a late twist depends on a fact the earlier novel never prepares, you
  do not have structure; you have concealment. Conversely, if a reader can predict
  every movement from page thirty, you may have inevitability without surprise.

Causal-link logic (same manual): an idea that can only generate "and then, and then"
has story, not plot; plot requires cause-and-effect pressure — "X tries Y; **therefore**
Z changes." Each chapter link is graded THEREFORE/BUT (caused or forced by the prior
chapter) versus AND-THEN (merely subsequent).

This is a book-level audit: the outline is rebuilt **FROM the manuscript**, never copied
from the skeleton or chapter cards. The reverse outline is evidence of what the book
actually does; the planning artifacts are what it was supposed to do.

## Required verdict format

Per chapter, one entry:

```
Ch <NN> — <one sentence: what irreversibly changes in this chapter>
  link to Ch <NN+1>: THEREFORE | BUT | AND-THEN — <one sentence naming the causal load, or its absence>
```

A chapter where you cannot state what changes gets `NO-CHANGE` in place of the sentence
and is automatically a finding.

Landmark table — locate each, with chapter number and quoted evidence, or mark MISSING:
opening disturbance / first committed action / first irreversible complication /
midpoint reframe or revelation / point where retreat becomes harder than action /
crisis decision / climactic confrontation / post-climax settlement.

Reverse logic test: ending paragraph + per-major-turn line: `PREPARED — setup at Ch <NN>:
"<quote>"` or `CONCEALED — no preparation found` or `TELEGRAPHED — predictable from Ch <NN>`.

Book verdict:

- `SPINE-INTACT` — no AND-THEN links, no NO-CHANGE chapters, no MISSING landmarks, no
  CONCEALED turns. Still list the three weakest THEREFORE links with evidence.
- `SPINE-BREAKS` — otherwise. Every AND-THEN, NO-CHANGE, MISSING, and CONCEALED item
  gets a revision order: `RESTRUCTURE Ch <NN>: <cut / merge / move / add causal load —
  what prior condition must this chapter consume, what consequence must it emit>`.

## Procedure

1. Read the full manuscript in order. Do NOT open the skeleton, chapter cards, or any
   planning artifact until step 5 — the reverse outline must come from the text alone.
2. For each chapter write the one-sentence what-changes entry. Be ruthless: "we learn
   more about X" is not a change; quote the line that makes the change irreversible.
3. Grade every consecutive link THEREFORE / BUT / AND-THEN. Default skeptically to
   AND-THEN unless you can quote the prior-chapter condition this chapter consumes.
4. Fill the landmark table and run the reverse logic test against the actual ending.
5. Now diff against the skeleton/chapter cards: divergences are findings only where the
   manuscript's version is structurally weaker.
6. Write verdicts in the required format; convert all findings into revision orders and
   queue them into the full-book revision plan (Phase 2-style surgery candidates).
7. Save the report to the output path. `SPINE-BREAKS` blocks final assembly until orders
   are executed or explicitly rejected with reasons.
