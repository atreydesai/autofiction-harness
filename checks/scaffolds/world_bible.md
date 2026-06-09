# Scaffold: World Bible

artifact: {workspace}/world_bible.md
purpose: store the facts of the setting and the constraint systems that make causal chains believable; give the model boundaries so it does not confidently invent world details mid-novel
created: drafter Phase 1-2, alongside the master spec
updated: when a chapter introduces a new world fact or rule (continuity check feeds it); consciously, never by silent drift
updated_by: orchestrator
source_ref: collation:5222-5246 [Reddit 9 "3. Keep a world bible"] + collation:5080-5104 [Novel process "Research and Structural Design" worldbuilding worksheet] + collation:5051 + 4703 [Academic manual world-as-constraint dimensions]

## Content spec (Reddit 9, verbatim)

> This is where I stored the facts of the setting.
> Depending on your genre, this might include:
>
> - history of the world
> - political or social structures
> - factions
> - locations
> - rules of magic, technology, religion, institutions, etc.
> - what ordinary people know versus what is hidden
> - what has changed from the world we know
> - timeline of major events
>
> This matters because AI will confidently invent world details if you leave gaps. Sometimes that is useful. Most of the time, halfway through a novel, it is poison.
> The world bible gives the AI boundaries.

## Template

```
WORLD BIBLE — <project>

## History of the world
<placeholder>

## Political or social structures
<placeholder>

## Factions
<placeholder — per faction: goals, resources, enemies>

## Locations
<placeholder — per location: function, who controls it, sensory anchors>

## Rules of magic, technology, religion, institutions, etc.
<placeholder — who can use it, what it costs, what regulates it, how it distorts
economy, law, warfare, class, religion, or family life>

## What ordinary people know versus what is hidden
<placeholder>

## What has changed from the world we know
<placeholder>

## Timeline of major events
<placeholder — cross-reference {workspace}/timeline.md for the running story timeline>

## World-as-constraint worksheet (fill every row)
| Domain | Questions that matter to plot | This book's answer |
|---|---|---|
| Power | Who can command, punish, or withhold? | <placeholder> |
| Economy | What is scarce, expensive, or monopolized? | <placeholder> |
| Information | Who knows what, and how does knowledge travel? | <placeholder> |
| Mobility | What limits travel, communication, escape, and pursuit? | <placeholder> |
| Violence | Who may legally use force, and at what cost? | <placeholder> |
| Social order | What hierarchies and taboos shape choices? | <placeholder> |
| Material environment | What do characters physically smell, hear, wear, eat, and handle? | <placeholder> |
```

## Constraint-design rules (source guidance)

Novel process report: "Worldbuilding works best when treated as constraint design. A world feels real when its rules create consequences. That means you should define, at minimum, the system that governs power, scarcity, knowledge, mobility, violence, and taboo. If a fantasy world has magic, ask who can use it, what it costs, what institutions regulate it, and how it distorts economy, law, warfare, class, religion, or family life. If the world changes nothing, the worldbuilding is cosmetic rather than structural."

Academic manual — the world-as-constraint dimensions to cover: **power, economy, information, mobility, violence, taboo, institutions, and material environment**. And setting as pressure system: "Setting should be used as a **pressure system**. It is not merely where a scene happens; it shapes what can be hidden, overheard, bought, escaped, and endured. … The deeper layer is constraint."

## Notes

- Hard facts the novel must never contradict graduate to the canon sheet (checks/scaffolds/canon_sheet.md); the world bible holds the full detail, the canon sheet holds the one-page consistency core.
- The world_coherence and catalog_prose audits consume this file; flag:worldbuilding-heavy on a chapter card routes the catalog-prose audit.
