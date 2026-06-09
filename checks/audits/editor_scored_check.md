# Audit: Editor-Not-Satisfied-Customer Scored Check

id: editor_scored_check | owner: codex | tier: core
trigger: every-chapter
output: {audit_root}/codex/chapter_{NN}.editor_scored_check.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:6056-6077 [Reddit 9 check like an editor]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The source procedure, verbatim:

> 7. Check the draft like an editor, not like a satisfied customer
> After each draft, I ran a beat check. I asked the AI to score the chapter on things like:
>
> - goal clarity
> - conflict escalation
> - revelation landing
> - character consistency
> - pacing
> - chapter close
> - prose quality
>
> The scores were less important than the specific revision notes.
> If conflict escalation scored low, I fixed that before drafting the next chapter. Otherwise I was just building later chapters on a weak foundation.

The seven scored dimensions are mandatory and fixed: **goal clarity, conflict
escalation, revelation landing, character consistency, pacing, chapter close, prose
quality.** Each gets a numeric score 1-10. The score is the trigger; the revision note
is the product. A score with no quoted evidence and no actionable note is an audit
failure regardless of the number.

The foundation rule is the point: a low-scoring dimension is fixed **before the next
chapter is drafted** (drafter stage) or before the chapter is committed (editor stage).
Later chapters built on an unfixed weak dimension inherit the weakness.

## Required verdict format

One block per dimension, all seven required:

```
<dimension>: <score>/10
  evidence: "<quoted passage(s) that justify the score — strongest counter-candidate if scoring high>"
  revision note: <specific, executable instruction — or "none needed" ONLY with the evidence above>
```

Chapter verdict:

- `FOUNDATION-SOUND` — every dimension ≥ 7 AND every dimension shows quoted evidence.
- `WEAK-FOUNDATION` — any dimension ≤ 6. List the failing dimensions and emit one
  revision order per failing dimension: `FIX <dimension> at <location>: <what must change>`.

`WEAK-FOUNDATION` blocks: the next chapter must not be drafted (drafter stage) and this
chapter must not be committed (editor stage) until the orders are executed or
explicitly rejected with reasons in the revision memo.

## Procedure

1. Load the chapter text, its chapter card (goal, function, reveal/payoff obligations),
   the relevant voice cards, and the continuity tracker entries the chapter touches.
2. Score each of the seven dimensions in order. For each, first hunt for the failure:
   - **goal clarity** — can you state, in one sentence, what the focal character wants
     in this chapter and what opposes it? Quote where the text establishes it.
   - **conflict escalation** — quote the chapter's pressure at open and at close; if
     they are the same pressure restated, score ≤ 5.
   - **revelation landing** — for each card-promised reveal, quote the landing beat;
     a reveal delivered in summary or buried mid-paragraph scores low.
   - **character consistency** — check actions/dialogue against voice cards and prior
     chapters; quote any line a character would not say or do.
   - **pacing** — locate the longest stretch with no stake-shift; quote its first line
     and give its word count.
   - **chapter close** — quote the final lines; does the chapter end on live pressure
     or on summary/stillness?
   - **prose quality** — quote the weakest paragraph and the strongest; score against
     the book's binding register, not generic polish.
3. Distrust your own high scores: a 9-10 requires naming what you checked and quoting
   the nearest-miss candidate you considered flagging.
4. Write the per-dimension blocks and chapter verdict in the required format.
5. Convert every dimension ≤ 6 into a revision order and queue it into the current
   revision round. Findings are not advisory.
6. Save the report to the output path. Record the verdict in the worklog so the
   foundation rule is enforceable on the next chapter.
