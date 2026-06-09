# Audit: Rhythm-vs-Clarity Audit

id: rhythm_vs_clarity | owner: claude | tier: risk
trigger: flag:stylized-prose
output: {audit_root}/claude/chapter_{NN}.rhythm_vs_clarity.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:3119+ [BANNED Rhythm vs. Clarity]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The BANNED guide's rule, complete and verbatim:

> **Rhythm vs. Clarity**
> * Clarity wins. A clunky sentence that communicates beats a smooth sentence that obscures.

The rule is short; the audit operationalizes it. Wherever stylization and comprehension conflict, the verdict goes to comprehension — this is the adjudication rule that sits above every rhythm, cadence, and lyricism choice in the manuscript. The audit fires on chapters flagged for stylized prose and checks whether the style ever costs the reader the scene.

Criteria — each is a place where smooth sentences typically obscure:

1. **Actor/action obscurity.** Stylized fragments, subject-dropped clauses, or inverted syntax where a first-time reader cannot reliably reconstruct who did what to whom.
   - The test is restatement: write the literal paraphrase; if producing it required guesswork or rereading, the sentence failed.

2. **Antecedent fog.** Pronouns and elegant-variation epithets ("the older man," "the soldier") whose referent is ambiguous in scenes with multiple candidates, kept vague for rhythm's sake.

3. **Sequence and causality blur.** Lyric compression that makes the order of events, or what caused what, ambiguous —
   - especially in action, blocking, and entrances/exits.
   - If two competent readers could stage the scene differently, it fails.

4. **Image that swallows the fact.** Metaphor or rhythmic flourish replacing the load-bearing literal information rather than accompanying it,
   - so the reader gets the music but not the event, object, or stake the plot needs them to have.

5. **Clunky-but-clear is acceptable.** The rule's converse, enforced against over-correction:
   - Do not flag a sentence merely for being plain, flat, or rhythmically awkward if it communicates.
   - A clunky sentence that communicates beats a smooth sentence that obscures — never order a fix that trades comprehension for polish.
   - Flag any prior edit visible in the chapter that appears to have made that trade.

Allowable obscurity:
- deliberate, plot-protected withholding (mystery the book is running);
- disorientation that is the focalizer's actual state, rendered so the reader shares the confusion knowingly rather than suffering it accidentally.
- Each excuse must be argued from {reading_guide_excerpts} or scene evidence.

## Required verdict format
One verdict line per criterion (1-5):
- `CLEAR` — passes; quote the strongest counter-candidate considered (the most stylized sentence you tested) and its surviving paraphrase.
- `OBSCURED (instances)` — every flagged sentence/passage, quoted, with location, plus your literal paraphrase and what a reader could get wrong.

Then `REVISION ORDERS`:
- One numbered order per finding stating the minimum clarity repair — restore the actor, fix the antecedent, unblur the sequence, reattach the literal fact.
- Each order explicitly permits clunk: the repaired sentence may be less smooth.
- End with `OVERALL: CLEAR` or `OVERALL: OBSCURED (count)`.

## Prompt template (owner=claude)
You are auditing chapter {NN}, flagged for stylized prose, on the rule that clarity wins. Begin from the Critique stance above.

Inputs:
- Chapter text: {chapter_file}
- Reading-guide style commitments (what stylization this book has licensed): {reading_guide_excerpts}
- Voice cards: {voice_cards}
- Watch counts: {watch_counts}
- Prior-chapter context (running mysteries, established referents): {prior_chapters_context}

Procedure:
- Read as a first-time reader with no access to the outline.
- For every stylized sentence — fragments, inversions, heavy compression, sustained metaphor — run the restatement test of criterion 1 and log the result, including for sentences that pass.
- Work criteria 1-5 in order with quoted evidence.
- Where you excuse an obscurity as deliberate withholding or shared disorientation, cite the reading-guide line or scene evidence that licenses it; an excuse without a license is a finding.
- Enforce criterion 5 against yourself: if any revision order you draft would smooth a sentence at a cost to what it communicates, rewrite the order.

Write the completed audit, in the Required verdict format, to {audit_root}/claude/chapter_{NN}.rhythm_vs_clarity.md.
