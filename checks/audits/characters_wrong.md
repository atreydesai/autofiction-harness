# Audit: Let-Characters-Be-Wrong / Competence-Default Audit

id: characters_wrong | owner: claude | tier: risk
trigger: sample:every-3rd-chapter
output: {audit_root}/claude/chapter_{NN}.characters_wrong.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:3588+ [Reddit 4 Fix 5]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The source criterion, applied verbatim:

> AI defaults to competence. Every character tends to become reasonable, articulate, and emotionally intelligent.
> Real people aren't like that. Real people:
> - Misunderstand each other
> - Say the wrong thing
> - Have blind spots
> - Get defensive for no good reason
>
> Tell the AI what your character gets wrong.
> "Dara is terrible at reading social cues. She often takes jokes literally."
> "Viktor assumes the worst of everyone. He'll interpret neutral statements as insults."
> Flaws create friction. Friction creates interesting dialogue.

In this harness, each major character's snapshot carries a {what_they_get_wrong} field. This audit checks the chapter against those fields:

1. **Competence-default sweep.** Across the chapter, does every character read as reasonable, articulate, and emotionally intelligent? Specifically hunt for the four real-people behaviors: characters misunderstanding each other, saying the wrong thing, exhibiting blind spots, getting defensive for no good reason. A chapter where nobody does any of these is the default firing.
2. **Per-character wrongness conformance.** For each major character on the page, take their {what_they_get_wrong} field and ask: did the chapter give this wrongness an opportunity to operate, and did it operate? A character whose declared blind spot is on-stage but inert (the situation that should trigger it occurs and they respond with clean insight instead) is a finding.
3. **Friction yield.** Where wrongness does appear, does it create friction — a misread that costs something, a defensive turn that derails an exchange, a wrong thing said that another character must absorb? Wrongness that is announced but immediately corrected, apologized for, and resolved within the same beat is the competence default wearing a costume.

Calibration: not every character must be wrong in every chapter. Flag (a) chapters where no one is wrong about anything, and (b) declared wrongness that had a live trigger and did not fire. Genuinely competent beats (a professional doing their job well) are not findings unless the whole chapter is frictionless — that is the adjacent frictionless_competence audit's territory; here the subject is interpersonal and psychological wrongness.

## Required verdict format
Section 1 — sweep verdict:
- `WRONGNESS-PRESENT — instances: <per instance: character, "<quoted evidence>", which of the four behaviors>` or
- `COMPETENCE-DEFAULT — every character reasonable/articulate/emotionally intelligent; quote the three most suspiciously well-adjusted exchanges`

Section 2 — per major character:
- `<name> — gets-wrong field: "<quoted {what_they_get_wrong}>" — verdict: OPERATED ("<quoted evidence>") | TRIGGER-MISSED (trigger: "<quoted situation>", response was clean insight: "<quote>") | NO-TRIGGER (no scene engaged this wrongness — acceptable, say why)`

Section 3 — friction yield: per wrongness instance, `FRICTION ("<what it cost, quoted>")` or `COSTUMED (announced then resolved in-beat: "<quote>")`.

Chapter verdict: `WRONG-ENOUGH` (sweep passes, no TRIGGER-MISSED, friction real — still quote the weakest instance) or `TOO-COMPETENT (<n> findings)`.

`REVISION ORDERS:` one per finding, naming the character, quoting their {what_they_get_wrong} field, identifying the beat where it should fire, and stating what the wrongness must cost. Orders must not soften the character into quirkiness; the field is the spec.

## Prompt template (owner=claude)
You are auditing chapter {NN} for the competence default — the documented LLM tendency to make every character reasonable, articulate, and emotionally intelligent. Begin from the Critique stance above. Your bias to fight: you will want to read clean, insightful character behavior as good writing. Here it is evidence of failure.

Inputs:
- Chapter text: {chapter_file}
- Character snapshots for every major character in the chapter, including each {what_they_get_wrong} field: {character_snapshots}
- Reading-guide character notes and register commitments: {reading_guide}
- Calibration notes, if present: {calibration}

Work through the three sections in order:
1. Sweep the chapter for the four behaviors (misunderstanding, saying the wrong thing, blind spots, unprovoked defensiveness). Quote every instance; if you find none, quote the three most well-adjusted exchanges as evidence of the default.
2. For each major character, quote their {what_they_get_wrong} field, locate every scene situation that could trigger it, and rule OPERATED / TRIGGER-MISSED / NO-TRIGGER with quotes.
3. For each wrongness instance, rule FRICTION or COSTUMED — wrongness must cost something on the page.

Write the completed audit, in the Required verdict format, to {audit_root}/claude/chapter_{NN}.characters_wrong.md. Every TOO-COMPETENT finding must carry a revision order an editor can execute without re-deriving your reasoning.
