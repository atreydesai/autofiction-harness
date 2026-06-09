# Audit: Regression-to-the-Mean / Genericization Audit

id: genericization_regression | owner: claude | tier: risk
trigger: sample:every-4th-chapter
output: {audit_root}/claude/chapter_{NN}.genericization.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: wikipedia:WP:AIWTW intro (specific facts fade into generic importance)

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The Wikipedia signs-of-AI-writing intro: LLMs use statistical algorithms to guess what should come next, and thus tend to regress to the mean — the result tends toward the most statistically likely output that applies to the widest variety of cases.
- LLMs tend to omit specific, unusual, nuanced facts (which are statistically rare) and replace them with more generic, positive descriptions (which are statistically common).
- Thus the highly specific "inventor of the first train-coupling device" might become "a revolutionary titan of industry."
- It is like shouting louder and louder that a portrait shows a uniquely important person, while the portrait itself is fading from a sharp photograph into a blurry, generic sketch.
- **The subject becomes simultaneously less specific and more exaggerated.**
- This smoothing of specific facts into generic statements that could equally apply to many topics is what makes AI-generated content detectable.

Fiction adaptation: revision passes are where regression strikes a novel. An editing model "improving" a chapter will quietly trade the draft's rare, odd, particular materials for smoother, more important-sounding commonplaces. This audit diffs {pre_revision_file} against {post_revision_file} and asks one question per category: did revision make anything less specific and more exaggerated?

Categories to diff:

1. **Concrete details.** Named objects, numbers, idiosyncratic physical facts, odd specifics (the train-coupling-device class of detail).
   - Flag every place a particular became a generality ("the dented samovar her aunt stole" -> "a cherished family heirloom").

2. **Images and figuration.** Unusual, scene-grown images replaced by stock ones;
   - a strange comparison smoothed into one that could appear in any novel.

3. **Character texture.** Contradictory, unflattering, or nuanced character facts flattened into likable competence or generic villainy;
   - a specific motive becoming an important-sounding abstract one.

4. **Dialogue particularity.** Voice-marked, fumbling, or idiosyncratic lines polished into well-formed interchangeable ones.

5. **Inflation accompanying the fade.** The "shouting louder" half:
   - significance language added where specificity was removed — stakes restated as bigger, emotions as deeper, moments as more pivotal, while the supporting particulars thinned.

6. **Legitimate edits are not regression.** Cuts that remove genuine clutter, fix continuity, or execute an explicit revision order are allowed even when they remove detail.
   - Check each candidate against the revision instructions and {reading_guide_excerpts} before flagging.
   - A flagged loss must be a loss of *value-bearing* specificity, argued, not merely a diff line.

## Required verdict format
One verdict line per category (1-6):
- `HELD` — no value-bearing specificity lost; quote the riskiest diff you examined and why it is legitimate.
- `REGRESSED (instances)` — each instance as a before/after pair: quoted pre-revision text, quoted post-revision text, location, and what was lost or inflated.

Then `REVISION ORDERS`:
- One numbered order per instance — restore the pre-revision specific (verbatim or improved), and strip the compensating inflation where category 5 found it.
- End with `OVERALL: HELD` or `OVERALL: REGRESSED (count)`.

## Prompt template (owner=claude)
You are auditing a revision of chapter {NN} for regression to the mean. Begin from the Critique stance above.

Inputs:
- Pre-revision chapter: {pre_revision_file}
- Post-revision chapter: {post_revision_file}
- The revision orders the editing pass was executing (if available) and reading-guide commitments: {reading_guide_excerpts}
- Voice cards: {voice_cards}
- Watch counts on the post-revision text: {watch_counts}
- Prior-chapter context (which specifics are load-bearing later): {prior_chapters_context}

Procedure:
- Read both versions fully, then work paragraph-aligned through the diff.
- For every change, ask the two-sided question: less specific? more exaggerated? A change can fail on either side alone, and the worst failures do both at once.
- Pay special attention to passages the revision was *not* ordered to touch — uninstructed smoothing is the signature of regression.
- For each candidate loss, check criterion 6 before flagging.
- For each flag, check {prior_chapters_context} and escalate if the lost specific is load-bearing in later chapters (that is also a continuity hazard — say so).
- Quote every before/after pair in full.

Write the completed audit, in the Required verdict format, to {audit_root}/claude/chapter_{NN}.genericization.md.
