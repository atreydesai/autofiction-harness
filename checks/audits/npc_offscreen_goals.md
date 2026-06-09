# Audit: NPC Offscreen-Goals Audit

id: npc_offscreen_goals | owner: codex | tier: risk
trigger: cadence:every-3-chapters
output: {audit_root}/codex/npc_goals_{NN}.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:5122-5134 [Reddit 7 Fix 1: Give NPCs Goals That Don't Involve You] + collation:5111-5118 [Schrödinger's World]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The failure mode, verbatim from source ("The Problem: Schrödinger's World"):

> AI treats your world like a stage play. Characters walk on when needed and vanish when they don't. There's no passage of time. No consequences rippling in the background. No sense that things were happening before you showed up.
> Your world feels empty because, as far as the AI is concerned, it IS empty. The model only processes what's in context. If it's not in the prompt, it doesn't exist.
> This isn't a bug. It's how language models work. But you can absolutely work around it.

The fix, verbatim from source (Fix 1):

> Most people describe NPCs like this:
> Garrett is the blacksmith. He's gruff and honest. He sells weapons.
> That's a prop, not a person. Try this instead:
> Garrett is saving money to move his family out of the city before winter. He's been taking side jobs repairing armor for the city guard, which is making the local merchant guild suspicious. He doesn't trust the guild master.
> Now Garrett has a trajectory. His situation changes between your visits. The AI has material to work with even when your character isn't around.
> NPCs with their own goals become NPCs with their own stories. And their stories can collide with yours.

Goal-profile template (every recurring secondary character must have an entry of this shape in {npc_goals}):
- **Goal:** what they want that does NOT involve the protagonist
- **Current action:** what they are doing about it right now
- **Friction:** who or what their pursuit is irritating, threatening, or entangling
- **Last movement:** chapter NN — what changed in their situation

Audit procedure, for EVERY recurring secondary character (appears in 2+ chapters):
1. Pull their {npc_goals} entry. If absent or prop-shaped ("gruff, honest, sells weapons" — traits + function, no trajectory), that is a finding.
2. Check whether the goal involves the protagonist. A "goal" that only exists in relation to the protagonist (help them, oppose them, wait for them) is a prop goal.
3. Compare the character's situation at their latest appearance vs. their previous appearance. Did anything change offscreen — money, alliances, suspicion, progress, setbacks? If they are in exactly the state the protagonist left them, they FROZE (Schrödinger's world).
4. Check on-page evidence: does the chapter text show or imply the offscreen movement, or does it live only in the tracker file? Tracker-only movement the reader never feels is a half-pass.

## Required verdict format

Per character, one line:
`<NAME>: TRAJECTORY | PROP | FROZEN — evidence: "<quoted tracker entry or chapter line>" — last two appearances: ch NN ("<quote>") vs ch NN ("<quote>")`

- **TRAJECTORY** — has a protagonist-independent goal AND demonstrably moved between appearances. Quote both appearance states to prove the delta; name the strongest freeze-candidate you considered and why it passes.
- **PROP** — entry is traits + shop function, or goal exists only relative to the protagonist. Quote the offending entry.
- **FROZEN** — has an entry but the situation is identical across appearances. Quote the matching states.

Close with:
1. **Schrödinger count:** N of M recurring characters frozen or prop-shaped. More than a third = world-level FAIL flag for the next zoom_out_audit.
2. **Revision orders:** for each PROP/FROZEN character, write (a) the replacement {npc_goals} entry in the goal-profile template above, and (b) one concrete on-page beat (chapter + insertion point) where their offscreen movement should surface. Orders must be executable as written, not "give Garrett more life."

## Edge cases and calibration

- **Single-scene characters:** the recurring bar is 2+ chapters; do not demand trajectories for genuine walk-ons. But a character the outline says will recur gets a goal-profile entry NOW, before their second appearance.
- **Offscreen movement vs noise:** the delta between appearances must be consequential to the character's goal (progress, setback, entanglement), not cosmetic (new coat). Quote the goal the delta serves.
- **Source automation note honored:** per source, "automate this... update NPC pages every now and then" — this audit's tracker rewrites ARE that automation; the orchestrator applies them between chapters, not at end of act.

## Procedure (owner=codex)
1. Read {npc_goals}, the chapter range since the last run of this audit, and the prior npc_goals_{NN}.md report if one exists.
2. Build the recurring-character list mechanically: any named non-protagonist character appearing in 2+ chapters of the manuscript so far. Do not let the tracker define the list — characters missing from {npc_goals} are findings, not exemptions.
3. For each character, execute steps 1-4 of the audit procedure above, quoting evidence verbatim from tracker and chapters.
4. Emit the per-character verdict lines, the Schrödinger count, and the revision orders.
5. Write the report to the output path. Any PROP or FROZEN verdict marks the report ACTIONABLE; the orchestrator queues the revision orders and the {npc_goals} rewrite before the next drafting block.
