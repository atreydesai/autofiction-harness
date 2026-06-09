# Audit: Ending Quality Audit (weak/summarizing endings, stillness closes)

id: ending_quality | owner: codex | tier: core
trigger: every-chapter
output: {audit_root}/codex/chapter_{NN}.ending_quality.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:87 weak endings + 4604-4669 [2.31 + For Endings + Instead of Stillness Endings + Phase 8]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

**Weak or summarizing endings.** Unstructured model output tends to drift into recap,
moralized summary, or generic atmospheric wrap-up. The common failure is not simply "bad
ending" — it is a local failure of narrative pressure: the paragraph closes by explaining
what the scene *meant* rather than leaving the reader inside what the scene *did*. This
surfaces late in scenes and at chapter endings, especially after descriptive passages or
emotionally explanatory prose. The standard: endings cut on live pressure instead of
explaining the scene's meaning.

Criteria:

1. **The For-Endings question (applied verbatim).** Ask: What action, decision, or
   consequence closes this beat? What changes because of what just happened? If the
   answer is "nothing — it closes on mood, summary, or interpretation," the ending fails.

2. **Ending clichés (2.31).** Phrases that close scenes with false profundity rather
   than consequence:
   * And for now, that was enough.
   * It was a start.
   * They would figure it out. Somehow.
   * Nothing would ever be the same.
   * Everything had changed.
   **Why these fail:** Summary posing as closure. Labels the emotional meaning rather
   than letting it emerge from action. Mechanical input: {watch_counts} entries for
   pattern family `aiisms-2.31-ending-cliches` are leads — verify each hit in context.

3. **Stillness endings / Phase 8 sweep.** Search the chapter's scene-final and
   chapter-final paragraphs for: "doesn't move" / "still in hand" / "doesn't say
   anything" / "And for now". Action when found: end on action, decision, or consequence.

4. **Repair options when an ending fails (Instead of Stillness Endings, verbatim):**
   * End on a micro-action that crystallizes the emotional state
   * Close with dialogue that shifts the dynamic
   * Cut the scene earlier — before the false profundity
   * Let consequence land rather than announcing that it landed

## Required verdict format

One verdict per scene ending plus one for the chapter ending:

- `LANDS — <scene n | chapter-final> — final lines quoted — what closes the beat: <the action, decision, or consequence, quoted> — pressure it cuts on: <named>`
- `EXPLAINS — <scene n | chapter-final> — final lines quoted — what it explains that the scene already did: <named> — clichés present: <list or none>`
- `TRAILS-PAST-THE-LANDING — <scene n | chapter-final> — the true landing point quoted — the trailing material quoted — proposed cut point`

LANDS verdicts must still quote the strongest weak candidate considered (the most
summary-like or stillness-like phrase near the close) and say why it survives.

Chapter verdict: `ENDINGS-CLEAN` only if every ending LANDS; otherwise `ENDINGS-FAIL`.
Then `REVISION ORDERS`: one numbered order per failed ending, each naming which of the
four repair options applies and giving the concrete rewrite or cut point.

## Procedure

1. Load the chapter text, the chapter card, and {watch_counts} (mechanical hits for
   `aiisms-2.31-ending-cliches` and Phase 8 search strings).
2. Segment the chapter into scenes; extract the final paragraph of each scene and of the
   chapter.
3. For each ending, answer the For-Endings question first. If no action, decision, or
   consequence closes the beat, the verdict is EXPLAINS regardless of prose quality.
4. Check each ending against the 2.31 cliché list and the Phase 8 stillness strings;
   verify every {watch_counts} lead in context and discard false positives by name.
5. For endings that do land but continue afterward, locate the true landing line and
   mark everything after it TRAILS-PAST-THE-LANDING with a proposed cut point.
6. Write per-ending verdicts, the chapter verdict, and the revision orders in the
   Required verdict format, selecting repairs from the four source options.
7. Write the completed audit to {audit_root}/codex/chapter_{NN}.ending_quality.md. An
   ENDINGS-FAIL chapter is not committable until the orders are executed or rejected
   with reasons in the revision memo.
