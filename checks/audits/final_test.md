# Audit: The Final Test (protocol 3.7 gate)

id: final_test | owner: codex | tier: book
trigger: phase:final-assembly
output: {audit_root}/codex/book.final_test.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:7115-7122 [BANNED 3.7]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The source entry, verbatim:

> ## **3.7 THE FINAL TEST**
>
> Before any piece is complete, run these checks:

The collation entry preserves the header and gate instruction; the guide's component
checks appear in the collation as separate entries, transcribed verbatim:

**Specificity Test**

> * Could any line appear unchanged in a different story with different characters?
> * If yes, it's not specific enough. Rewrite.

**Interchangeability Test**

> * Could this physical tell / metaphor / ending belong to any character?
> * If yes, it's not character-specific. Rewrite.

**Earned Test**

> * Has this emotional beat been built to, or am I announcing it?
> * If announced, either build the foundation or scale down.

**Consequence Test**

> * Does something change because of this scene / beat / line?
> * If nothing changes, the scene isn't done.

Per-chapter versions of these tests run earlier in the pipeline (specificity_test,
interchangeability_test, earned_test, consequence_test audits). THIS audit is the
final-assembly gate: the same four checks run once more, book-wide, on the assembled
candidate — because revision rounds reintroduce the failures the per-chapter passes
removed, and "before any piece is complete" means the assembled book, not its parts.

## Required verdict format

Per test, a section with sampled-item verdict lines:

```
SPECIFICITY: "<line>" (<location>) — PASS (anchor: <book-specific element>) |
  FAIL (fits: <alternate story it survives in>)
INTERCHANGEABILITY: "<tell/metaphor/ending>" (<location>, <character>) — PASS (why only
  this character) | FAIL (any-character)
EARNED: <emotional beat> (<location>) — BUILT-TO (setup quoted from Ch <NN>) |
  ANNOUNCED
CONSEQUENCE: <scene/beat> (<location>) — CHANGES (<what changed>) | NOTHING-CHANGES
```

Gate verdict:

- `COMPLETE` — zero FAIL / ANNOUNCED / NOTHING-CHANGES across all sampled items. Per
  test, still quote the nearest-miss candidate considered and why it passed.
- `NOT-COMPLETE` — any failure. Each converts to a revision order per the source: FAIL
  specificity → `REWRITE <location> with <book-specific anchor>`; FAIL
  interchangeability → `REWRITE <location> character-specific to <character>`; ANNOUNCED
  → `BUILD FOUNDATION at <earlier location> or SCALE DOWN <beat>`; NOTHING-CHANGES →
  `the scene isn't done: ADD consequence at <location> or CUT`.

`NOT-COMPLETE` blocks final assembly. The piece is not complete until the orders are
executed and the failed samples re-tested.

## Procedure

1. Run on the assembled final candidate only (after all revision rounds, before
   `final/novel.md` is declared).
2. Sample book-wide, biased toward what revision churns most: every chapter's opening
   and closing lines, every emotional peak named in the chapter cards or reading
   guide, every set-piece scene, all figuration added in the last revision round, and
   the final pages in full.
3. Apply the four tests to every sampled item. For Specificity/Interchangeability
   failures you must articulate the alternate story or alternate character — if you
   cannot, the item passes; no vibe-based failures, no vibe-based passes.
4. For the Earned Test, trace each peak back to its setup and quote it; an unquotable
   setup is ANNOUNCED.
5. Write verdicts in the required format; emit revision orders; re-run on revised
   samples until `COMPLETE` or each residual failure is explicitly rejected with
   reasons in the residual-risks file.
6. Save the report to the output path.
