# Audit: Character-Snapshot Conformance Audit

id: snapshot_conformance | owner: codex | tier: risk
trigger: flag:new-or-returning-character
output: {audit_root}/codex/chapter_{NN}.snapshot_conformance.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:3330-3381 [Reddit 3 snapshots]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The source method: a character snapshot is "a short document that describes how the character *thinks, talks, and moves through the world*" — operation, not trait lists. "Adjectives aren't behavior. And behavior is what makes a character feel real on the page." A trait-list character comes out "generically kind, vaguely independent, and 'guarded' in the most surface-level way possible (she crosses her arms a lot and avoids eye contact)."

The five snapshot fields (verbatim from the source's "What to include"):
1. **How they show emotion (not what emotions they have).** Skip "she's compassionate." Instead: "She shows care by doing things for people without being asked, but she physically stiffens when someone thanks her for it."
2. **How they speak.** Short sentences or long ones? Deflect questions? Answer questions with questions? Humor as armor? Swear? Trail off? Talk too much when nervous? ("One character who 'never finishes a sentence when she's lying' gives AI more to work with than ten adjectives.")
3. **What their body does under stress.** "She touches her mother's necklace when nervous." "He rolls a coin across his knuckles when he's thinking." "She stops blinking when she's scared — just goes completely still." These physical tells replace the "she felt nervous" sentences AI defaults to.
4. **Their central wound and how it distorts their behavior.** Not backstory the reader sees on the page — "the engine that drives every decision the character makes," informing behavior without dumping the exposition.
5. **Their contradiction.** "Every interesting character wants two things that conflict." Without it, characters "move through the story in a straight line, which is why they feel flat."

The quick-start template's question forms (for thin snapshots): How do they show care? How do they speak (one quirk is enough)? What does their body do when stressed or scared? What's the wound, and how does it distort behavior today? What two things do they want that conflict?

This audit asks, for each character the chapter introduces or brings back: **does the on-page behavior match the snapshot's operation fields** — how they think/talk/move, stress response, what they get wrong — and is the character operating (behaving specifically) rather than wearing adjectives?

## Required verdict format
Per character:
- `CHARACTER <name> (new | returning):`
  - Per field 1-5 (+ {what_they_get_wrong} where the snapshot carries it): `CONFORMS — field: "<verbatim snapshot text>" — on-page: "<quoted behavior>"` | `VIOLATES — field: "<verbatim>" — on-page contradiction: "<quote>" — scene-motivated cause: yes/no` | `INERT — field: "<verbatim>" — trigger present at <location> but field never fired` | `NO-TRIGGER — field had no opportunity this chapter (say why that's plausible)`
  - `TRAIT-LIST SYMPTOMS: <quoted generic behaviors — arm-crossing, eye-contact avoidance, felt-nervous sentences standing in for the character's specific tells — or NONE>`
  - Character verdict: `OPERATING` | `OFF-SNAPSHOT (<n> findings)` | `GENERIC (snapshot present but page shows placeholder behavior)`

Chapter verdict: `SNAPSHOTS-HOLD` (every audited character OPERATING — still quote each character's weakest conformance) or `SNAPSHOT-DRIFT (<n> characters)`.

`REVISION ORDERS:` one per VIOLATES/INERT/GENERIC finding: quote the snapshot field verbatim, name the beat to revise, and state the specific behavior to put on the page (the field's own tell, deflection, or contradiction — not a paraphrase of the adjective). If the snapshot itself is thin (missing operation fields), issue a tracker order: complete the snapshot using the quick-start questions before the character's next chapter.

## Procedure
1. Load the chapter, the flag metadata naming new/returning characters, each such character's snapshot/voice card (all five fields plus {what_they_get_wrong}), {reading_guide} character notes, and {calibration} if present.
2. Snapshot sufficiency check first: confirm each snapshot has operational content for fields 1-5. Record missing/adjective-only fields — they generate tracker orders and weaken what the chapter can be held to.
3. For each character, collect every on-page behavior: dialogue habits, emotional displays, body behavior under stress, decisions. Quote with locations.
4. Map behaviors to fields. For each field rule CONFORMS / VIOLATES / INERT / NO-TRIGGER. INERT requires you to name the trigger the chapter offered.
5. Sweep for trait-list symptoms: generic guardedness gestures, named-emotion sentences ("she felt nervous") where the snapshot specifies a tell, behavior interchangeable with any character of the same archetype.
6. Rule per-character and chapter verdicts; write report and revision orders in the required format to the output path.
7. Queue SNAPSHOT-DRIFT orders into the current revision round; record acceptance or rejection with reasons in the revision memo.
