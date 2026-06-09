# Audit: Fresh-Reader Clarity Pass

id: clarity_pass | owner: claude | tier: risk
trigger: flag:dense-or-system-heavy
output: {audit_root}/claude/chapter_{NN}.clarity_pass.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: verve-legacy Fresh-Reader Clarity Pass

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
For chapters that are conceptually dense, system-heavy, lyric, strange, or formally unusual: can a first-time reader follow scene action, focalizer perception, and plot-bearing consequence? The pass has four legacy components plus a character-clarity component:

**1. Plain-Event Summary.** Reconstruct, in plain declarative prose, what literally happens in the chapter: who does what, where, in what order, with what consequence. Every point where the summary must guess, hedge, or admit two readings of the literal events is a clarity finding (unless deliberately assigned — see Confusion Map).

**2. Term/Name/Institution Inventory.** Every new load-bearing term, name, institution, rule, mechanic, document, or formal pattern the chapter introduces. Per item: where introduced, where it first carries plot weight, and whether the reader was given enough concrete orientation between those points. Prefer scene-native orientation over glossary exposition: a task performed, a body moving through space, a recognition or misrecognition, a cost, a change in leverage, or one plain clause that tells the reader what kind of thing a new term is.

**3. Confusion Map.** Every passage where a first-time reader loses scene action, physical orientation, who is present, who knows what, or why a beat matters. For each: classify the opacity as **assigned** (deliberately serving atmosphere / suspense / voice / later payoff — name which, and the evidence the book is doing it on purpose) or **accidental** (hiding scene logistics). Mystery is valid; accidental opacity is not.

**4. Character-Introduction + Disambiguation.** For any character introduced or reappearing in this chapter: can a first-time reader of this chapter place them? If a reader would need a "wait, who's that?" beat, the chapter must add context (half-sentence reminder, name + identifying detail, callback to prior appearance). ALSO: if two characters share surface markers (same last initial, overlapping roles, similar names, same workplace, same first-letter abbreviation), explicitly verify the chapter makes them un-confusable — a careful reader should not be able to mistake character A for character B based on the chapter alone.

**5. Readability Under Complexity** (quality-brief checks, verbatim). Do not equate clarity with simplicity; the question is whether the reader is oriented enough to enjoy the difficulty on the book's own terms. Check:
- whether scene action, physical orientation, focalizer perception, and plot-bearing consequence are available on first read
- whether new terms, names, rules, institutions, relationships, or formal patterns become plain enough before the chapter asks them to carry plot weight
- whether mysteries are deliberately atmospheric, suspenseful, funny, uncanny, romantic, horrific, or otherwise genre-apt, rather than accidental underexplanation
- whether the prose gives the reader plain footholds at moments of high conceptual, emotional, procedural, or action load
- whether aliases or near-synonyms make one concept look like several

## Required verdict format
- `PLAIN-EVENT SUMMARY:` the summary itself, with every guess/hedge/double-reading marked inline as `[UNCLEAR: <what cannot be determined>]`.
- `INVENTORY:` per item: `"<term>" — introduced: <location> — first plot weight: <location> — orientation: SUFFICIENT ("<the orienting clause/beat, quoted>") | INSUFFICIENT (<what the reader cannot know>)`.
- `CONFUSION MAP:` per passage: `"<quoted passage>" (location) — reader loses: <what> — opacity: ASSIGNED (<atmosphere|suspense|voice|later payoff> — evidence) | ACCIDENTAL`.
- `CHARACTER CLARITY:` per introduced/reappearing character: `PLACEABLE ("<the placing detail, quoted>")` or `UNPLACED (<what's missing>)`; per shared-marker pair: `UN-CONFUSABLE (<the differentiating evidence>)` or `CONFUSABLE (<the collision, quoted>)`.
- `COMPLEXITY CHECKS:` one verdict line per quality-brief bullet (1-5): `HOLDS — <evidence>` or `FAILS — "<quote>" (location)`.
- `REVISION ORDERS:` one per UNCLEAR / INSUFFICIENT / ACCIDENTAL / UNPLACED / CONFUSABLE / FAILS finding: quote, name the failure, and direct a scene-native fix (the orienting action, plain clause, reminder detail, or disambiguating beat to add — and where). Glossary dumps and exposition paragraphs are invalid orders; the fix must live inside scene texture.
- `OVERALL: CLEAR-UNDER-COMPLEXITY` (no accidental findings — still list the heaviest-load passage and the foothold that carries it) or `OVERALL: CONFUSING (<n> findings)`.

## Prompt template (owner=claude)
You are running the Fresh-Reader Clarity Pass on chapter {NN}. You are a first-time reader: you know only what the manuscript before this point has told you. Begin from the Critique stance above. The chapter is allowed to be dense, strange, lyric, comic, fractured, or withholding — it is not allowed to accidentally hide its own scene logistics.

Inputs:
- Chapter text: {chapter_file}
- What a reader knows so far (prior-chapter synopsis / continuity excerpts — not the story bible's secrets): {reader_knowledge_state}
- Reading-guide declarations of deliberate difficulty (assigned opacity, formal games, withheld information): {reading_guide}
- Character roster with surface markers (names, roles, workplaces, initials) for collision-checking: {character_roster}
- Calibration notes, if present: {calibration}

Steps:
1. Write the Plain-Event Summary first, before any other component, marking every `[UNCLEAR]` honestly — do not resolve ambiguities from background knowledge a first-time reader lacks.
2. Build the Term/Name/Institution Inventory and judge orientation per item against the scene-native standard.
3. Build the Confusion Map; classify each opacity ASSIGNED (with evidence) or ACCIDENTAL. The reading guide's declarations govern ASSIGNED status — cite them.
4. Run Character-Introduction + Disambiguation against the roster, including the shared-surface-marker collision check.
5. Run the five Readability Under Complexity checks and rule each.
6. Convert all findings to scene-native revision orders.

Write the completed pass, in the Required verdict format, to {audit_root}/claude/chapter_{NN}.clarity_pass.md. Orders must be executable without re-deriving your reasoning.
