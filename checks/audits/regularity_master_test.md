# Audit: Read-Aloud Regularity Master Test

id: regularity_master_test | owner: claude | tier: risk
trigger: flag:prose-variability-fail + sample:per-act
output: {audit_root}/claude/chapter_{NN}.regularity_master_test.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:3294+ [field guide MASTER TEST] + ruleset watch-regularity

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
THE MASTER TEST (field guide):
- Read your text aloud. If every paragraph sounds like it was written by the same person in the same mood, something has gone wrong.
- A grief scene should not have the same rhythm as a comedy scene. A fight should not have the same rhythm as a political negotiation.
- If your text has been AI-edited, the most likely symptom is rhythmic monotony — every scene given the same weight, the same fragment patterns, the same solemn pauses, the same trailing wit.
- The cure is not to write worse. It's to write unevenly. Let some paragraphs be rough. Let some scenes breathe without commentary. Let your narrator shut up occasionally and trust that the reader is keeping up.

Writing ruleset rule 10, "Watch regularity": LLM writing often becomes suspicious when its most visible feature is its own regularity. Watch for repeated use of the same moves:
- parallel enumeration and reflexive three-part cadence inside sentences
- multiple sentences doing hidden list work even without bullets
- concession-plus-positive rhythm (`not X, but Y`; `may sound X, but Y`)
- paragraph-closing type definitions (`the kind of X where Y`)
- identical paragraph arcs
- one neat claim sentence at the top of every paragraph followed by orderly elaboration
- the same punctuation move in every paragraph
- the same controlling metaphor or contrast returning until it feels too tidy
- repeated thesis-like openings
- stacked mini-sentences for impact, especially when each sentence carries one adjacent thought that could have shared a sentence

Caveats from the rule, all binding:
- Three-item parallel lists still count. Changing `X, Y, Z, and W` to `X, Y, and Z` does not fix the underlying shape if the sentence is still doing list work.
- The fix is not random variation; it is to break the repeated pattern where it starts to dominate.
- One common over-correction is false crispness: splitting every clause into its own sentence to break regularity — do not order that.

Mechanical input: the prose_variability_audit.sh report supplies per-chapter metrics —
- words, sentences, mean_sentence_words, paragraphs, mean_paragraph_words, dialogue_word_ratio, interiority_per_1k;
- cross-chapter dispersion: sentence_cv, paragraph_cv, dialogue_sd, interiority_cv (its FAIL threshold: sentence_cv < 0.08, paragraph_cv < 0.12, dialogue_sd < 0.06, interiority_cv < 0.15).
- These are blunt instruments: low variance is not automatically bad, but a manuscript uniform on all four axes usually reads flattened. Use them to locate suspicion; the read-aloud judgment decides.

## Required verdict format
Verdict vocabulary: `UNEVEN` (pass) / `MONOTONE (instances)`.
Required verdict lines, each with quoted line evidence:
1. MOOD-RHYTHM MATCH — does each scene's rhythm differ with its mood (grief vs comedy, fight vs negotiation)? Quote one passage per distinct scene mood and compare their cadences explicitly.
2. SAME-PERSON-SAME-MOOD SYMPTOM — fragment patterns, solemn pauses, trailing wit recurring across unlike scenes; quote the recurrences side by side.
3-12. One line per rule-10 move (the ten bullets above, in order) — `UNEVEN` or `MONOTONE` with quoted instances and locations.
13. METRICS RECONCILIATION — state whether the mechanical report's signal is confirmed or overruled by the read, and why.

Then `REVISION ORDERS`:
- One numbered order per MONOTONE finding, naming where the pattern starts to dominate and what breaks it (vary the move, merge stacked mini-sentences, let a paragraph run rough, cut commentary).
- Never "add random variation"; never blanket sentence-splitting.
- End with `OVERALL: UNEVEN` or `OVERALL: MONOTONE (count)`.

## Prompt template (owner=claude)
You are running the read-aloud regularity master test on chapter {NN}. Begin from the Critique stance above.

Inputs:
- Chapter text: {chapter_file}
- Mechanical metrics: {prose_variability_report}
- Reading-guide register map (which scenes are meant to be in which mood): {reading_guide_excerpts}
- Voice cards: {voice_cards}
- Watch counts for cadence patterns: {watch_counts}
- Prior chapters for cross-chapter cadence comparison: {prior_chapters_context}

Procedure:
- Simulate the read-aloud: move through the chapter paragraph by paragraph attending only to rhythm — sentence shapes, pause placement, where wit lands, where fragments cluster.
- Map each scene's mood from the reading guide, then execute verdict lines 1-13 in order, quoting evidence for every line including passes.
- When the metrics report flags uniformity, locate it in actual prose or overrule it with quoted proof.
- When the metrics pass, still run the read — metric variance can coexist with template monotony (identical paragraph arcs survive sentence-length variation).

Write the completed audit, in the Required verdict format, to {audit_root}/claude/chapter_{NN}.regularity_master_test.md.
