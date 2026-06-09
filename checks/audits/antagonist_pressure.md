# Audit: Antagonist-Pressure Audit

id: antagonist_pressure | owner: codex | tier: risk
trigger: cadence:per-act
output: {audit_root}/codex/antagonist_pressure_{act}.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4480+ [Reddit 6 #3 antagonists not obstacles]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

**#3 Use Antagonists, Not Obstacles.** Applied verbatim:

* There's a difference between an obstacle and an antagonist.
* An obstacle is a locked door. You pick it or break it. Done.
* An antagonist is someone who *wants something* that conflicts with what you want.

When villains and rivals are properly defined, they have:

1. **A specific goal they're actively pursuing.**
2. **Resources and allies.**
3. **A reason to not just wait around** — a reason not to attack outright, and equally a
   reason not to sit idle until the protagonist arrives.
4. **Responses to the protagonist's progress** — they scheme off-screen, they make
   moves, the world feels alive because they are actors in it, not boss fights waiting
   to happen.

This audit runs per act and checks **each active antagonist** (every antagonist the
skeleton or character sheets list as active in this act) against all four requirements
**as evidenced on the page in this act's chapters** — not in the planning documents. An
antagonist whose goal, resources, restraint-logic, or counter-moves exist only in the
character sheet has not been written; they have been filed.

Failure smells to hunt for:
* The antagonist appears only when the protagonist walks into them (locked-door
  behavior).
* The antagonist's situation at act end is identical to act start despite protagonist
  progress that damages their interests.
* The antagonist could attack or expose the protagonist now, and the text gives no
  reason why they don't (missing requirement 3 — villain-monologue logic).
* All antagonist activity is reactive narration summarized after the fact, never a move
  that forces the protagonist to respond.

## Required verdict format

Per active antagonist, four requirement lines plus a verdict:

- `REQ-1 GOAL: MET — goal: <named> — pursuit evidenced: <quoted passage(s), chapter refs> | UNMET — best candidate quoted and why it is not active pursuit`
- `REQ-2 RESOURCES/ALLIES: MET — <named, with quoted on-page use> | UNMET`
- `REQ-3 RESTRAINT REASON: MET — why they don't attack outright: <quoted or clearly dramatized logic> | UNMET — the moment they inexplicably hold back, quoted`
- `REQ-4 RESPONDS TO PROGRESS: MET — protagonist move <named> answered by antagonist move <quoted, chapter ref> | UNMET — protagonist progress this act listed, zero answering moves found`

- `VERDICT: ANTAGONIST — all four met` or `VERDICT: OBSTACLE — requirements <list> unmet`

Act verdict: `PRESSURE-LIVE` only if every active antagonist is ANTAGONIST; otherwise
`PRESSURE-DEAD`. A PRESSURE-LIVE verdict must still name the weakest requirement across
all antagonists and quote its evidence. `REVISION ORDERS`: per unmet requirement, a
numbered order specifying the antagonist move to add, which chapter takes it, and what
protagonist cost it imposes — "make the villain more active" without a placed move is
invalid.

## Procedure

1. Load the act's chapters, the skeleton's act outline, character sheets for every
   antagonist active this act, and {thread_ledger} (antagonist-related threads).
2. List the act's active antagonists. For each, gather every on-page appearance,
   mention, and attributable off-screen effect across the act.
3. Score requirements 1-4 strictly from page evidence; sheet-only attributes are UNMET.
4. Build the protagonist-progress list for the act (gains that damage each antagonist's
   interests) and check requirement 4 against it move-for-move.
5. Apply the failure-smell checks; quote every instance found.
6. Write per-antagonist blocks, the act verdict, and the revision orders in the
   Required verdict format.
7. Write the completed audit to {audit_root}/codex/antagonist_pressure_{act}.md. A
   PRESSURE-DEAD act routes its orders into the act's revision plan before the next act
   is drafted.
