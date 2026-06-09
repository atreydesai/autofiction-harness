# Audit: Hedging / Narratorial Commitment Audit

id: hedging_commitment | owner: claude | tier: risk
trigger: watch:hedging-cluster
output: {audit_root}/claude/chapter_{NN}.hedging_commitment.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:81 [LLM outputs hedge tax]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The source documents a persistent "hedge tax" in LLM output: extra caution markers, balancing clauses, and meta-language like *it depends*, *on the one hand*, *perhaps*, or *here's a nuanced take* where a cleaner answer would do. Then the fiction translation, which is this audit's core: **in fiction, the equivalent problem is not always literal hedging. It is a narratorial reluctance to commit to a sharp emotional or sensory choice.**

Criteria:

1. **Literal hedge markers in narration.** Caution markers, balancing clauses, and meta-language imported into narrative prose:
   - *perhaps*, *it depends*-style equivocation, *on the one hand / on the other*, *in some ways*, *it was hard to say*.
   - Each instance must be tested in context — a focalizer who genuinely cannot know something is allowed uncertainty; a narrator splitting the difference to avoid choosing is not.

2. **Softened perception verbs.** *seemed to*, *appeared to*, *might have been*, *as if*, *almost*, *something like*, *a kind of*, *vaguely*, *somehow* —
   - flag when used to blur a perception the focalizer actually has.
   - "Something like grief" where the character is feeling grief is a refusal to commit, not a nuance.

3. **Both-ways emotional writing.** Sentences that assert an emotion and immediately dilute or counterweight it so no single sharp choice is made:
   - "she was angry, or maybe just tired"; "he felt relief, though it might have been something else".
   - Flag unless the ambivalence is itself the dramatized point and the scene does work with it.

4. **Sensory non-commitment.** Descriptions that gesture at a sense impression without landing one:
   - indeterminate colors, unspecified smells ("a strange smell"), sounds described only by their effect.
   - A sharp sensory choice names the thing; reluctance describes the haze around it.

5. **Allowable uncertainty.** Do not flag:
   - dramatized doubt belonging to the focalizer's actual epistemic position;
   - mystery the plot is protecting;
   - voice-true tentativeness established in {voice_cards} or the reading guide;
   - uncertainty wording inside dialogue, which is characterization.
   - The target is the *narrator's* reluctance, not the character's situation.

## Required verdict format
One verdict line per criterion (1-5):
- `COMMITTED` — passes; quote the strongest counter-candidate you considered and why it survives.
- `HEDGED (instances)` — list every flagged span, quoted, with location and which hedge type it is.

Then `REVISION ORDERS`:
- One numbered order per flagged instance, each stating the quoted text and the sharp choice the revision must make — name the emotion, land the sense impression, or cut the counterweight.
- Where the fix requires choosing between two hedged alternatives, say which one the scene evidence supports and why.
- End with `OVERALL: COMMITTED` or `OVERALL: HEDGED (count)`.

## Prompt template (owner=claude)
You are auditing chapter {NN} for narratorial hedging and failure to commit. Begin from the Critique stance above.

Inputs:
- Chapter text: {chapter_file}
- Reading-guide voice and register commitments: {reading_guide_excerpts}
- Voice cards for the chapter's focalizers (including any voice-true tentativeness): {voice_cards}
- Mechanical hedging-cluster counts (seemed/perhaps/almost/as-if/something-like densities): {watch_counts}
- Prior-chapter context (established knowledge states, protected mysteries): {prior_chapters_context}

Work criteria 1-5 in order:
- The watch counts tell you where the hedging cluster fired; your job is to adjudicate each hit in context, separating epistemic honesty from narratorial cowardice.
- The decisive question for every candidate is the source's question: is the narrator refusing to commit to a sharp emotional or sensory choice that the scene has earned and the focalizer possesses?
- Quote every flagged span.
- For every span you excuse, name the allowance (criterion 5) that excuses it and the evidence — a voice-card line, a protected mystery, the focalizer's genuine ignorance.

Also report aggregate texture: if individually defensible hedges stack into a chapter-wide haze (high density even with few hard failures), say so and order a density reduction with a target.

Write the completed audit, in the Required verdict format, to {audit_root}/claude/chapter_{NN}.hedging_commitment.md.
