# Audit: Undue-Significance Audit (essay drift)

id: undue_significance | owner: codex | tier: risk
trigger: watch:wp-ailegacy-significance-puffery + flag:puffery (gate BANNED aiisms-2.35-legacy-puffery findings)
output: {audit_root}/codex/chapter_{NN}.undue_significance.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: wikipedia:WP:AILEGACY + collation 2.35

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
WP:AILEGACY, "Undue emphasis on significance, legacy, and broader trends": LLM writing often puffs up the importance of the subject matter by adding statements about how arbitrary aspects of the topic represent or contribute to a broader topic, with a distinct and easily identifiable repertoire.
- Its Words to watch: **stands/serves as, is a testament/reminder, a vital/significant/crucial/pivotal/key role/moment, underscores/highlights its importance/significance, reflects broader, symbolizing its ongoing/enduring/lasting, contributing to the, setting the stage for, marking/shaping the, represents/marks a shift, key turning point, evolving landscape, focal point, indelible mark, deeply rooted**.
- LLMs may include these statements for even the most mundane of subjects.
- **Sometimes, they add hedging preambles acknowledging that the subject is of relatively low importance, before talking about its importance anyway.**

Collation 2.35, LEGACY/IMPORTANCE PUFFERY — phrases that inflate significance through assertion rather than demonstration; rare in good fiction, ubiquitous in AI output. Banned phrases:
- stands as a testament to; serves as a reminder of; a testament to
- enduring legacy; lasting legacy; lasting impact; indelible mark
- deeply rooted; profound heritage; steadfast dedication
- plays a vital/pivotal/crucial role; of paramount importance; cannot be overstated

Why these fail: **these tell the reader something matters without showing why. In fiction, significance is earned through consequence, not declared through diction.**

Criteria:

1. **Banned-phrase hits.** Every occurrence of the 2.35 banned list and the WP:AILEGACY words-to-watch in narration.
   - Verbatim hits fail outright in narration.
   - Near-paraphrases ("would stay with her always", "nothing in the valley was ever quite the same") are judged by criterion 2.

2. **Essay drift / broader-significance claims.** Narration stepping out of the scene to assert that an arbitrary detail represents, symbolizes, or contributes to something larger —
   - a moment "marking a shift" in a relationship, an object "a reminder of" a theme, a town's custom "reflecting" the world's deeper truth.
   - The test is the source's: is significance demonstrated through consequence on the page, or declared through diction? A claim with no consequence trail fails.

3. **Hedged self-importance.** The source's signature double move: a preamble admitting the detail is small, followed by a significance claim anyway —
   - "It was a small thing, but it would come to mean everything"; "He'd forget the gesture by morning, though something of it stayed."
   - Flag the full two-beat structure.

4. **Mundane-subject inflation.** Significance language attached to logistics, scenery, and routine action —
   - the fiction equivalent of puffing etymology or population data. The smaller the referent, the stronger the tell.

5. **Allowable significance.** Do not flag:
   - a character asserting importance in dialogue or voiced interiority (that is characterization — and may be wrong);
   - significance the book has already earned through consequence, where the line names what the reader has seen happen;
   - deliberate ironic puffery licensed by {reading_guide_excerpts}.
   - Each allowance must cite its evidence.

## Required verdict format
One verdict line per criterion (1-5):
- `EARNED` — passes; quote the strongest counter-candidate considered and why it survives.
- `PUFFED (instances)` — every flagged span, quoted, with location; for criterion 3 quote both beats.

Then `REVISION ORDERS`:
- One numbered order per finding — cut the declaration and either let the detail stand at its actual size or replace the claim with the consequence that would earn it (named, specific, on-page or ordered into a later chapter).
- End with `OVERALL: EARNED` or `OVERALL: PUFFED (count)`.

## Procedure (owner=codex)
1. Read {chapter_file} in full, marking every sentence where narration asserts importance, legacy, symbolism, or connection to something broader.
2. Cross-check {watch_counts} for wp-ailegacy-significance-puffery hits and the gate report for BANNED aiisms-2.35-legacy-puffery findings, and grep for the banned list and words-to-watch:
   - testament, reminder, enduring, lasting, indelible, deeply rooted, pivotal, crucial, paramount, cannot be overstated;
   - marking, symbolizing, reflects, setting the stage, turning point, `would never` / `nothing would ever` shapes.
   - Adjudicate every hit in context.
3. For each criterion-2 candidate, trace the consequence trail: search the chapter and {prior_chapters_context} for the demonstrated event that would earn the claim.
   - Quote it if found (pass); record its absence if not (fail).
4. Sweep paragraph endings and the chapter's final page separately — significance declaration clusters at exits, where it doubles as essay drift out of scene.
5. Apply criterion 5's allowances using {voice_cards} (whose voice is the claim in?) and {reading_guide_excerpts}; cite the license for every allowance exercised.
6. Write the completed audit, in the Required verdict format, to {audit_root}/codex/chapter_{NN}.undue_significance.md.
