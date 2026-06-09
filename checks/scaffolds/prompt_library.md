# Scaffold: Prompt Library

artifact: {workspace}/prompt_library.md
purpose: the project's reusable prompt templates — prompts as stages, not one giant "write my chapter" request; chapter packets reference these templates instead of improvising prompts per chapter
created: drafter Phase 1 (instantiated from this scaffold); templates filled as the project's artifacts come online
updated: whenever a prompt template is improved mid-run; improvements are recorded here so later chapters benefit
updated_by: orchestrator
source_ref: collation:5762-5808 [Reddit 9 "6. Use prompts as stages"] + collation:5686-5717 [Novel process: Drafting Systems and Project Management] + collation:5812-5848 [Reddit 9 "12. Remember the human job" — file structure]

## The staged workflow (Reddit 9, verbatim — all 10 steps)

> My process for each chapter looked like this:
>
> 1.  Read the chapter outline.
> 2.  Pull the relevant character entries.
> 3.  Pull the relevant world details.
> 4.  Pull recent continuity notes.
> 5.  Run a chapter draft prompt.
> 6.  Run a beat check.
> 7.  Run a continuity check.
> 8.  Run a voice check when needed.
> 9.  Write a short chapter summary.
> 10. Update the continuity log.

And the chapter draft prompt's required ingredients (verbatim):

> The chapter draft prompt was not just "write chapter 12."
> It included:
>
> - the novel spec
> - relevant character profiles
> - relevant world bible sections
> - recent continuity entries
> - the chapter goal/conflict/revelation
> - previous chapter summary
> - drafting constraints
> - banned phrases
> - POV and tense instructions
>
> That gave the AI enough context to be useful without pretending it understood the whole novel on its own.

## Prompt templates to maintain (one section each)

```
## chapter_draft_prompt
ingredients (assemble in this order; pull slices, not whole files):
1. master spec (checks/scaffolds/master_spec.md instance)
2. character snapshots/voice cards for this chapter's speakers
3. relevant world bible sections + canon sheet hard facts in play
4. recent continuity log entries + rolling memory packet
5. the chapter card (goal/conflict/revelation + full card + flags)
6. previous chapter summary
7. drafting constraints (length, scene list, protected threads from the thread ledger)
8. banned phrases (book-specific bans + pattern registry pointers)
9. POV and tense instructions
prompt text: <placeholder>

## beat_check_prompt
checks the draft against the chapter card's beats: goal, conflict, revelation,
close, irreversible change, felt experience. prompt text: <placeholder>

## continuity_check_prompt
compares the draft against the continuity log, character bible, and world bible;
returns contradictions found / new facts introduced / new promises or compacts /
continuity log additions. prompt text: <placeholder>

## voice_check_prompt
run when needed (and on the every-5-chapters cadence); checks rhythm, banned
phrases, per-character voice against the snapshots. prompt text: <placeholder>

## chapter_summary_prompt
produces the ~120-word chapter summary in the rolling_summary format.
prompt text: <placeholder>

## meanwhile_prompt
offscreen world motion between chapters (see meanwhile_audit). prompt text: <placeholder>

## ripple_audit_prompt
after major revisions: audit every downstream consequence. prompt text: <placeholder>
```

Each template records: when it runs, which artifacts it consumes, what output format it must return, and the current prompt text. When a prompt misfires, fix the template here — not just the one-off call.

## The four drafting artifacts (Novel process, verbatim)

> A robust drafting workflow usually includes four artifacts:

| Artifact | Why it matters | Harness home |
|---|---|---|
| Premise sheet | Keeps the book's central engine visible | premise_development.md + master spec |
| Character sheets | Prevent goal/conflict/arc drift | character snapshots |
| Scene list | Lets you see causality, POV balance, and dead zones | chapter outline cards |
| Reverse outline | Diagnoses what the manuscript actually became | reverse_outline audit output |

> Discovery writers in particular should reverse-outline after 20–30 percent, 50 percent, and draft completion. That converts intuition into data before revision becomes expensive.

## File structure (Reddit 9, verbatim)

> My reusable file structure would look like this:
>
>     novel-project/
>     ├── NOVEL_SPEC.md
>     ├── OUTLINE.md
>     ├── CHARACTER_BIBLE.md
>     ├── WORLD_BIBLE.md
>     ├── CONTINUITY_LOG.md
>     ├── PROMPT_LIBRARY.md
>     ├── chapters/
>     └── summaries/
>
> And the basic chapter workflow:
> Outline → Draft → Beat Check → Continuity Check → Voice Check → Summary → Log Update
>
> The biggest takeaway:
> **Do not use AI as a magic box. Use it as a collaborator inside a system.**
> The system is what keeps the book yours.

Harness mapping: NOVEL_SPEC → master_spec.md; OUTLINE → outline/chapter_cards.md; CHARACTER_BIBLE → characters/; WORLD_BIBLE → world_bible.md; CONTINUITY_LOG → continuity_log.md; PROMPT_LIBRARY → this file; chapters/ → chapters/; summaries/ → summaries/.

## The human job (judgment stays above the library)

The source's reminder: the system "did not replace judgment" — deciding what matters emotionally, what should be cut, when the model is being too neat, when the prose sounds false, when a scene technically works but has no pulse, when to ignore the model's suggestion. In this harness those decisions belong to the orchestrator's synthesis and the adversarial audits, never to a prompt template alone.
