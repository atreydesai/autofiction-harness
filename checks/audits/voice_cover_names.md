# Audit: Cover-the-Names Voice Test

id: voice_cover_names | owner: codex | tier: core
trigger: every-chapter
output: {audit_root}/codex/chapter_{NN}.voice_cover_names.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:3382-3464 [Reddit 4 The Real Test] + verve-legacy distinguishable-without-tags

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The source test, applied verbatim:

> Read your last few scenes. Cover the names. Can you tell who's speaking just from *how* they talk?
> If not, your characters need more voice work. If yes, you've done something right.

The legacy per-chapter quality check states the same gate: "Are character voices distinguishable without name tags? Check against `style_and_voice.md`." (In this harness: check against the voice cards / style-and-voice artifact for the run.)

The underlying failure (same source thread): when prompted with trait lists, every character sounds like "the same polite, articulate person wearing different outfits." Real character voice isn't what they say — it's *how* they say it. "A teenager and a professor might both say 'I disagree.' But the teenager says 'that's literally so wrong' and the professor says 'I'm not certain that follows.' Same meaning, completely different people."

The test is mechanical, not impressionistic:

1. Strip every attribution tag and action beat that names the speaker from the chapter's dialogue exchanges.
2. For each stripped exchange of 4+ lines, attempt to re-attribute every line using only diction, rhythm, sentence length, evasions, fillers, formality, and owned vocabulary — checked against each speaker's voice card (register, modal dialogue mass, tics, never-says, owned words).
3. Score each exchange: every line attributable; most lines attributable; or interchangeable.

Exchanges between characters whose cards deliberately converge (siblings, colleagues sharing institutional register, a declared mimicry beat) are excused only if the reading guide or voice cards declare the convergence — name the declaration when excusing.

## Required verdict format
Per dialogue exchange (4+ lines):
- `DISTINCT — <speakers> — evidence: "<one quoted line per speaker>" + the card feature that pins each`
- `PARTIAL — <speakers> — <which lines could swap speakers, quoted> — <which card features are absent from the page>`
- `INTERCHANGEABLE — <speakers> — "<quoted exchange>" — both/all voices reduce to the same register; name it`

Chapter verdict:
- `VOICES-HOLD` — every exchange DISTINCT (or convergence explicitly declared). Must still list the weakest DISTINCT exchange and the single line most at risk of swapping (show your work).
- `VOICE-BLUR (<n> exchanges)` — any PARTIAL or INTERCHANGEABLE finding.

`REVISION ORDERS:` one per PARTIAL/INTERCHANGEABLE exchange: quote the lines to rewrite, name the speaker whose card is being violated or under-used, and name the specific card features (owned words, sentence-length quirk, evasion habit, contraction policy) the rewrite must put on the page. Orders that say "differentiate the voices" without naming card features are invalid.

## Procedure
1. Load the chapter, the voice cards for every character with dialogue in it, and the reading guide's voice rules ({reading_guide}); load any declared-convergence notes from {calibration} or the cards themselves.
2. Extract every dialogue exchange of 4+ lines. Produce a name-stripped copy of each: remove tags ("X said"), vocatives that name the listener, and action beats that identify the speaker.
3. Re-attribute each stripped line from voice evidence alone. Record per line: the attribution, confidence, and the card feature used. A line attributed only by content (who would know this fact) rather than voice (how it is said) counts as unattributable — knowledge is plot, not voice.
4. Score each exchange DISTINCT / PARTIAL / INTERCHANGEABLE per the verdict format. For DISTINCT verdicts, quote the strongest counter-candidate line you considered swapping.
5. Cross-check flagged exchanges against the cards: list which card features (tics, never-says, owned words, rhythm) are specified but absent from the chapter's lines. Absent features are the revision material.
6. Write per-exchange verdicts, the chapter verdict, and revision orders in the required format to the output path.
7. If the chapter verdict is VOICE-BLUR, queue the revision orders into the current revision round and mark the chapter not-committable until they are executed or explicitly rejected with reasons in the revision memo. This is a core-tier gate, not advisory.
