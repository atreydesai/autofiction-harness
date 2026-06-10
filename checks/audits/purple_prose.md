# Audit: Purple Prose & Show-Don't-Tell Audit

id: purple_prose | owner: claude | tier: risk
trigger: watch:llm-catalog-ai-words + watch:wp-aivocab-cluster + flag:lyric
output: {audit_root}/claude/chapter_{NN}.purple_prose.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:85 [LLM outputs purple prose] + show/tell entries

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
Professional editors in the LAMP corpus repeatedly remove spans they classify as **purple prose**, **unnecessary or redundant exposition**, and **lack of specificity and detail**. Purple prose is defined as excessively elaborate language that draws attention to itself through adjectives, adverbs, abstract nouns, and metaphors while conveying relatively little. Closely related is "telling" instead of dramatizing: editors repeatedly cut passages that restate what is already implied or explain emotions in generalized terms rather than grounding them in action, image, or subtext. The prose sounds "writerly," but scene energy drops because the language keeps summarizing or ornamenting instead of embodying. It surfaces most when the brief asks for emotional intensity, literary flair, or introspection without concrete scene anchors.

Criteria to apply, with the source's calibration:

1. **Purple spans.** Stretches of stacked adjectives, adverbs, abstract nouns, and metaphors that convey relatively little. Includes two banned sub-patterns from the show/tell sections:
   - Ripple/stillness similes — dead similes universalized to meaninglessness, no unique sensory or emotional anchor, so common they're invisible:
     - "Like a stone dropped in still water." / "Rippled through him." / "Sent ripples through the room." / "The stillness shattered." / "Cracked the silence like glass."
     - Flagging trigger: if the text writes "like a stone" or "rippled through," cut it and show impact directly.
   - Misapplied epic tone — heightened language treating minor moments as climactic; every moment reads as climax, undermines proportion, sounds algorithmically "important" rather than earned, breaks psychological realism:
     - "In that instant, something in him broke forever." / "The world held its breath." / "It was only a touch, but it changed everything." / "Nothing would ever be the same."
     - Flagging trigger: if the text writes "changed everything" or "broke forever," ask whether the moment is actually that big; if not, scale down.

2. **Telling that restates implied meaning.** The show/tell dial: "She felt angry" is telling; "Her jaw tightened" is showing.
   - Flag every passage that explains an emotion already implied by action, image, or subtext.
   - Flag every passage that restates what the scene just dramatized.

3. **Allowable telling (do not over-flag).** "Show, don't tell" is not an absolute prohibition against summary: both show and tell are essential.
   - Showing is dramatized action in scene; telling is exposition or summary.
   - Good structure depends on deciding which events readers must live through directly and which are better compressed to preserve momentum.
   - Sometimes telling is fine — fast-paced stretches do not need three paragraphs of body language for every mood.
   - Flag only telling that duplicates showing or replaces a scene the reader needed to live through.

4. **Sensory detail must be POV-bound.** Sensory writing is not the random addition of the five senses; it is immersion through the body and feelings of the viewpoint character.
   - The point is not "more detail" — it is choosing the specific sensory cues the focal consciousness would notice under pressure.

5. **Pressure-matched language.** Strong prose style is less about ornament than pressure-matched language:
   - short syntax under urgency, more layered syntax under reflection;
   - concrete nouns at moments of impact;
   - metaphor that reveals the perceiver rather than merely displaying author cleverness.
   - Flag ornament that contradicts scene pressure.

## Required verdict format
One verdict line per criterion (1-5), using this vocabulary:
- `CLEAN` — criterion passes; you must still quote the strongest counter-candidate you considered and say why it survives.
- `PURPLE (instances)` — for criteria 1, 4, 5: list every flagged span, quoted, with location.
- `TELLING (instances)` — for criteria 2, 3: list every flagged passage, quoted, with location.

Then a `REVISION ORDERS` section:
- One numbered order per flagged instance, each stating the quoted text, the failure type, and the concrete fix (cut, make literal, ground in action/image/subtext, rebuild from the focalizer's scene materials).
- End with an overall verdict line: `OVERALL: CLEAN` only if every criterion is CLEAN; otherwise `OVERALL: PURPLE`, `OVERALL: TELLING`, or `OVERALL: PURPLE+TELLING`.

## Prompt template (owner=claude)
You are auditing chapter {NN} for purple prose and show-don't-tell failure. Begin from the Critique stance above.

Inputs:
- Chapter text: {chapter_file}
- Reading-guide register commitments (what ornament this book has actually earned): {reading_guide_excerpts}
- Voice cards for the chapter's focalizers: {voice_cards}
- Mechanical watch counts for vocab clusters and lyric flags: {watch_counts}
- Context from prior chapters (recurring images, established pressure): {prior_chapters_context}

Work through criteria 1-5 in order. For each:
- Read the full chapter and quote every span that fails.
- Test each flagged span against the allowances: criterion 3's compression allowance, reading-guide-earned lyricism, POV-true sensory choice.
- A span excused by the reading guide must be excused explicitly, with the guide line that excuses it.
- Do not flag ornament merely for being ornament — flag it for conveying relatively little, duplicating implied meaning, floating free of the focalizer, or contradicting scene pressure.
- Watch counts are leads, not verdicts: verify each hit in context and discard false positives by name.

Write the completed audit, in the Required verdict format, to {audit_root}/claude/chapter_{NN}.purple_prose.md. Findings must be revision orders an editor can execute without re-deriving your reasoning.
