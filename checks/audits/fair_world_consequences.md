# Audit: Fair-World / Consequences Audit

id: fair_world_consequences | owner: codex | tier: risk
trigger: flag:plan-succeeds-easily
output: {audit_root}/codex/chapter_{NN}.fair_world.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4480+ [Reddit 6 #1-2 consequences and failure states]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The model is too *nice*: a character negotiates poorly, but the counterparty agrees
anyway; a terrible decision, but the world bends to accommodate it; the villain
monologues instead of attacking. This kills immersion faster than hallucinations.

**#1 Prompt for Consequences, Not Just Events.** "Be immersive / create interesting
encounters" is too vague — the model interprets "interesting" as "entertaining," which
means giving the protagonist what they want. Instead: **be a fair world, not a friendly
one.** The source's instruction language, verbatim, which this audit enforces on the
page:

* NPCs pursue their own goals. They don't exist to serve my character.
* When I fail or make poor choices, show me the consequences.
* Don't let me talk my way out of everything. Some NPCs are stubborn.

**#2 Define What Failure Looks Like.** The model doesn't know what "failure" means in
the story unless told. Concrete failure states, in the spirit of the source's examples:

* If I'm rude to important NPCs, they remember and treat me accordingly.
* Combat can result in injuries that take time to heal.
* If I ignore a quest for too long, the situation worsens without me.

**The model needs permission to make life harder.** Most models are trained to be
helpful, so they default to smoothing things over; the override has to be enforced.
This book's defined failure states live in {failure_states} (from the world/continuity
scaffolds); they are dead text unless they actually fire on the page.

Two audit questions:

1. **Did any plan succeed without cost?** For every plan, negotiation, gambit, or risky
   decision in the chapter: did the world push back proportionally to the plan's
   quality? Weak plans that succeed because the world bent, or persuasion that works on
   a character established as stubborn, are friendly-world findings.
2. **Do defined failure states ever fire?** For each {failure_states} entry whose
   trigger condition occurred in this chapter (rudeness to someone important, injury
   sustained, a pressure ignored past its clock): did the consequence actually land on
   the page, or was it waived?

## Required verdict format

Per plan/attempt:

- `FAIR — plan: <who attempts what> — plan quality: <sound | flawed, with the flaw named> — world response quoted — cost or pushback: <quoted>`
- `FRIENDLY — plan: <who attempts what> — the flaw the world ignored: <named> — the accommodating passage quoted — what a fair world does instead: <one sentence>`

Per triggered failure state:

- `FIRED — state: <failure_states id> — trigger quoted — consequence quoted`
- `WAIVED — state: <failure_states id> — trigger quoted — no consequence on the page (searched to chapter end and next-chapter card) — firing order required`

Chapter verdict: `FAIR-WORLD` only if zero FRIENDLY and zero WAIVED; otherwise
`FRIENDLY-WORLD`. A FAIR-WORLD verdict must still quote the most accommodating moment
considered and why it survives. `REVISION ORDERS`: per FRIENDLY finding, the concrete
pushback or cost to insert (who resists, what it costs, where it lands); per WAIVED
state, where and how the consequence fires — either in this chapter or as a scheduled
obligation in {thread_ledger}.

## Procedure

1. Load the chapter text, the chapter card, {failure_states}, character sheets (who is
   established as stubborn, hostile, or self-interested), and {thread_ledger}.
2. Enumerate every plan, negotiation, gambit, and risky decision with an on-page
   outcome; judge plan quality on its own merits before reading the outcome.
3. Classify FAIR / FRIENDLY per attempt, quoting the world's response. Persuasion
   succeeding against an established stubborn character requires quoted on-page work
   that earns it; otherwise FRIENDLY.
4. List every {failure_states} entry whose trigger occurred in the chapter; verify each
   fired or log WAIVED.
5. Write the verdicts, chapter verdict, and revision orders in the Required verdict
   format.
6. Write the completed audit to {audit_root}/codex/chapter_{NN}.fair_world.md. A
   FRIENDLY-WORLD chapter is not committable until the orders are executed or rejected
   with reasons in the revision memo.
