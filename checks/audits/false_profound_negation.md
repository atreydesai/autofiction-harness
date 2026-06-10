# Audit: False-Profound Negation Audit

id: false_profound_negation | owner: codex | tier: risk
trigger: watch:fieldguide-amplification-echo + flag:negation-dense (gate BANNED findings for banned-1.4/1.29/fg7/qs-not-x-but-y)
output: {audit_root}/codex/chapter_{NN}.false_profound_negation.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:784-793 [field guide 7]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
Field guide item 7, THE FALSE-PROFOUND NEGATION/RESOLUTION:

> "Not for justice. For control." "Not a hero. Not a villain. Just a man with a sword." "Not a threat. Something worse."
> Negate the obvious reading, then land on something meant to sound deeper. Works in two-beat and three-beat versions. Both are the same move: the writer arriving at a platitude through the scenic route.
> If a detail matters, weave it into a real sentence. "He insisted on honesty because it made his employees predictable, and he valued predictability above most things, including honesty." That's the same information as "Not for justice. For control." but it actually tells you something about the character.

Criteria:

1. **Two-beat negation/resolution.** Fragment or clause pair of the shape "Not X. Y." / "Not X — Y." / "It wasn't X. It was Y."
   - The first beat negates the obvious reading; the second lands on something meant to sound deeper.
   - Example shapes from the source: "Not for justice. For control." / "Not a threat. Something worse."

2. **Three-beat negation/resolution.** The same move stretched to three beats, typically double negation then a humble-sounding landing.
   - Example shape from the source: "Not a hero. Not a villain. Just a man with a sword."

3. **The platitude test.** For each hit, ask what the construction actually asserts once the staging is removed.
   - If the landing beat is a platitude reached by the scenic route — significance announced rather than information delivered — it fails.
   - If the negation does real work (correcting a belief a character actually holds on the page, in that character's voice, under scene pressure), it may stand; say so explicitly and prove the on-page belief being corrected.
   - Note the source's calibration: the move's danger is that both versions *sound* deep. The test is informational, not tonal —
     the failing version withholds the cause/motive/consequence; the passing rewrite delivers it.

4. **The rewrite direction.** The source's fix is not deletion by default:
   - If the detail matters, weave it into a real sentence that tells the reader something specific about the character or situation, as in the honesty/predictability example above.

## Required verdict format
One verdict line per criterion (1-4):
- `COMMITTED` — criterion passes; quote the strongest counter-candidate considered and why it survives (e.g., the on-page belief it genuinely corrects).
- `SCENIC-ROUTE (instances)` — list every flagged construction, quoted, with location and beat count (two-beat / three-beat).
- Criterion 3's line must include the stripped paraphrase for every flagged instance; criterion 4's line states whether each finding is a cut or a weave-in.

Then `REVISION ORDERS`:
- One numbered order per flagged instance giving (a) the quoted construction, (b) the platitude it resolves to when the staging is stripped, and (c) a rewrite directive in the source's direction — a real sentence carrying the same information with a specific cause, motive, or consequence attached.
- End with `OVERALL: COMMITTED` or `OVERALL: SCENIC-ROUTE (count)`.

## Procedure (owner=codex)
1. Read {chapter_file} in full once, without searching, and mark every sentence whose rhetorical engine is negate-then-land.
2. Run mechanical sweeps to catch what the read missed, treating hits as leads to verify in context, not verdicts:
   - grep the chapter for `Not `, `not a `, ` wasn't `, ` isn't `, `It was not`, `No `, `Just a `, ` — `, and sentence-initial fragments beginning with "Not";
   - cross-reference {watch_counts} for fieldguide-amplification-echo totals and the gate
     report for BANNED negation findings (banned-1.4-negation-formula, banned-1.29-negative-parallelism,
     banned-fg7-false-profound-negation, banned-qs-not-x-but-y / banned-qs-not-only-but).
3. For each candidate, classify as two-beat (criterion 1) or three-beat (criterion 2).
4. Apply the platitude test (criterion 3): strip the staging and state what is actually asserted.
   - Record the stripped paraphrase — this is the evidence the verdict rests on.
5. Check survivors against the allowance:
   - A negation that corrects a belief actually established on the page, in a character's own voice and register ({voice_cards}, {reading_guide_excerpts}), under scene pressure, may stand.
   - Quote the page-evidence of the belief being corrected for every survivor.
6. Count density. Even individually defensible instances fail collectively if the move recurs as a cadence.
   - More than two surviving instances in one chapter is a rhythm finding — order variation.
7. For every failed instance, draft the criterion-4 rewrite directive: name the specific motive, cause, or consequence the real sentence must carry.
8. Write the completed audit, in the Required verdict format, to {audit_root}/codex/chapter_{NN}.false_profound_negation.md.
