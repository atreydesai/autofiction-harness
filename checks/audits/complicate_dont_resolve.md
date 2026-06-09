# Audit: Complicate-Don't-Resolve Audit

id: complicate_dont_resolve | owner: codex | tier: risk
trigger: sample:every-2nd-chapter
output: {audit_root}/codex/chapter_{NN}.complicate.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4399+ [Reddit 5 Fix 2]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

**Fix 2: Complicate, Don't Resolve** — a screenwriting principle that transfers
perfectly to model-drafted prose. Applied verbatim:

* Every scene should either make things *worse* or make them *different*. Not better.
  Not resolved. Worse or different.
* The question isn't "how does this get fixed?" It's "how does this get more
  complicated?"

The source's operating instructions, which this audit enforces on the page:

* When a problem arises, add a complication rather than a solution.
* If a character tries to fix something, it should partially work but create a new issue.
* Success always comes with a cost or a catch.

Why this matters: the model's instinct is to be helpful, and helpful means solving
problems, so problems evaporate instead of evolving and the story loses momentum.
Stories hold momentum when problems don't evaporate — they evolve.

Per scene, classify the net movement of the scene's central problem(s):

1. **WORSE** — the problem deepened, spread, or raised its cost.
2. **DIFFERENT** — the problem transformed: a fix partially worked but created a new
   issue; success arrived with a cost or a catch; the question changed shape.
3. **BETTER/RESOLVED** — the problem shrank or closed with no new complication
   attached. This is the failure state.
4. **STATIC** — no problem moved at all (route this scene to the Consequence Test as
   well; here it logs as a finding because a scene that moves nothing also complicates
   nothing).

Exception handling: scenes whose chapter card explicitly schedules a resolution (an
earned payoff at its ledgered chapter) are exempt from the BETTER/RESOLVED failure —
but only if the resolution itself ships with a cost, catch, or successor problem.
Quote the card line that licenses it and the successor problem on the page.

## Required verdict format

One verdict line per scene:

- `WORSE — scene <n> — problem: <named> — escalation quoted`
- `DIFFERENT — scene <n> — problem: <named> — the partial fix quoted + the new issue it created quoted`
- `BETTER/RESOLVED — scene <n> — problem: <named> — the resolving passage quoted — cost or catch attached: NONE — licensed by chapter card: <quote or NO>`
- `STATIC — scene <n> — strongest candidate problem considered, quoted, and why it never moves`

Chapter verdict: `COMPLICATES` only if zero unlicensed BETTER/RESOLVED and zero STATIC;
otherwise `RESOLVES-TOO-CLEAN`. A COMPLICATES verdict must still quote the scene that
came closest to clean resolution and say why it survives.

`REVISION ORDERS`: per failed scene, a numbered order answering the source question —
"how does this get more complicated?" — with a concrete complication: the fix partially
works but creates a named new issue, or the success acquires a named cost or catch.

## Procedure

1. Load the chapter text, the chapter card (for licensed resolutions), and
   {thread_ledger} (to distinguish scheduled payoffs from premature smoothing).
2. Segment into scenes; for each, name the central problem(s) in play at scene start.
3. Track each problem to scene end and classify WORSE / DIFFERENT / BETTER-RESOLVED /
   STATIC, quoting the passage that proves the classification.
4. For every BETTER/RESOLVED, check the chapter card and ledger for a license; if
   licensed, verify a cost, catch, or successor problem is on the page and quote it.
5. Write per-scene verdicts, the chapter verdict, and the revision orders in the
   Required verdict format.
6. Write the completed audit to {audit_root}/codex/chapter_{NN}.complicate.md. A
   RESOLVES-TOO-CLEAN chapter is not committable until the orders are executed or
   rejected with reasons in the revision memo.
