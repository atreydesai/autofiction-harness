# Audit: Abstract-Noun Character-Description Audit

id: abstract_noun_character | owner: codex | tier: risk
trigger: watch:abstract-noun-character
output: {audit_root}/codex/chapter_{NN}.abstract_noun_character.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:3742-3749 [field guide 8]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The source entry (field guide 8, THE ABSTRACT-NOUN CHARACTER DESCRIPTION), faithful to the text:

> "They were memory, flaw, hunger." "She was silence, patience, and rage." "He was ambition in a green hood."
> This is the character-description equivalent of a motivational poster. It asserts depth without demonstrating it. If a character is compelling, show the reader through action, dialogue, or a specific observed detail. If you can't demonstrate it, you can just say "she was compelling" plainly and move on with your life.

Operational criteria:

1. **Identity-equals-abstraction constructions.** Any sentence equating a character with one or more abstract nouns: "[She/He/They] was/were [abstraction]", lists of abstractions ("silence, patience, and rage"), and the costumed variant — abstraction + concrete garnish ("ambition in a green hood"). The garnish does not save the construction.
2. **Asserted-depth test.** For each hit: does the abstraction assert a quality the chapter never demonstrates? Check the surrounding scenes for action, dialogue, or a specific observed detail that carries the same quality. Assertion with demonstration nearby is redundant (cut the assertion); assertion without demonstration is hollow (replace it with demonstration).
3. **The plain-statement alternative.** The source allows the honest fallback: a plain register statement ("she was compelling") is acceptable where the book's narrator speaks plainly — what is banned is the poster-ized triple-abstraction performing depth.
4. **Near-miss patterns.** Predicate abstractions doing the same work in other syntax: "what she was, mostly, was patience"; "he had become hunger itself"; appositive stacks ("[Name] — memory, flaw, hunger —"). Flag these under criterion 1.

Calibration: figurative identity claims that are scene-anchored and focalizer-true (a character thinking of another in one abstraction the scene just earned) may pass; the failure is the narrator's unearned summary-of-soul. Cite the earning beat when granting a pass. The reading guide's declared narrator register ({reading_guide}) governs how plain the plain alternative should be.

## Required verdict format
Per hit:
- `POSTER — "<quoted construction>" (location, character) — asserted quality: <abstractions> — demonstration nearby: NONE | REDUNDANT ("<quoted demonstrating beat>")`
- `EARNED — "<quoted construction>" — earning beat: "<quote>" — focalizer: <name>`

Chapter verdict:
- `DEMONSTRATED` — no POSTER hits. Must still quote the most abstraction-heavy surviving description and the beat that earns it.
- `MOTIVATIONAL-POSTER (<n> hits)`.

`REVISION ORDERS:` one per POSTER hit, choosing per the source fix:
- demonstration nearby REDUNDANT → `CUT the assertion; the beat at <location> already carries it`;
- demonstration NONE → `REPLACE with action, dialogue, or a specific observed detail that demonstrates <quality> — drawn from <scene materials / snapshot field to use>`;
- where the book's register supports it → `FLATTEN to plain statement in the narrator's register`.
Orders may not replace one abstraction with another, and may not convert the abstraction into a metaphor that still asserts rather than demonstrates.

## Procedure
1. Load the chapter, the mechanical watch counts for abstract-noun-character patterns ({watch_counts}), character snapshots for named characters, {reading_guide} narrator-register rules, and {calibration} if present. Watch counts are leads, not verdicts — verify each in context and discard false positives by name.
2. Sweep the chapter for criteria 1 and 4 beyond the watch hits: identity-equals-abstraction in any syntax, including appositives and "had become" variants.
3. For each hit, run the asserted-depth test: search the chapter (and adjacent-chapter context if supplied) for action, dialogue, or specific observed detail demonstrating the same quality. Record NONE or quote the demonstrating beat.
4. Test candidate passes against the focalizer-earned exception; cite the earning beat and the focalizer, or deny the pass.
5. Issue per-hit verdicts, the chapter verdict, and revision orders in the required format; write to the output path.
6. Queue MOTIVATIONAL-POSTER orders into the current revision round; record acceptance or rejection with reasons in the revision memo.
