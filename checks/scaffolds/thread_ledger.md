# Scaffold: Thread Ledger

artifact: {workspace}/thread_ledger.md
purpose: the to-do list for what should stay messy — seeds planted, payoffs owed, threads protected from premature resolution, complications opened; the model ties everything up unless told explicitly what must remain open
created: drafter Phase 2 (seed with outline-level obligations); rows added from chapter 1 onward
updated: per chapter commit (continuity check output feeds it); payoff statuses reviewed every 5 chapters by the seed_payoff audit
updated_by: orchestrator
source_ref: collation:4399-4478 [Reddit 5 Fixes 1-3 + Putting It Together] + collation:4903-4920 [Reddit 5 Fix 5: Plant Seeds, Don't Deliver Payoffs]

## Source principles (verbatim)

Fix 1 — protected threads:

> Before a scene or session, explicitly tell the AI which conflicts should remain unresolved:
> - "The tension between Mira and Kael is NOT resolved in this scene. They're still circling around the issue."
> - "The mystery of the missing letters should deepen, not get answered."
> - "This scene is about suspicion growing, not confrontation happening."
>
> If you don't tell AI to leave threads open, it will tie them all up.
> Think of it like a to-do list for what should stay messy.

Fix 2 — complicate, don't resolve:

> Every scene should either make things *worse* or make them *different*. Not better. Not resolved. Worse or different.
> The question isn't "how does this get fixed?" It's "how does this get more complicated?"

Fix 5 — seeds:

> A seed is a detail that means nothing now but will mean everything later.
> Then, chapters later, when you want that payoff, remind the AI of the seed:
> - "Remember the broken clock in the tower from the first chapter? It matters now."

## Template

### 1. Seeds planted

| seed id | chapter planted | detail (quote or close paraphrase) | intended payoff | payoff target chapter | status (dormant / refreshed ch NN / paid off ch NN / dead) |
|---|---|---|---|---|---|
| S01 | <NN> | <placeholder> | <placeholder> | <NN> | dormant |

### 2. Payoff obligations

Every promise the book has made the reader — reveals, returns, reckonings, planted seeds coming due.

| obligation | created by (chapter/seed id) | due by (chapter/act) | setup still alive? | status (open / approaching / PAID ch NN / MISSED) |
|---|---|---|---|---|
| <placeholder> | <NN / S01> | <NN> | yes/no | open |

### 3. Unresolved threads (with protection flags)

| thread | opened ch | current state | PROTECTED until | protection instruction (copy into chapter packets, in the source's style: "X is NOT resolved in this scene…") | earliest allowed resolution |
|---|---|---|---|---|---|
| <placeholder> | <NN> | <placeholder> | <ch/act/event> | <placeholder> | <NN> |

A thread marked PROTECTED may deepen, complicate, or change shape in a chapter, but may not resolve. Resolving a PROTECTED thread is a blocking audit finding, not a judgment call.

### 4. Complications opened

Per Fix 2 and the yes-but/no-and framework: each attempted fix should partially work but create a new issue; success comes with a cost or a catch.

| complication | opened ch | arose from (thread/event/attempted fix) | worse or different? | feeds which thread next |
|---|---|---|---|---|
| <placeholder> | <NN> | <placeholder> | <worse / different> | <placeholder> |

## Mini-example rows

```
| S01 | 01 | the broken clock in the tower | it was stopped deliberately the night of the theft | 18 | dormant |
| Mira–Kael tension | 03 | still circling the issue | PROTECTED until ch 21 (midpoint fallout) | "The tension between Mira and Kael is NOT resolved in this scene. They're still circling around the issue." | 21 |
```

## Cross-references (audits that consume this ledger)

- **unresolved_threads** (every chapter): verifies no PROTECTED thread resolved; verifies the chapter packet carried the protection instructions.
- **seed_payoff** (every 5 chapters): reconciles the manuscript window against sections 1-2 — new seeds planted, approaching payoffs still set up, no payoff fired without a planted seed.
- complicate_dont_resolve and yes_but_no_and audits read section 4; the continuity log (checks/scaffolds/continuity_log.md) mirrors planted seeds and payoff targets at the fact level.
