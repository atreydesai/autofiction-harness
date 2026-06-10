# Audit: Performance Check (keynote cadence, applause endings)

id: performance_check | owner: codex | tier: risk
trigger: watch:writing-formula-phrases + watch:ruleset-three-part-cadence
output: {audit_root}/codex/chapter_{NN}.performance_check.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:2703+ [Writing ruleset rule 7 do not perform]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
Writing ruleset rule 7, "Do not perform":

> Avoid keynote cadence, mission-statement phrasing, applause-line endings, and ceremonial wrap-ups. Also avoid service-desk tone: no `Great question`, `Absolutely`, or similar canned praise unless the situation clearly calls for it; no `I hope this helps`, `Feel free to reach out`, or similar canned closers unless the situation clearly calls for it. Start where the answer starts. Stop where the answer stops.

Fiction translation of each banned move:

1. **Keynote cadence.** Narration or interiority that builds in rhetorical waves toward an inspirational beat —
   - escalating parallel clauses, the swelling pre-applause rhythm of a stage talk — rather than tracking the scene.

2. **Mission-statement phrasing.** Characters or narrator declaring purpose in brochure language:
   - "She would protect this town, whatever it took, because that was who she was."
   - Conviction is fine; copy is not.

3. **Applause-line endings.** Scene or paragraph closers engineered as quotable punchlines for an audience that is not in the room —
   - the line lands for the reader's approval, not from the scene's pressure.

4. **Ceremonial wrap-ups.** Endings that perform closure:
   - summing the scene's meaning, blessing the characters, lowering the curtain with a formal cadence instead of stopping where the scene stops.
   - Start where the scene starts; stop where the scene stops.

5. **Service-desk tone.** In narration or non-voice-justified dialogue: canned affirmations, canned reassurance, host-like address to the reader.
   - In dialogue, allowed when the situation clearly calls for it — e.g., a character whose job or personality genuinely speaks this way; that is characterization, and must be matched to {voice_cards}.

The rule's own exception is load-bearing: each move is banned "unless the situation clearly calls for it."
- A politician's speech inside the story may use keynote cadence — that is the scene's object, not the narration's habit.
- The audit distinguishes performed prose (the book addressing an audience) from performance depicted in the story.

## Required verdict format
One verdict line per criterion (1-5):
- `UNPERFORMED` — passes; quote the strongest counter-candidate considered and why it survives.
- `PERFORMED (instances)` — every flagged span, quoted, with location and which move it is.

Then `REVISION ORDERS`:
- One numbered order per flagged instance — typically: cut to where the scene actually stops, replace the mission statement with a specific act or cost, demote the applause line to scene material or delete it.
- End with `OVERALL: UNPERFORMED` or `OVERALL: PERFORMED (count)`.

## Procedure (owner=codex)
1. Read {chapter_file} in full, marking every scene ending, chapter ending, and paragraph-final sentence — performance concentrates at exits.
2. Check {watch_counts} for performance-phrase hits and grep the chapter for:
   - canned-praise/closer shapes and mission-statement markers (`whatever it took`, `that was who`, `because that was what`, `would never stop`, `it was enough`, `and that mattered`);
   - escalating triads near paragraph ends.
   - Treat hits as leads requiring in-context adjudication.
3. For each candidate, classify against criteria 1-5 and apply the depicted-vs-performed test:
   - Is the performance the scene's object (a speech, a toast, a sales pitch by a character) or the narration's habit? Quote the evidence either way.
   - For dialogue candidates, check {voice_cards} and {reading_guide_excerpts} for a register that clearly calls for it.
4. Read the chapter's final 150 words aloud-in-effect and rule explicitly on criteria 3 and 4 for the ending:
   - Does it stop where the scene stops, or does it wrap up ceremonially?
   - This ruling is mandatory even if no watch pattern fired.
5. Compare against {prior_chapters_context}: if previous chapters were flagged for the same move, recurrence escalates the finding to a standing-habit order.
6. Write the completed audit, in the Required verdict format, to {audit_root}/codex/chapter_{NN}.performance_check.md.
