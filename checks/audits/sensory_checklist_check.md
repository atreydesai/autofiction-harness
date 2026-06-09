# Audit: Sensory-Checklist Audit (three-smells pattern)

id: sensory_checklist_check | owner: codex | tier: risk
trigger: watch:sensory-checklist
output: {audit_root}/codex/chapter_{NN}.sensory_checklist.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:1226-1236 [field guide 2]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
Field guide item 2, THE SENSORY CHECKLIST:

> Every room your character enters gets exactly three smells.
> "Roasted spice, seared citrus oil, a ghost of smoked fish skin." "Incense with silverleaf oil, a trace of salt wind and rare citrus resin." "Therra blossom, ironroot, and mint."
> Room. Three smells. Room. Three smells. Room. Three smells. Your character has apparently wandered into a Yankee Candle with a loyalty program.
> Vary it. Sometimes one smell is enough. Sometimes a room doesn't smell like anything worth mentioning. Sometimes the important sensory detail is a sound or a texture or the fact that it's freezing cold. If you notice you've described smells in three consecutive rooms, your prose has a sinus infection.

Criteria:

1. **Three-smells-per-room.** Locations introduced with a triplet of smells, or a near-triplet:
   - two-plus-a-trace, the "a ghost of / a trace of / a hint of" shapes in the source examples.
   - Each instance quoted.

2. **Consecutive-rooms rule.** The source's explicit threshold:
   - smells described in three consecutive room/location entrances is a failure even if no single description is a triplet.
   - Track every location entrance in order and report the longest consecutive smell streak.

3. **Checklist behavior across senses.** The underlying disease is the checklist, not the nose:
   - location entrances that ritually issue the same-shaped sensory bundle (smell + sound + light, every time) fail the same test.
   - Report the per-entrance sensory pattern if it is uniform.

4. **The variation standard.** What passing looks like, per the source:
   - sometimes one smell is enough;
   - sometimes a room doesn't smell like anything worth mentioning;
   - sometimes the important sensory detail is a sound or a texture or the fact that it's freezing cold.
   - Verify the chapter actually exercises this range — entrance descriptions should differ in sense, count, and presence/absence.

5. **Selection over inventory.** Where sensory detail does appear, is it the detail this focalizer would notice under this pressure, or interchangeable atmosphere?
   - An entrance can pass the count tests and still fail selection.
   - Flag perfume-catalog details no one in the scene has a reason to register.

## Required verdict format
One verdict line per criterion (1-5):
- `VARIED` — passes; quote the strongest counter-candidate considered and why it survives.
- `CHECKLIST (instances)` — every flagged entrance/description, quoted, with location; for criterion 2 include the streak count.

Then `REVISION ORDERS`:
- One numbered order per finding — cut to one smell, cut to nothing, swap to the sense the scene actually turns on (sound, texture, temperature), or replace inventory with the one detail the focalizer would register.
- End with `OVERALL: VARIED` or `OVERALL: CHECKLIST (count)`.

## Procedure (owner=codex)
1. Read {chapter_file} and list every location entrance and scene-setting description in order of occurrence.
2. For each entrance, record: senses invoked, number of distinct sensory items, and whether smell appears.
   - Build the entrance table — it is the audit's primary evidence and must appear in the output.
3. Cross-check {watch_counts} for sensory-checklist watch hits and grep for triplet shapes and trace-words:
   - `a ghost of`, `a trace of`, `a hint of`, `smelled of`, `the air smelled`, three-noun lists in scene-opening sentences.
   - Verify each hit in context.
4. Apply criteria 1-3 from the table: flag triplets, compute the longest consecutive-smell streak, and check for uniform sensory bundles.
5. Apply criteria 4-5 as judgment calls with quoted evidence:
   - use {voice_cards} for what each focalizer plausibly notices;
   - use {reading_guide_excerpts} for any sense-forward style commitment (a perfumer protagonist legitimately smells everything — if the reading guide says so, cite it);
   - use {prior_chapters_context} to note whether this chapter repeats a streak already flagged earlier.
6. Write the completed audit, in the Required verdict format (including the entrance table), to {audit_root}/codex/chapter_{NN}.sensory_checklist.md.
