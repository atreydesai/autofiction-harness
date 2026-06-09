# Scaffold: Event Ripple Tracker

artifact: {workspace}/event_ripple_tracker.md
purpose: track major events and their second-order consequences so actions carry weight — the model will happily let a bandit leader die and never think about it again unless prompted to ripple
created: drafter Phase 2 (seed with any pre-story events whose consequences are still spreading); first in-story entry at the first major plot event
updated: at every major plot event (new entry) and during chapter prep (advance the ripples that are due); also after major revisions (ripple_audit_post_revision)
updated_by: orchestrator
source_ref: collation:5172-5187 [Reddit 7 Fix 4: Consequences Have Ripples]

## The fix (verbatim)

> Fix 4: Consequences Have Ripples
> You killed the bandit leader three sessions ago. Cool. What happened to his gang? Did they scatter? Did someone new take over? Did the town start to recover, or did something worse move into the power vacuum?
> First-order consequences are obvious. Second-order consequences are where the world comes alive.
> During your session prep or "meanwhile" prompt, tell AI:
>
> - When major events happen, their effects should spread to connected NPCs and locations.
> - Not everything resolves cleanly. Some consequences take time to play out.
>
> The AI won't track this by itself … It'll happily let you kill a bandit leader and never think about it again. But if you prompt it to consider ripple effects, suddenly your actions carry weight.
> This is where a good lore system pays off. … The more history you feed the AI, the more interconnected the world feels. Past events stop being isolated moments and start forming a web.
> So here's where prior worldbuilding becomes important too. If you built interconnected cities, events will impact nearby ones.

## Template (one entry per major event)

```
EVENT: <what happened> (chapter <NN>, in-story date <date>)
- who knows: <placeholder — who witnessed it; who has been told; who must NOT know yet>
- how fast news travels: <placeholder — by what channel, reaching whom, by when
  (use the world bible's Information row: who knows what, and how does knowledge travel?)>
- first-order consequences (obvious, immediate): <placeholder>
- behavioral changes due: <placeholder — which characters act differently, from which chapter>
- economic changes due: <placeholder — prices, scarcity, work, who profits/loses, from which chapter>
- relationship changes due: <placeholder — alliances, suspicions, debts, grudges, from which chapter>
- second-order consequences (the power-vacuum question): <placeholder — what fills
  the space this event emptied; what gets worse before it gets better>
- chapters affected: <list — every chapter where a ripple is due on the page>
- ripples that take time: <placeholder — consequences deliberately deferred, with target chapters>
- status: <spreading | mostly landed | dormant>
```

## Mini-example (built on the source's own scenario)

```
EVENT: bandit leader killed (chapter 09, Day 30)
- who knows: the protagonist's party; the gang by Day 31; the town by Day 33 (market rumor)
- how fast news travels: gang courier same night; town via market gossip in ~3 days
- first-order consequences: gang leaderless; bounty unclaimed
- behavioral changes due: gang lieutenants compete openly (ch 11+); town guard relaxes patrols (ch 12)
- economic changes due: road tolls lapse, trade briefly cheaper (ch 12); protection rackets resume worse under new claimant (ch 14)
- relationship changes due: merchant guild now courts the protagonist (ch 13)
- second-order consequences: something worse moves into the power vacuum (ch 14)
- chapters affected: 11, 12, 13, 14
- ripples that take time: the dead leader's brother hears in the capital (ch 17)
- status: spreading
```

## Notes

- The ripple_effects audit (event:major-plot-event) and meanwhile_audit consume this file; ripple_audit_post_revision re-walks entries after major revisions.
- "Not everything resolves cleanly" is enforced jointly with the thread ledger's PROTECTED flags (checks/scaffolds/thread_ledger.md).
