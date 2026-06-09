# Scaffold: Timeline

artifact: {workspace}/timeline.md
purpose: make time visible — the model has no sense of time passing unless told, and defaults to "right after the last thing that happened"; this file is the running story calendar plus minute-granularity anchors for simultaneity-critical sequences
created: drafter Phase 2 (initialize with known events at known dates); simultaneity-critical sections initialized as soon as such a sequence is planned
updated: per chapter commit (every chapter records its date/elapsed time); contradictions with prior entries are continuity failures and trigger immediate reconciliation
updated_by: orchestrator (drafter receives the current in-story date in every chapter packet)
source_ref: collation:5153-5168 [Reddit 7 Fix 3: Make Time Visible] + legacy editor continuity_timeline concept (genericized)

## The fix (verbatim)

> Fix 3: Make Time Visible
> AI has no sense of time passing unless you tell it. Three sessions could be three hours or three months in your world. If you don't establish it, the AI defaults to "right after the last thing that happened."
> Be explicit:
>
> - "Two weeks have passed since the battle."
> - "It's now deep winter. The roads are nearly impassable."
> - "The festival I heard about last session should be starting soon."
>
> When time moves, the world has to move with it.
> Seasons change. Construction finishes. Wounds heal. Rumors spread. Prices shift. A two-week jump isn't just a number — it's an invitation for the AI to show you what changed. And imagine combining this with the "meanwhile" prompt :)
> I keep a simple timeline in my lore notes. Just key dates and what happened. When I start a new session, I tell the AI the current in-game date. It sounds small but does wonders.

## Session procedure (per chapter cycle)

1. Before drafting, the chapter packet states the current in-story date and how much time has passed since the previous chapter (explicitly, in the source's style above).
2. If time jumped, the packet also states what moved with it (seasons, construction, wounds, rumors, prices) — pair with the meanwhile prompt (see meanwhile_audit).
3. After commit, append the chapter's row below.
4. The time_visibility audit (per act) checks that elapsed time is established on the page, not just in notes.

## Template — running timeline

```
| chapter | in-story date | elapsed since previous | key events | world changes due to elapsed time |
|---|---|---|---|---|
| 01 | <date> | — | <placeholder> | <placeholder> |
| 02 | <date> | <e.g. two weeks> | <placeholder> | <placeholder> |
```

## Simultaneity-critical sequences (minute granularity)

For any sequence where simultaneity matters — multiple characters acting in parallel during one morning, a death or disaster reconstructed minute-by-minute, alibis, broadcasts, anything where "what was X doing while Y happened" can contradict — keep a time-anchored section. Initialize it with known events at known timestamps as soon as the sequence is planned; update it with each contributing chapter's events at their recorded timestamps when that chapter commits. Contradictions between a chapter and an existing anchor are continuity failures: reconcile immediately, do not defer.

```
### Sequence: <name> (<date>, <timezone/clock convention>)
| time | location | character(s) | event | established in chapter |
|---|---|---|---|---|
| <HH:MM> | <placeholder> | <placeholder> | <placeholder> | <NN> |
| <HH:MM> | <placeholder> | <placeholder> | <placeholder> | <NN> |
```

Mini-example (generic):

```
### Sequence: warehouse fire morning (Day 41, local clock)
| time | location | character(s) | event | established in chapter |
|---|---|---|---|---|
| 09:00 | docks office | A | signs the manifest | 12 |
| 09:14 | warehouse 6 | B | smells smoke, raises alarm | 12 |
| 09:20 | docks office | A | still in the office — cannot also be at warehouse 6 | 13 (alibi scene) |
```
