# Audit: Periodic Voice Check (rhythm/banned phrases/anachronisms)

id: voice_check_protocol | owner: claude | tier: risk
trigger: cadence:every-5-chapters
output: {audit_root}/claude/voice_check_{NN}.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:2557+ [Reddit 9 #9 voice checks]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The source protocol, faithful to the text:

> Every few chapters, or whenever something felt off, I ran a voice check.
> For that I provided:
> - the narrative voice section from the spec
> - banned phrases/patterns
> - a 500-word sample from a chapter I liked
> - the chapter I wanted checked
>
> Then I asked for:
> - rhythm mismatches
> - banned phrases
> - AI-sounding constructions
> - anachronistic language
> - repetitive metaphors
> - sentence length problems
> - an overall voice score
>
> This helped catch the places where the prose started to sound polished but dead.

Cadence in this harness: every 5 chapters, or whenever the prose feels off (the orchestrator may fire it early on flag:prose-feels-off). The check is comparative, not absolute — the chapter under check is graded against the book's own voice spec and its own best sample, not against generic good prose. The target failure is prose that is "polished but dead": grammatical, smooth, professionally toned, and not this book's voice.

The seven asks, operationalized:
1. **Rhythm mismatches** — passages whose sentence rhythm (cadence, clause shape, stop pattern) departs from the voice spec and the liked sample; quote the passage and the sample passage it fails against.
2. **Banned phrases** — every occurrence of an entry on the banned phrases/patterns list, verbatim, with location.
3. **AI-sounding constructions** — constructions characteristic of LLM defaults (balanced parallel clauses, not-X-but-Y scaffolds, thesis closers, hedged reactions, em-dash apposition for emphasis) even when not on the banned list.
4. **Anachronistic language** — vocabulary or idiom outside the book's period/setting register.
5. **Repetitive metaphors** — images or figurative domains recurring across the checked span; count occurrences.
6. **Sentence length problems** — monotonous length distribution, runs of same-shape sentences, or compression/expansion that contradicts scene pressure.
7. **Overall voice score** — 0-10 against the voice spec + liked sample, with the score justified by the findings above, never asserted bare.

## Required verdict format
One section per ask (1-6): either `CLEAN — <what you checked>; strongest counter-candidate: "<quote>" — why it survives` or a finding list, each entry: `"<quoted passage>" (chapter, location) — <why it fails, citing the spec line, banned-list entry, or sample contrast>`.

Then:
- `VOICE SCORE: <n>/10 — justification tied to findings`
- `POLISHED-BUT-DEAD ZONES: <locations where prose is technically clean but voiceless, each with a quote and the sample passage it pales against — or NONE with the nearest call quoted>`
- `REVISION ORDERS:` one numbered order per finding: quote, failure type, and concrete fix direction stated in terms of the voice spec or liked sample ("re-cut to the sample's stop pattern," "replace banned phrase with character-owned vocabulary from <voice card>"). Orders must be executable without re-deriving the reasoning.
- `OVERALL: VOICE-HOLDS` (score ≥ 8, no banned phrases, no polished-but-dead zones) or `OVERALL: VOICE-DRIFT (<n> findings)`.

## Prompt template (owner=claude)
You are running the periodic voice check covering chapters {chapter_range}. Begin from the Critique stance above. The failure you are hunting is prose that is polished but dead — it will read as competent; competence is not the standard, this book's voice is.

Inputs:
- The narrative voice section from the book's spec: {voice_spec}
- Banned phrases/patterns list (from the reading guide's tic catalog and the run's tics tracker): {banned_phrases}
- A ~500-word sample from a chapter the author/orchestrator liked (the calibration sample): {liked_sample}
- The chapter(s) to check: {chapter_files}
- Period/setting register notes: {reading_guide}
- Calibration notes, if present: {calibration}

Steps:
1. Read the liked sample twice and write one paragraph (for your own use, included in the report) naming its rhythm signature: stop pattern, clause shapes, diction temperature.
2. Work through asks 1-6 in order against the checked chapters. Quote every finding with location. For ask 2, match the banned list verbatim — report zero-hit entries as checked.
3. For rhythm and sentence-length findings, always pair the failing passage with a contrasting passage from the liked sample.
4. Hunt polished-but-dead zones explicitly: passages with no individual error that nonetheless could appear in any professionally edited novel.
5. Assign the voice score, justified line by line from your findings.

Write the completed check, in the Required verdict format, to {audit_root}/claude/voice_check_{NN}.md. VOICE-DRIFT findings convert to revision orders for the current revision round.
