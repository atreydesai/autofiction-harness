# Audit: Thought-Development Audit (pre-solved prose)

id: thought_development | owner: claude | tier: risk
trigger: flag:reflective-chapter
output: {audit_root}/claude/chapter_{NN}.thought_development.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:2703+ [Writing ruleset rule 11]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
Writing ruleset rule 11, "Let the thought develop":

> Longer pieces should not feel pre-solved. If the prose moves in a perfectly efficient straight line from claim to conclusion, it can feel rushed. Let the thought develop through a concrete example, a noticed detail, a sentence that gathers related material, or a brief doubling-back when the material naturally allows it. A concrete example usually does this better than an artificial aside.
>
> Development can happen inside a sentence, not only across paragraphs. A cumulative sentence can start with the main claim and then add the reason, qualification, or consequence that belongs with it. Do not split that movement into separate sentences unless the break itself does useful work.

The ruleset's correction examples calibrate the target:
- Rushed linearity -> developed thought. Avoid: `The plan changed. Results improved. Therefore it worked.` Prefer: `Results improved only after the review queue changed, which is why the earlier numbers were misleading.`
- Choppy -> connected. Avoid: `The term does real work. It names a pattern that was floating unnamed.` Prefer: `The term does real work: it names a pattern that was floating unnamed.`

Fiction translation — this audit fires on reflective chapters, where interiority does the rule's "longer piece" work:

1. **Pre-solved reflection.** Interiority that arrives at its conclusion in a straight line:
   - the character poses the question, states the answer, moves on.
   - Real thinking on the page gathers material — a noticed detail, a memory, a wrong first guess, a brief doubling-back — before it lands, when the material naturally allows it.

2. **Missing concrete development.** Reflective passages that develop through abstraction (more adjectives, restated stakes) instead of through a concrete example or noticed detail.
   - A concrete example usually does this better than an artificial aside.
   - Flag artificial asides inserted to fake texture as the same failure.

3. **Split cumulative movement.** Claim-plus-reason/qualification/consequence movements chopped into separate mini-sentences when nothing about the break does useful work.
   - Quote the fragments and show the cumulative sentence they were refusing to be.

4. **Allowable efficiency.** Do not flag:
   - action sequences and high-pressure scenes (linearity is the point);
   - a character whose voice card establishes clipped, decisive cognition;
   - thoughts the plot needs unresolved.
   - The rule governs reflection that pretends to think while merely announcing results.

## Required verdict format
One verdict line per criterion (1-4):
- `DEVELOPED` — passes; quote the strongest counter-candidate considered and why it survives.
- `PRE-SOLVED (instances)` — every flagged passage, quoted, with location and failure type.

Then `REVISION ORDERS`:
- One numbered order per flagged passage stating what development the revision must add: which concrete detail, what doubling-back, which sentences to merge into a cumulative movement.
- Development material must be drawn from materials already in the scene or in {prior_chapters_context}, not invented decoration.
- End with `OVERALL: DEVELOPED` or `OVERALL: PRE-SOLVED (count)`.

## Prompt template (owner=claude)
You are auditing chapter {NN}, flagged as a reflective chapter, for pre-solved prose. Begin from the Critique stance above.

Inputs:
- Chapter text: {chapter_file}
- Reading-guide commitments for this chapter's reflective register: {reading_guide_excerpts}
- Voice cards (cognition styles, clipped vs ruminative): {voice_cards}
- Watch counts: {watch_counts}
- Prior-chapter context (material the reflection could draw on): {prior_chapters_context}

Procedure:
- Identify every sustained reflective passage (interiority of roughly three sentences or more, plus any essayistic narration).
- For each, trace the thought's path: where it starts, what it touches on the way, where it lands.
- Apply criteria 1-4 with quoted evidence.
- The test for criterion 1 is the straight-line test: could the passage's last sentence have been written immediately after its first with nothing lost? If yes, the middle is not developing the thought.
- For criterion 3, propose the actual merged sentence in the revision order, per the choppy->connected example pattern.
- Honor criterion 4's allowances explicitly — name the voice-card line or scene pressure that excuses each pass.

Write the completed audit, in the Required verdict format, to {audit_root}/claude/chapter_{NN}.thought_development.md.
