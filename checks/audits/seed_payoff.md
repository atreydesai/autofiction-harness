# Audit: Seed/Payoff Audit (vs thread ledger)

id: seed_payoff | owner: codex | tier: risk
trigger: cadence:every-5-chapters
output: {audit_root}/codex/seed_payoff_{NN}.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4854+ [Reddit 5 Fix 5] + thread ledger scaffold

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

**Fix 5: Plant Seeds, Don't Deliver Payoffs.** Great writers set things up long before
they pay off. **The model almost never does this unprompted.** A seed is a detail that
means nothing now but will mean everything later. The source's planting instructions:

* "Include a minor detail in this scene that could become significant later."
* "Have a character mention something offhand that connects to the larger plot."
* "Describe something in the environment that feels slightly out of place."

Then, chapters later, the payoff calls back to the seed ("Remember the broken clock in
the tower from the first chapter? It matters now."). This creates the feeling of a story
that was planned all along. Readers love feeling like everything is connected.

This audit runs every 5 chapters and reconciles the manuscript window against the
seeds and payoff-obligations sections of {thread_ledger}. Three questions:

1. **Were seeds planted recently?** The last 5-chapter window should contain new seeds —
   minor details, offhand mentions, out-of-place environmental notes — registered in the
   ledger or registrable now. A window with zero new seeds means the model is doing what
   it does unprompted: nothing.
2. **Are payoffs approaching their chapters?** For every ledger payoff-obligation due
   within the next act: is its seed actually on the page in a prior chapter (quote it)?
   Is the seed still alive (not contradicted, not cut in revision)? Does it need a
   refresh mention before the payoff fires?
3. **Did payoffs fire without setup?** Any reveal, rescue, weapon, skill, or connection
   in the window that the text treats as prepared but that no earlier chapter planted.
   This is the inverse failure: payoff delivered, seed never planted.

A seed only counts if it is genuinely minor at planting — a detail that means nothing
now. A planting that announces its own significance is foreshadowing-as-neon, not a
seed; log it as a finding (DEGRADE order: mute the planting).

## Required verdict format

Per ledger seed/payoff entry plus per discovered unledgered item:

- `SEEDED — entry: <ledger id> — planting quoted (chapter <N>) — still alive: yes — payoff due: chapter <N>`
- `SEEDED-BUT-STALE — entry: <ledger id> — planting quoted — staleness: <contradicted | cut | too distant without refresh> — refresh order required`
- `UNSEEDED-PAYOFF-DUE — entry: <ledger id> — payoff due chapter <N> — no planting found (searched chapters <range>) — planting order required`
- `FIRED-WITHOUT-SETUP — passage quoted (chapter <N>) — what it assumes was planted — nothing found in chapters <range>`
- `NEON-PLANTING — passage quoted — why it announces itself — mute order required`

Window line: `WINDOW chapters <N-M>: <k> new seeds planted — verdict: PLANTING (k>=2) | BARREN (k<2)` — quote each new seed.

Overall verdict: `LEDGER-RECONCILED` only if no UNSEEDED-PAYOFF-DUE, no
FIRED-WITHOUT-SETUP, and the window is PLANTING; otherwise `SEED-DEBT`. Then
`REVISION ORDERS`: numbered planting orders (which chapter takes the seed, what the
minor detail is, why it reads as minor), refresh orders, and mute orders. Planting
orders go to the earliest revisable chapter, never the payoff chapter itself.

## Procedure

1. Load {thread_ledger} (seeds and payoff-obligations sections), the last 5 chapters in
   full, and the skeleton/chapter cards for upcoming payoff chapters.
2. For each ledger seed entry, locate and quote its planting in the manuscript; verify
   it survived revision and is not contradicted. Classify SEEDED / SEEDED-BUT-STALE.
3. For each payoff-obligation due within the next act, confirm a quotable planting
   exists; otherwise UNSEEDED-PAYOFF-DUE.
4. Sweep the 5-chapter window for payoffs that fired without setup and for new seeds;
   register genuine new seeds (propose ledger entries), flag neon plantings.
5. Compute the window planting verdict; write all verdict lines, the overall verdict,
   and the revision orders in the Required verdict format.
6. Write the completed audit to {audit_root}/codex/seed_payoff_{NN}.md and propose the
   corresponding {thread_ledger} updates. A SEED-DEBT verdict blocks the next window's
   chapters until planting orders are scheduled or rejected with reasons.
