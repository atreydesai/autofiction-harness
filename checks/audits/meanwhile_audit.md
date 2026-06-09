# Audit: Meanwhile Audit (offscreen world motion)

id: meanwhile_audit | owner: codex | tier: risk
trigger: cadence:every-3-chapters
output: {audit_root}/codex/meanwhile_{NN}.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:5138-5149 [Reddit 7 Fix 2: The "Meanwhile" Prompt]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Source technique, verbatim (Fix 2):

> This one's dead simple and unreasonably effective.
> At the start of a session, before you dive into action, ask the AI what happened while you were away. Something like:
> Before we begin, briefly describe 2-3 things that have happened in [location] since my last visit. Consider ongoing NPC goals, recent events, and the passage of time. Not everything needs to involve my character.
> This does two things: it fills the world with life, and it seeds future plot hooks without you having to invent them.
> Some of my best storylines came from throwaway "meanwhile" details I decided to pursue later. The AI mentioned a merchant caravan that went missing. I wasn't supposed to care. I cared.
> The world gets interesting when things happen without your permission.

Timing guidance from source: run this at the START of a session/block, BEFORE diving into action — i.e., the ledger must be refreshed before the next drafting block begins, not reconstructed after the fact.

In this harness the audit both CHECKS and PRODUCES. It maintains a **meanwhile ledger** (meanwhile_ledger.md beside the trackers): for every offscreen actor, faction, and previously visited location, what did they do during the last N chapters (N = chapters since the last run)?

Checks, per offscreen actor/faction/location:
1. **Ledger coverage.** Is there an entry covering the audited chapter range? Missing entry = the world stopped there.
2. **Motion quality.** Does the entry record an EVENT (something happened: progress, setback, rumor, price shift, departure, death) or a restatement of static traits? Restatement = no motion.
3. **Protagonist independence.** Per source: "Not everything needs to involve my character." If every ledger event bends toward the protagonist, the world is a stage play. At least some events must be indifferent to the protagonist.
4. **Hook seeding.** Does at least one entry in the range plant a pursuable hook (the missing-caravan kind — a detail the reader "wasn't supposed to care" about)? Quote it. Zero hooks across the range = finding.
5. **Surfacing.** Did any ledger motion from the PREVIOUS run actually surface on-page in the audited chapters (a rumor, a changed price, an absent face)? Ledger motion that never reaches the page is bookkeeping, not a living world.

## Required verdict format

Per actor/faction/location, one line:
`<NAME>: MOVED | STATIC | UNTRACKED — ledger: "<quoted entry or ABSENT>" — on-page surfacing: "<quoted chapter line or NONE>"`

- **MOVED** — event-shaped ledger entry for the range; quote it, and quote the strongest static-candidate phrasing you considered before passing it.
- **STATIC** — entry exists but restates traits or repeats the prior entry. Quote both to show the repetition.
- **UNTRACKED** — actor/faction/location exists in the manuscript but has no ledger line for the range.

Then:
1. **Range verdict:** WORLD-IN-MOTION / STAGE-PLAY (majority static/untracked) / NO-LEDGER (ledger missing or stale — automatic FAIL).
2. **Refreshed ledger block:** the new/updated entries for the audited range, 2-3 events per tracked location, each tagged [hook] / [indifferent] / [protagonist-adjacent]. This block is the produced artifact; copy it into meanwhile_ledger.md.
3. **Revision orders:** for each STATIC/UNTRACKED finding and for any zero-surfacing range, a concrete order — which chapter, which scene, what one-line meanwhile detail to thread in. No "add more world texture" orders.

## Edge cases and calibration

- **Scope of "tracked":** only actors/factions/locations the manuscript has actually established matter. Do not order ledger entries for one-line walk-ons; the bar is narrative weight (named + given a goal, or visited on-page).
- **Hook discipline:** hooks are seeds, not obligations — log them in the ledger tagged [hook] so the seed/payoff ledger can adopt or retire them deliberately rather than letting them dangle by accident.
- **Plausibility gate:** every generated ledger event must be reachable from the actor's last known state within the elapsed {timeline} days. A faction cannot raise an army in a week; flag any inherited ledger entry that already violates this.
- **Surfacing dosage:** the fix is one-line texture, not exposition dumps. Orders should specify a single rumor/price/absence detail, never a recap paragraph.
- **Source's payoff promise, kept in view:** "Some of my best storylines came from throwaway 'meanwhile' details" — when generating ledger events, prefer ones a later chapter could pursue over inert color.

## Procedure (owner=codex)
1. Read meanwhile_ledger.md (create the skeleton if absent — that itself is a NO-LEDGER finding for this run), {npc_goals}, {timeline}, and the chapters drafted since the last meanwhile_{NN}.md.
2. Enumerate offscreen actors/factions/locations: everything the manuscript has established that does NOT appear on-page in the audited range.
3. Run checks 1-5 per item, quoting ledger and chapter evidence verbatim.
4. Generate the refreshed ledger block by applying the source prompt to each tracked location: "briefly describe 2-3 things that have happened in [location] since the last on-page visit; consider ongoing NPC goals, recent events, and the passage of time; not everything needs to involve the protagonist." Events must be consistent with {npc_goals} trajectories and {timeline}.
5. Write the report to the output path and update meanwhile_ledger.md BEFORE the next drafting block starts, per the source's session-start timing. STAGE-PLAY or NO-LEDGER verdicts mark the report ACTIONABLE.
