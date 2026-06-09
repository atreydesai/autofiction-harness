# Audit: Unresolved-Threads Protection Audit

id: unresolved_threads | owner: codex | tier: core
trigger: every-chapter
output: {audit_root}/codex/chapter_{NN}.unresolved_threads.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4399-4478 [Reddit 5 Fix 1 + Quick Test]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

**Fix 1: Tell the model what's NOT supposed to resolve yet.** Before a scene, the
conflicts that should remain unresolved are stated explicitly, in the spirit of the
source's examples:

* "The tension between Mira and Kael is NOT resolved in this scene. They're still circling around the issue."
* "The mystery of the missing letters should deepen, not get answered."
* "This scene is about suspicion growing, not confrontation happening."

If the model is not told to leave threads open, it will tie them all up. The protected
list is a to-do list for what should stay messy. In this harness, that list is the
**protected entries of {thread_ledger}** — each entry names a thread, its protected
status, and the earliest chapter at which it may resolve.

**The Quick Test (applied verbatim to this chapter's scenes):** How many conflicts were
introduced AND resolved within the same scene? If the answer is most of them, the story
is sprinting when it should be jogging. The repair posture from the source: protect a
thread from resolution, let it sit, let it spread, let characters carry it into the next
scene without talking about it.

What counts as resolution (any of these fires the verdict):
* The conflict is confronted and settled on the page.
* A mystery protected as "deepens, not answered" gets answered, or gets a partial answer
  that removes the question's pull.
* Characters explicitly clear the air about a tension that is supposed to keep circling.
* An external pressure protected as ongoing is neutralized as a side effect of the
  chapter's events.

Deepening, complicating, or shifting a protected thread is not resolution — it is the
desired behavior. Distinguish carefully and quote the evidence either way.

## Required verdict format

One verdict line per protected entry in {thread_ledger} that the chapter touches (and a
`NOT-TOUCHED` line for protected entries it does not touch):

- `PROTECTED-HELD — thread: <ledger id/name> — strongest resolution-candidate moment quoted — why it is not resolution: <deepens | shifts | sits unspoken>`
- `PREMATURELY-RESOLVED — thread: <ledger id/name> — the resolving passage quoted — earliest permitted resolution: chapter <N> per ledger — what the resolution forecloses`
- `NOT-TOUCHED — thread: <ledger id/name>`

Then the Quick Test block:
- `QUICK-TEST: <k> of <n> conflicts introduced in this chapter were resolved within their own scene — verdict: JOGGING (k/n minority) | SPRINTING (k/n majority)` — list each same-scene-resolved conflict with intro and resolution quoted.

Chapter verdict: `THREADS-SAFE` only if zero PREMATURELY-RESOLVED and QUICK-TEST is
JOGGING; otherwise `THREADS-BROKEN`. Then `REVISION ORDERS`: per broken thread, a
numbered order to reopen it (un-say the settlement, restore the question, or convert the
resolution into a complication), and per SPRINTING verdict, which same-scene resolution
to defer and to where.

## Procedure

1. Load the chapter text, the chapter card, and {thread_ledger}; extract every
   protected entry and its earliest-resolution chapter.
2. For each protected entry, find every passage in the chapter that touches the thread.
   Judge held vs. resolved using the four resolution tests above; quote evidence for
   every verdict including PROTECTED-HELD (the strongest resolution-candidate moment).
3. Independently list every conflict the chapter itself introduces; for each, check
   whether it resolves within the same scene. Compute the Quick Test ratio.
4. Write per-thread verdicts, the Quick Test block, the chapter verdict, and the
   revision orders in the Required verdict format.
5. Flag any thread the chapter resolves that is absent from {thread_ledger} entirely as
   `LEDGER-GAP` with the passage quoted — the ledger owner must classify it.
6. Write the completed audit to {audit_root}/codex/chapter_{NN}.unresolved_threads.md.
   A THREADS-BROKEN chapter is not committable until the orders are executed or rejected
   with reasons in the revision memo.
