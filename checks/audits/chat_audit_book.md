# Audit: Book-Level Conversation Audit (per recurring speaker)

id: chat_audit_book | owner: codex | tier: book
trigger: phase:whole-book
output: {audit_root}/codex/book.chat_audit.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: legacy-pipeline editor Chat Audit (book-level), genericized

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

For each recurring conversation participant — any character whose conversations
(dialogue scenes, message exchanges, calls, letters, whatever recurring-exchange forms
the book uses) appear in MORE THAN 3 chapters — two independent checks. This is the
book-level extension of the per-chapter conversation-variety audit; per-chapter
variety passing does not imply this audit passes.

1. **Per-pair variety.** For every consecutive pair of that character's conversations
   across the book: does the later one show variation from the earlier on at least one
   of — relational stake-shift (what changed between the participants), format/shape,
   length, temporal mode (time-of-day / time-stamp / narrative-time context), register
   beat? Or is it the same conversation with the topic substituted? Topic substitution
   is the LLM's signature recurring-conversation failure: new subject, identical
   relationship, identical rhythm.
2. **Arc-level escalation.** Across ALL of that character's conversations in sequence:
   does the relationship arc escalate / deepen / fracture / oscillate / resolve — or is
   it nine versions of the same conversation?

**Pairwise and arc can diverge** — pairwise can pass (every consecutive pair locally
varied) while the arc flatlines (the tenth conversation leaves the relationship where
the first found it). Both checks are mandatory per character.

## Required verdict format

Per recurring character, one block:

```
CHARACTER: <name> — conversations in <N> chapters: <list>
  pairwise: per consecutive pair <ChA→ChB> — VARIED (dimension(s): stake-shift |
    format | length | temporal | register, with one-line evidence) |
    TOPIC-SUBSTITUTED (what stayed identical, quoted from both)
  arc: <one-paragraph arc summary with quoted first / midpoint / final beats> —
    ESCALATES | DEEPENS | FRACTURES | OSCILLATES-WITH-PURPOSE | RESOLVES | FLAT
  verdict: VARIED+ARC-BUILDS | VARIED-BUT-ARC-FLAT | NOT-VARIED
```

- `VARIED+ARC-BUILDS` — pairwise varied and arc moves; the arc summary with quoted
  beats is mandatory evidence (no bare pass).
- `VARIED-BUT-ARC-FLAT` — pairs pass, arc flatlines. Proposals required, per
  conversation that contributes least: `CUT <location>` / `MERGE <ChA + ChB>` /
  `RESEQUENCE <order>` / `AMPLIFY <location>: <the relational stake the conversation
  must move>`.
- `NOT-VARIED` — topic-substituted pairs found; each gets a revision order asking:
  what relational stake-shift, format, length, temporal mode, or register beat
  distinguishes this conversation — and if nothing, can it be amplified to earn its
  place, cut entirely, or merged with another?

Book verdict: `ALL-SPEAKERS-PASS` or `SPEAKER-FINDINGS` (per-character list).

## Procedure

1. Build the recurring-speaker roster: scan the manuscript for every character whose
   conversations appear in >3 chapters. Do not rely on the dialogue manifest alone;
   verify against the text.
2. For each character, extract their conversations in book order with chapter
   locations.
3. Run the pairwise check on every consecutive pair, naming the varied dimension(s)
   with quotes — default skeptically to TOPIC-SUBSTITUTED unless evidence shows
   variation.
4. Read the full sequence and write the arc summary; judge FLAT if the final
   conversation could be swapped with an early one without continuity damage.
5. Write per-character blocks and the book verdict; queue all orders and proposals
   into the revision round.
6. Save the report to the output path.
