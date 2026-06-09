# Protocol: Core Workflow

purpose: the writing ruleset's top-level process loop, mapped onto the harness phases so every stage knows which step it is executing
runs: framing for the whole pipeline; each harness phase re-reads its mapped step before starting work
source_ref: collation:5984-5996 [Core workflow]

## The workflow, verbatim

> ## Core workflow
>
> 1. Identify the medium, audience, reader need, and job of the text.
> 2. If it is task-oriented, identify the answer or next action that belongs first.
> 3. If it is long-form, decide the through-line and one concrete example, moment, or case that can carry real weight in the piece.
> 4. Draft to fit that context, not an abstract idea of "good writing."
> 5. Run the required checks for the length and stakes of the piece.
> 6. Cut what sounds generic, ceremonial, over-engineered, suspiciously over-specific, or too cleanly modular.

## Harness mapping

| Step | Harness phase | What it means here |
|---|---|---|
| 1 | Premise / planning phase | The premise, reading guide, and calibration artifact define the medium (long-form fiction), the audience, the reader need, and the job of the book. Every later phase inherits this; no stage substitutes a generic idea of "good prose." |
| 2 | Planning phase (conditionally) | A novel is not task-oriented, so this step mostly does not fire. It does apply to harness-internal artifacts (cards, briefs, reports): put the answer or next action first in those. |
| 3 | Outline / chapter-card phase | The book-level through-line and each chapter's load-bearing concrete moment are decided on the cards before drafting. A card without its concrete example, moment, or case is incomplete. |
| 4 | Drafting phase | The drafter writes to the cards and the calibration artifact — the established context — with the pre-draft protocol (checks/protocols/pre_draft.md) confirmed and the mid-draft flagging protocol (checks/protocols/mid_draft_flagging.md) live. |
| 5 | Check phase | After each draft: the post-draft revision sweep (checks/protocols/post_draft_revision.md), then checks/quality_gate.py, then the required checks (checks/protocols/required_checks.md) at the length-appropriate tier, then the scheduled judgment audits. |
| 6 | Revision / editing phase | The cut-and-tighten pass under checks/protocols/revision_discipline.md, sequenced macro-before-line per checks/protocols/editing_stages.md, ending in the final-assembly gate (checks/protocols/final_test.md). |

The loop is recursive, not linear: a step-5 or step-6 failure on a chapter sends that chapter back to step 3 (fix the card) or step 4 (redraft), not forward with notes.
