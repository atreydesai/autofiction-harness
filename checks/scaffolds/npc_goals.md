# Scaffold: NPC Goal Profiles

artifact: {workspace}/npc_goals.md
purpose: give every recurring secondary character goals that don't involve the protagonist, so the world has trajectories that move between scenes instead of props that vanish offstage
created: drafter Phase 2-3, for every named character who recurs but is not a POV lead
updated: between chapters during the summarization/preparation step; whenever a "meanwhile" pass or ripple audit moves an NPC's situation forward
updated_by: orchestrator
source_ref: collation:5122-5134 [Reddit 7 Fix 1: Give NPCs Goals That Don't Involve You]

## The fix (verbatim)

> Fix 1: Give NPCs Goals That Don't Involve You
> This is the single biggest change I've made.
> Most people describe NPCs like this:
> Garrett is the blacksmith. He's gruff and honest. He sells weapons.
> That's a prop, not a person.

> Now Garrett has a trajectory. His situation changes between your visits. The AI has material to work with even when your character isn't around.
> NPCs with their own goals become NPCs with their own stories. And their stories can collide with yours.

> Now, if whatever app/environment you're using supports it, *automate this*. … Something that works for me is to do it during my summarization and preparation process between chapters/sessions.

In this harness "you / your character" = the protagonist(s); "session" = chapter cycle. The npc_offscreen_goals audit (every 3 chapters) checks committed chapters against this file: did NPC situations move? Did any NPC trajectory collide with the main plot?

## Template (one entry per recurring NPC)

```
NPC: <name>
- role / surface description: <placeholder — the prop version, one line>
- goal that doesn't involve the protagonist: <placeholder>
- what they're doing about it right now: <placeholder>
- who it's making suspicious / happy / threatened: <placeholder>
- who they don't trust: <placeholder>
- trajectory — situation as of chapter <NN>: <placeholder; update between chapters>
- potential collision with the main plot: <placeholder>
```

## Worked mini-example (the source's own; name is the source's generic blacksmith)

> Garrett is saving money to move his family out of the city before winter. He's been taking side jobs repairing armor for the city guard, which is making the local merchant guild suspicious. He doesn't trust the guild master.

As an entry:

```
NPC: Garrett (blacksmith)
- role / surface description: gruff, honest blacksmith; sells weapons
- goal that doesn't involve the protagonist: move his family out of the city before winter
- what they're doing about it right now: saving money; taking side jobs repairing armor for the city guard
- who it's making suspicious: the local merchant guild
- who they don't trust: the guild master
- trajectory — situation as of chapter 04: side jobs ongoing; guild suspicion rising
- potential collision with the main plot: guild pressure on Garrett could cut off the protagonist's weapon supply
```
