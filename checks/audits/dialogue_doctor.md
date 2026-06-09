# Audit: Dialogue Doctor

id: dialogue_doctor | owner: claude | tier: core
trigger: flag:dialogue-scenes (per dialogue_scene_manifest)
output: {audit_root}/claude/chapter_{NN}.dialogue_doctor.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: verve-legacy Dialogue Doctor + collation dialogue rules

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
A fresh session reads the chapter cold and finds LLM-default dialogue failures. The legacy failure list, applied per scene:

1. **Voice convergence** — two or more speakers become rhythmically and lexically interchangeable.
2. **Monotone Q/A rhythm** — exchanges fall into question/answer volleys of similar length and weight.
3. **Missing interiority** — the focalizer's mind goes dark during the exchange.
4. **Questions-as-statements** — characters deliver positions disguised as questions to manufacture portent.
5. **Fake-McCarthy minimalism** — stripped attribution and clipped lines performing starkness the scene has not earned.
6. **Jargon-trading without translation** — speakers exchange world-terms the reader has no way to weigh.
7. **Attribution opacity** — the reader loses track of who is speaking.

The constitution's dialogue-register rules sharpen these (cite per finding):
- **Rule 4 (contractions are the default):** "Uncontracted forms (\"do not\", \"I am\", \"cannot\") should appear only when a character is being deliberately formal, precise, emphatic, historically or culturally setting-true, or otherwise world-true." FORBIDDEN (stiff): "I do not trust him." / "You will not survive this." NATURAL: "I don't trust him." / "You won't survive this."
- **Rule 5:** when the voice card or style bible specifies a contraction level for a character, honor it; otherwise default moderate-high.
- **Rule 6 (period/setting calibration):** "Modern colloquialisms in historical settings are as much a craft failure as stiff formality in contemporary ones."
- **Rule 7 (most real dialogue is unremarkable):** "Not every line should be a revelation, a power move, or a quotable aphorism… A conversation where every line lands perfectly is a written conversation, not a spoken one. The goal is dialogue that sounds overheard, not composed."
- **Rule 8 (literary polish is the most common failure):** "A line can be informal, contracted, character-specific, and still read as if it was workshopped. When in doubt between a line that lands cleanly and one that arrives with friction, choose friction."
- **Rule 9 (the overcorrection):** stripping the focalizer's interiority from dialogue scenes until the reader has nothing to follow except the informational content of the lines. "A dialogue scene where the focalizer's mind goes dark is a scene the reader cannot enter." Interiority that orients the reader through the character's lived relationship to information is part of the scene, not narrator performance. Flag over-stripped scenes as failures equal to over-polished ones.

The quality brief's fake-sharp dialogue cut-list — cut or rewrite, verbatim:
- exchanges that exist mainly to deliver a compact aphorism
- noun-question / portentous-answer patterns
- "in [abstraction]" lines that make the literal scene feel like a prop
- dialogue where every speaker has the same dry correction rhythm
- zingers that arrive at the moment a character should be confused, tired, afraid, ashamed, ordinary, or quiet
- lines that sound quotable but not speakable
- loaded short lines followed by unmarked silence when the silence carries tactical, emotional, or informational weight but the focalizer registers nothing about what it costs, who watched it, or what it changed

Calibration: the reading guide's voice rules override generic defaults. For chat-format or otherwise non-standard dialogue forms, the reading guide names which generic failure modes do NOT apply — honor those exclusions explicitly. Ordinary-talk scenes (meals, transit, aftermath) may circle, stall, and produce flat functional lines; do not sharpen organic texture into debate.

## Required verdict format
Per scene with substantial dialogue, one block:
- `SCENE <id/location>:` then one verdict line per failure mode (1-7) plus `FAKE-SHARP` and `INTERIORITY-OVERCORRECTION`:
  - `CLEAN — <what you checked>; strongest counter-candidate: "<quoted line>" — why it survives`
  - `FAIL — <failure mode> — "<quoted exchange>" (speakers, location) — why it fails, citing the rule or cut-list bullet`
- `REVISION ORDERS:` one numbered order per FAIL, each quoting the exchange, naming the failure, and stating the rewrite direction in terms of the speakers' voice cards and the scene's pressure.

Chapter verdict: `OVERALL: CLEAN` (only if every scene block is all-CLEAN, with counter-candidates shown) or `OVERALL: BLOCKING (<n> findings)`.

**Findings are BLOCKING.** They are resolved via opposing-model rewrite — the orchestrator routes the revision orders into a rewrite by the other model lane, not back to the model that drafted the scene. Self-repair by the drafting model is not an accepted resolution.

## Prompt template (owner=claude)
You are the Dialogue Doctor for chapter {NN}. You are reading cold: you have not seen this chapter before and you owe its author nothing. Begin from the Critique stance above.

Inputs:
- Chapter text: {chapter_file}
- Voice cards for every speaker in the chapter (verbatim): {voice_cards}
- Reading-guide voice rules, register markers, and any declared exclusions for non-standard dialogue forms: {reading_guide}
- Calibration notes (book-specific banned moves and observed drift), if present: {calibration}
- Dialogue scene manifest entries for this chapter: {dialogue_scene_manifest}

For each scene in the manifest:
1. Read the scene aloud in your head, covering attributions. Test failure modes 1-7 in order; quote evidence for every verdict.
2. Run every exchange against the fake-sharp cut-list. A line that is quotable but not speakable fails even if it is in character.
3. Test rule 9 in both directions: is the focalizer's mind present enough to orient the reader, and is interiority reacting to the exchange rather than explaining it twice?
4. Check each speaker's lines against their voice card: contraction policy, register, never-says list, under-pressure behavior. Quote any line the card forbids.
5. Apply the reading guide's exclusions before flagging — name the exclusion when you decline to flag.

Write the completed audit, in the Required verdict format, to {audit_root}/claude/chapter_{NN}.dialogue_doctor.md. Every FAIL must carry a revision order an opposing-model rewriter can execute without re-deriving your reasoning.
