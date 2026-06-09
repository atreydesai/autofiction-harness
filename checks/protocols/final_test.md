# Protocol: The Final Test (3.7)

purpose: the completion gate — no piece is declared complete until these checks have been run on it
runs: at final assembly, on the assembled candidate manuscript, after all revision rounds and before final/novel.md is declared; executed as the audit checks/audits/final_test.md, which references this protocol text
source_ref: collation:7115-7122 [BANNED 3.7 THE FINAL TEST]; component tests transcribed verbatim from their collation entries (Specificity Test 4350-4357, Interchangeability Test 4361-4368, Earned Test 4372-4379, Consequence Test 4655-4662)

## The gate text, verbatim

> ## **3.7 THE FINAL TEST**
>
> Before any piece is complete, run these checks:

## The component checks, verbatim

The guide's component tests appear in the collation as separate entries:

> ### **Specificity Test**
>
> * Could any line appear unchanged in a different story with different characters?
> * If yes, it's not specific enough. Rewrite.

> ### **Interchangeability Test**
>
> * Could this physical tell / metaphor / ending belong to any character?
> * If yes, it's not character-specific. Rewrite.

> ### **Earned Test**
>
> * Has this emotional beat been built to, or am I announcing it?
> * If announced, either build the foundation or scale down.

> ### **Consequence Test**
>
> * Does something change because of this scene / beat / line?
> * If nothing changes, the scene isn't done.

## How the harness uses this

Per-chapter versions of these tests run earlier in the pipeline (specificity_test, interchangeability_test, earned_test, consequence_test audits). THIS protocol is the final-assembly gate: the same checks run once more, book-wide, on the assembled candidate — because revision rounds reintroduce the failures the per-chapter passes removed, and "before any piece is complete" means the assembled book, not its parts. The executable procedure, sampling plan, verdict format, and blocking semantics (`COMPLETE` / `NOT-COMPLETE`) are specified in checks/audits/final_test.md. A `NOT-COMPLETE` verdict blocks final assembly until its revision orders are executed and the failed samples re-tested.
