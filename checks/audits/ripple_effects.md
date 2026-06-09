# Audit: Ripple-Effects Audit (event consequences propagate)

id: ripple_effects | owner: codex | tier: risk
trigger: event:major-plot-event
output: {audit_root}/codex/chapter_{NN}.ripple_effects.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:5172-5187 [Reddit 7 Fix 4: Consequences Have Ripples]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Source, verbatim (Fix 4), including its event-tracking guidance:

> You killed the bandit leader three sessions ago. Cool. What happened to his gang? Did they scatter? Did someone new take over? Did the town start to recover, or did something worse move into the power vacuum?
> First-order consequences are obvious. Second-order consequences are where the world comes alive.
> During your session prep or "meanwhile" prompt, tell AI:
> - When major events happen, their effects should spread to connected NPCs and locations.
> - Not everything resolves cleanly. Some consequences take time to play out.
> The AI won't track this by itself, although some models are better at it. It'll happily let you kill a bandit leader and never think about it again. But if you prompt it to consider ripple effects, suddenly your actions carry weight.
> This is where a good lore system pays off. Whether you're tracking events in a compendium [...] or even a plain text file. The more history you feed the AI, the more interconnected the world feels. Past events stop being isolated moments and start forming a web.
> So here's where prior worldbuilding becomes important too. If you built interconnected cities, events will impact nearby ones.

Fires on each major plot event (death, betrayal, battle, public revelation, regime/leadership change, destruction, large theft or windfall). For the triggering event, audit the chapters AFTER it:

1. **Propagation map.** Who heard about the event, and how fast? List every character/faction/location connected to the event; for each, quote the on-page moment they learn of it (or mark UNAWARE and judge whether their ignorance is plausible given travel/communication speed and elapsed {timeline} days).
2. **First-order consequences.** The obvious direct effects — present on page? Quote them.
3. **Second-order consequences.** Per source, "where the world comes alive": gang scatters or new leader rises; town recovers or something worse fills the vacuum. What changed in (a) behavior of connected characters, (b) economy — prices, trade, work, scarcity, (c) relationships and power balances? Quote evidence per category or mark ABSENT.
4. **Unclean resolution.** "Not everything resolves cleanly. Some consequences take time to play out." Is at least one consequence still open, delayed, or worsening chapters later? An event whose fallout fully resolves within one chapter is suspiciously tidy.
5. **Web formation.** Does the event connect to PRIOR events (cross-reference the events section of continuity trackers / meanwhile_ledger.md), or does it sit isolated? "Past events stop being isolated moments and start forming a web."

## Required verdict format

Open with: `EVENT: <description> — ch NN — connected parties: <list>`

Then per criterion:
`PROPAGATION: PASS|FAIL — per party: <name>: HEARD ch NN "<quote>" | UNAWARE (plausible: yes/no, reasoning)`
`FIRST-ORDER: PASS|FAIL — "<quote>" or ABSENT`
`SECOND-ORDER: PASS|FAIL — behavior: "<quote>"/ABSENT; economy: "<quote>"/ABSENT; relationships: "<quote>"/ABSENT`
`UNCLEAN: PASS|FAIL — open consequence: "<quote>" or ALL-RESOLVED-TIDILY`
`WEB: PASS|FAIL — linked prior events named, or ISOLATED`

PASS lines must show work: name the parties checked and quote the weakest propagation you accepted. Close with:
1. **Event verdict:** RIPPLES / FIRST-ORDER-ONLY / FORGOTTEN (event never referenced again after its chapter — the bandit-leader failure, automatic FAIL).
2. **Revision orders:** per ABSENT/FAIL, a concrete insertion — chapter, scene, and the specific ripple beat (who reacts, what price shifts, which relationship sours), each tagged first-order or second-order. Update the event-tracking entry in the continuity tracker with the ripple list so meanwhile_audit inherits it.

## Edge cases and calibration

- **Recency window:** if the event happened within the last chapter and almost no story time has elapsed, ripples may legitimately not have arrived yet. Verdict then is RIPPLES-PENDING with a due-by chapter; the orchestrator re-fires this audit at that chapter instead of passing the event.
- **Secret events:** an event no one witnessed propagates differently — audit the cover-up (who is hiding it, what behavior betrays the hiding) instead of public knowledge. Zero behavioral trace of a secret is still a FAIL.
- **Economy scale:** "economy" scales to the book — in a domestic novel it is chores, money worries, and who cooks; do not demand grain prices from a marriage drama.
- **Second-order standard:** at least ONE second-order consequence on-page is the floor for RIPPLES; do not demand all three categories (behavior/economy/relationships) every time, but name which are absent.
- **Multi-POV books:** per source's multi-PC note, cross-POV rumor of the event ("hearing about your other character from another city") is first-class propagation evidence — check whether other POV lines registered the event at plausible speed.

## Procedure (owner=codex)
1. Read the triggering event's chapter, all chapters after it, {timeline}, {npc_goals}, meanwhile_ledger.md, and the continuity tracker's event entries.
2. Build the connected-parties list from worldbuilding links (interconnected locations propagate per source), not just from who appears on-page.
3. Run checks 1-5 with verbatim quotes; check propagation speed against elapsed {timeline} time.
4. Emit the verdict block and revision orders; write to the output path. FORGOTTEN or FIRST-ORDER-ONLY marks the report ACTIONABLE before the next act boundary.
5. For RIPPLES-PENDING verdicts, register the due-by chapter with the orchestrator so the re-fire is scheduled, not remembered.
