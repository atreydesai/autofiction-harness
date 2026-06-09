# Scaffold: Research Dossier

artifact: {workspace}/research_dossier.md
purpose: a dossier, not a pile — research targeted, staged, and attached to concrete story questions; each source recorded with the exact constraint it creates and the scenes it binds
created: drafter Phase 1-2, alongside premise development; grows whenever a `[verify ...]` placeholder is resolved
updated: whenever research answers a story question; confirmed consistency-critical facts graduate to the canon sheet
updated_by: orchestrator
source_ref: collation:4961-4973 [Academic manual: Research without drowning in it]

## The three research layers (verbatim)

> Use three research layers. **Foundational research** establishes what cannot be wrong: historical chronology, police procedure, inheritance law, military rank, medical risk, geography, religion, climate, or technology constraints. **Experiential research** helps you render sensory and social texture: how wet wool smells in sleet, how a ward sounds at 3 a.m., what a rural courthouse feels like, what a machinist's hands look like, how a nightclub line actually moves. **Selective deep research** answers only the questions your scenes truly require. This prevents encyclopedic procrastination and keeps the storyworld proportionate to narrative need.

And the dossier spec:

> Build a **research dossier**, not a pile. For each source, record: source type, reliability, what story question it answers, the exact factual constraint it creates, the scenes affected, and what remains uncertain.

Pitfall warnings (verbatim): "The main pitfall is **research as displacement activity**. If you have enough knowledge to write the first ten scenes honestly, begin." And: "A second pitfall is over-researching world history while under-researching lived behavior; readers often forgive compressed exposition more easily than they forgive an implausible social interaction."

## Template (one entry per source)

```
ENTRY D-<NN>
- layer: <foundational | experiential | selective deep>
- source type: <placeholder — primary document, scholarly secondary, practitioner interview, site visit, official guidance, etc.>
- reliability: <placeholder — how authoritative, how current, known biases>
- story question answered: <placeholder — the concrete question this research was attached to>
- exact factual constraint created: <placeholder — the rule the manuscript must now obey, stated precisely>
- scenes affected: <placeholder — chapters/scenes bound by this constraint>
- uncertainties (what remains unknown): <placeholder — open `[verify ...]` items this source did NOT settle>
- canon sheet: <not consistency-critical | promoted to canon sheet row #N>
```

## Mini-example entry

```
ENTRY D-03
- layer: foundational
- source type: county coroner's procedural handbook (official, current edition)
- reliability: high for procedure; thin on rural staffing realities
- story question answered: how fast can an inquest verdict follow a suspicious death?
- exact factual constraint created: verdict cannot be recorded sooner than two days after the death
- scenes affected: ch 2 (death), ch 9 (verdict), ch 17 (appeal references the dates)
- uncertainties: [verify whether a family member may attend the examination]
- canon sheet: promoted to canon sheet row #1
```
