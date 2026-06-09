# Audit: Self-Revision Checklists (two 7-question lists)

id: self_revision_checklists | owner: codex | tier: book
trigger: phase:full-book-critique
output: {audit_root}/codex/book.self_revision.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:7204-7233 [Novel process checklists]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The source checklists (Novel process report, "Checklists for self-revision"),
transcribed verbatim. A structural edit pass should answer the following before any
line polish:

**Structural questions:**

1. Is the protagonist's objective explicit early enough?
2. Does the inciting disruption genuinely alter the status quo?
3. Does each major section escalate cost, pressure, or complexity?
4. Are midpoint and late-book turns qualitatively different from earlier problems?
5. Does every POV chapter justify its existence?
6. Is the ending caused by character choice rather than random rescue?
7. Does the final state answer the novel's central dramatic question?

A sentence-level pass should then ask:

**Line-edit questions:**

1. Is the narration in the correct POV distance for the scene?
2. Are verbs specific and active where pressure is high?
3. Is filler dialogue trimmed?
4. Does description arise from the focal consciousness?
5. Is there line-by-line micro-tension in quiet passages?
6. Are exposition paragraphs placed where they do not stall momentum?

(The collation's sentence-level table carries six questions; transcribe what the source
gives — do not invent a seventh.)

The source also names the **common self-editing failures** to hunt while answering:
overexplaining motivation that is already dramatized, front-loading worldbuilding,
writing scenes with no turn, confusing "more words" with "more depth," and polishing
grammar before fixing causality. Many beloved subplots, metaphors, and passages belong
in the cut file if they damage momentum.

Ordering is binding: the structural list is answered for the whole book BEFORE any
line-polish finding is acted on.

## Required verdict format

Per question, one verdict line:

```
S<1-7> | L<1-6>: YES | NO — evidence: "<quoted passage(s) / chapter refs that prove it>"
```

- A YES with no quoted evidence is treated as NO.
- For S5 (POV chapters) and L-questions, sample-based evidence must name the chapters
  sampled and quote the worst case found, not the best.

Book verdict:

- `CHECKLISTS-PASS` — all thirteen YES with evidence. Still list, per question, the
  weakest passing case you considered failing.
- `CHECKLISTS-FAIL` — any NO. Each NO converts to a revision order:
  `FIX <question id> at <chapter/location>: <what must change>` — structural NOs are
  queued as macro-revision operations; line-edit NOs as line-pass orders, and line-pass
  orders are frozen until all structural NOs are resolved.

Also report a `SELF-EDITING-FAILURES SWEEP`: for each of the five named failures,
FOUND (locations + quotes) or NOT-FOUND (what you checked).

## Procedure

1. Read the full manuscript with the structural list only. Answer S1-S7 with evidence;
   for S3, quote the escalating cost per major section side by side.
2. Only after the structural verdicts are written, run L1-L6 on a stratified sample:
   minimum one early, one midpoint, one late chapter, plus every chapter flagged by
   cold reads, with quotes for every verdict.
3. Run the self-editing-failures sweep across the same sample.
4. Write verdicts in the required format; convert every NO and every FOUND into a
   revision order and queue it (structural before line, per the ordering rule).
5. Save the report to the output path. `CHECKLISTS-FAIL` on any structural question
   blocks line-editing passes and final assembly until resolved or explicitly rejected
   with reasons.
