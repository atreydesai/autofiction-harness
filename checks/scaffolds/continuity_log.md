# Scaffold: Continuity Log

artifact: {workspace}/continuity_log.md
purpose: the most important file — the book's external memory; the model does not have reliable long-term memory, the continuity log becomes the memory
created: from the beginning — before chapter 1 commits
updated: immediately after every chapter draft ("Do not wait until later. You will forget. The AI will forget. The book will not forgive you.")
updated_by: orchestrator, by pasting the continuity check's additions in at every chapter commit
source_ref: collation:5892-5929 [Reddit 9 "5. Maintain a continuity log from the beginning"] + collation:5933-5949 [Reddit 9 "8. Run continuity checks immediately"]

## Source spec (verbatim)

> This was probably the most important file.
> After each chapter, I updated a continuity log with:
>
> - facts introduced
> - character state changes
> - object locations
> - injuries
> - deaths
> - promises made
> - unresolved mysteries
> - planted seeds
> - payoff targets
>
> This sounds tedious, but it saved the book more than once.
> The continuity log is where you prevent things like:
>
> - a character having an injury in one chapter and forgetting it in the next
> - an object appearing in two places
> - a promise being made and never paid off
> - a mystery being raised and accidentally abandoned
> - a seed planted in Act I disappearing before Act III
>
> The AI does not have reliable long-term memory. The continuity log becomes the memory.

## Update cadence (verbatim)

> 8. Run continuity checks immediately
> After drafting, I asked the AI to compare the chapter against the continuity log, character bible, and world bible.
> The output I wanted was simple:
>
> - contradictions found
> - new facts introduced
> - new promises or compacts
> - continuity log additions
>
> Then I pasted those additions into the continuity log.
> Do not wait until later. You will forget. The AI will forget. The book will not forgive you.

In this harness that check is the continuity_check_immediate audit (every chapter, blocking before commit). Contradictions found must be repaired before the chapter commits; the additions block below is then appended verbatim.

## Template (append one block per chapter, in order)

```
### Chapter <NN> (committed <date>)

- facts introduced: <placeholder — includes timeline facts and world facts established on the page>
- character state changes: <placeholder — includes character details fixed here: names, ages, appearance, relationships>
- object locations: <placeholder — object state: where each plot-bearing object now is, and its condition>
- injuries: <placeholder — new wounds + healing state of old ones>
- deaths: <placeholder>
- promises made: <placeholder — promises, vows, compacts; by whom, to whom>
- unresolved mysteries: <placeholder — raised or deepened here; cross-ref thread ledger>
- planted seeds: <placeholder — cross-ref thread ledger seed ids>
- payoff targets: <placeholder — obligations created or discharged; cross-ref thread ledger>
- knowledge state: <placeholder — who learned what this chapter; who still must not know>
```

## Mini-example block

```
### Chapter 07 (committed Day 3 of run)

- facts introduced: the ferry runs only on tide days; Hale's shop has a back exit to the canal
- character state changes: Sera now owes the magistrate a favor; Yune has left the city
- object locations: the stolen ledger — last seen in Hale's strongbox (moved from the abbey)
- injuries: Sera's burned left hand, freshly bandaged (limits her grip through ~ch 10)
- deaths: none
- promises made: Sera to Yune: "I won't leave you to debt"
- unresolved mysteries: who paid Hale to hold the ledger (deepened, not answered)
- planted seeds: S04 — the abbey bell heard underwater
- payoff targets: ledger must surface by end of Act II (obligation open)
- knowledge state: Sera now knows the ledger moved; the magistrate does not
```
