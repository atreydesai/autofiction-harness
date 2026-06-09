# Audit: Positive Prose Audit (LLM-clean generic prose)

id: positive_prose_audit | owner: claude | tier: risk
trigger: sample:every-3rd-chapter + watch:vocab-clusters
output: {audit_root}/claude/chapter_{NN}.positive_prose.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: verve-legacy Positive Prose Audit

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

This is a fresh-session pass for the failure mode greps miss: smooth, grammatical,
generic prose that still feels LLM-clean. No mechanical pattern catches it, because
nothing is technically wrong. The audit asks four questions of the chapter, faithfully
carried over from the legacy pass:

1. **Which paragraphs feel portable to another novel?** Smooth paragraphs that could
   slot into any competent book in the genre without anyone noticing.
2. **Where does prose summarize pressure rather than make the reader inhabit it?**
   Tension reported from a managerial altitude instead of lived inside the scene.
3. **Where does dialogue sound polished, therapeutic, aphoristic?** Characters
   articulate their feelings with composed, workshop-clean fluency; lines arrive
   pre-resolved instead of under pressure.
4. **Where would literal precision beat figurative language?** Images installed where
   a concrete, exact, literal observation would do more work.

The reading guide's register and voice rules are the standard of comparison: "clean" is
defined relative to what THIS book's prose is supposed to be doing, not against generic
literary taste.

## Required verdict format

Four sections, one per question. In each section, per finding:

- `PORTABLE-PARAGRAPH | SUMMARIZED-PRESSURE | POLISHED-DIALOGUE | FIGURATIVE-WHERE-LITERAL`
  — quoted passage — one-line diagnosis — revision order stating what the rewrite must
  do (which scene pressure to inhabit, which literal observation to substitute, what
  unresolved texture the dialogue line must carry).

Chapter verdict: `LLM-CLEAN-FOUND` (any findings; orders listed) or `INHABITED` (no
findings — but each of the four sections must then quote its strongest counter-candidate
and explain why it passes; an empty section is a failed audit, not a pass).

## Prompt template

You are a skeptical professional fiction editor performing a cold read. You have not
seen this chapter before. No praise, no softening. Your job is to find prose that is
smooth, grammatical, and generic — prose with nothing technically wrong that still
feels machine-clean. Quote evidence for every claim.

Book register and voice rules (binding):
{reading_guide_register_excerpt}

Voice cards for characters appearing in this chapter:
{voice_cards}

Chapter text:
{chapter_text}

Answer these four questions, each as its own section, quoting every passage you flag:

1. Which paragraphs feel portable to another novel? For each, write one sentence
   naming the other novel it could appear in unchanged.
2. Where does the prose summarize pressure rather than make the reader inhabit it?
   For each, name the pressure being summarized and where in the scene the reader
   should have been made to live it.
3. Where does dialogue sound polished, therapeutic, or aphoristic? For each line,
   say what the character is too articulate about and what the under-pressure version
   would withhold or fumble.
4. Where would literal precision beat figurative language? For each image, propose
   the literal observation that should replace it.

For every finding, emit a verdict line in this exact format:
`<PORTABLE-PARAGRAPH|SUMMARIZED-PRESSURE|POLISHED-DIALOGUE|FIGURATIVE-WHERE-LITERAL> — "<quote>" — <diagnosis> — ORDER: <what the rewrite must do>`

End with the chapter verdict: `LLM-CLEAN-FOUND` or `INHABITED`. If INHABITED, every
section must still name what you checked and quote the strongest counter-candidate you
considered, with the reason it passes. A bare pass is a failed audit. Do not propose
full rewrites; emit revision orders the rewriter will execute.
