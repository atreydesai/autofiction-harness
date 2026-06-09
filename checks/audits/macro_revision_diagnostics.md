# Audit: Macro-Revision Diagnostics

id: macro_revision_diagnostics | owner: codex | tier: book
trigger: phase:full-book-critique
output: {audit_root}/codex/book.macro_revision.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:7188-7200 [Academic manual macro revision]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The source criteria (Academic novel manual, "Macro revision"), verbatim-faithful:

- **Do not line-edit a structurally unsound novel.** Experienced writers revise
  globally — structure, proportion, idea hierarchy — not by swapping local wording.
  Macro revision asks whether the novel's promises, causality, escalation, character
  arcs, thematic tensions, and information release actually work.
- Begin with a **cold reader's pass**: read the entire draft quickly, notes on separate
  paper only. Log where attention drifts, where you become confused, where you feel
  ahead of the book, where scenes repeat the same emotional value, where exposition
  lands too early, where motives are thin, and where the novel's energy falsely spikes
  then stalls. Diagnose the text's actual behavior; do not fix as you go.
- Then produce **four diagnostic tools**:
  1. A **reverse outline** — lists every scene and what changes in it.
  2. A **promise/payoff map** — tracks planted questions, objects, clues, and emotional
     expectations to make sure they are either fulfilled or intentionally frustrated.
  3. A **character-arc audit** — checks whether important turns are prepared by prior
     value conflict rather than imposed late for convenience.
  4. A **pacing map** — marks scene, summary, exposition, reflection, and transit
     passages so you can see whether the book clusters too much narrative time in the
     wrong places.
- The main structural operations are **fewer and larger** than expected. **Five major
  revision operations**: **delete** a beloved chapter that delays the real beginning;
  **move** a revelation earlier because the book is starving; **collapse** two minor
  antagonists into one stronger force; **redistribute** exposition so the reader learns
  facts at the moment they become dramatically legible; **rebuild** the midpoint
  because the second half currently lacks a redefined objective. Major revision often
  feels like destroying the book; it is usually how the book becomes itself.

## Required verdict format

The report must contain all four diagnostic artifacts, each with quoted evidence:

```
COLD-READ LOG: per finding — <chapter/location>: <drift | confusion | ahead-of-book |
  repeated emotional value | early exposition | thin motive | false spike> — "<quote>"
REVERSE OUTLINE: per scene — <Ch.scene>: <what changes> (or NO-CHANGE)
PROMISE/PAYOFF MAP: per planted item — <item> — planted Ch <NN> "<quote>" —
  FULFILLED Ch <NN> | INTENTIONALLY-FRUSTRATED (evidence of intent) | DROPPED
CHARACTER-ARC AUDIT: per major character turn — <turn> Ch <NN> —
  PREPARED (prior value conflict quoted) | IMPOSED-FOR-CONVENIENCE
PACING MAP: per chapter — % scene / summary / exposition / reflection / transit —
  flag clusters of narrative time in the wrong places
```

Book verdict:

- `STRUCTURALLY-SOUND` — no DROPPED promises, no IMPOSED turns, no NO-CHANGE scenes,
  no pathological pacing clusters. Evidence still required per artifact.
- `MACRO-REVISION-REQUIRED` — otherwise. Findings convert into operations drawn from
  the five: `DELETE <chapter> | MOVE <revelation> to <position> | COLLAPSE <elements> |
  REDISTRIBUTE <exposition> to <moment of dramatic legibility> | REBUILD <midpoint/
  section>: <redefined objective>` — each with the evidence line that justifies it.

`MACRO-REVISION-REQUIRED` blocks line-editing: no line-level polish passes run on the
affected chapters until the operations are executed or explicitly rejected with reasons.

## Procedure

1. Run the cold reader's pass on the full manuscript first, fast, notes separate from
   the text. Log behavior, not fixes.
2. Build the four artifacts in order (reverse outline may be imported from the
   reverse_outline audit if current; verify rather than trust).
3. For each artifact, hunt the failure case before crediting the pass case.
4. Map every finding to one of the five operations; if a finding maps to none, it is a
   scene-level note — hand it to the scene-revision queue, not this report.
5. Write the verdict; queue operations as structural-surgery proposals with evidence.
6. Save the report to the output path.
