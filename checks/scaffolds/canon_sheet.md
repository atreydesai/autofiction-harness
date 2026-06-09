# Scaffold: Canon Sheet

artifact: {workspace}/canon_sheet.md
purpose: a one-page sheet containing only the facts that the novel must stay consistent about — the consistency core, distinct from the research dossier (full sources) and world bible (full setting detail)
created: drafter Phase 1-2, from the research dossier's confirmed constraints
updated: when research resolves a `[verify ...]` placeholder, or a chapter establishes a new fact the book must never contradict
updated_by: orchestrator
source_ref: collation:4961-4973 [Academic manual: Research without drowning in it]

## Source spec (verbatim)

> Build a **research dossier**, not a pile. … Then build a one-page **canon sheet** containing only facts that the novel must stay consistent about. This is especially important in historical, mystery, legal, and speculative fiction, where contradiction destroys reader confidence faster than ornate prose can repair it.

And the bracketed-placeholder convention:

> The main pitfall is **research as displacement activity**. If you have enough knowledge to write the first ten scenes honestly, begin. Use bracketed placeholders such as `[verify train departure times]`, `[police chain-of-command here]`, or `[flora species for marsh grasses]`. This preserves forward motion while keeping factual obligations visible.

## Template (keep to one page)

```
CANON SHEET — <project>

## Hard facts (the novel must never contradict these)
| # | fact | domain (chronology / procedure / law / geography / medicine / technology / world rule / character) | source (dossier entry) | scenes/chapters bound by it |
|---|---|---|---|---|
| 1 | <placeholder> | <placeholder> | <D-NN> | <placeholder> |

## Open factual obligations ([verify ...] placeholders still in the manuscript)
| placeholder (exact bracketed text) | chapter(s) | what would resolve it | blocking by (chapter/phase) |
|---|---|---|---|
| [verify <placeholder>] | <NN> | <placeholder> | <NN> |
```

## The `[verify ...]` convention (harness rule)

- While drafting, never stall on a checkable fact: write the scene and drop `[verify ...]` with a specific question, in the source's style (`[verify train departure times]`, `[police chain-of-command here]`, `[flora species for marsh grasses]`).
- Every placeholder must be registered in the table above at chapter commit; the mechanical quality gate treats unregistered bracketed placeholders in a final-assembly candidate as blocking hits.
- Resolving a placeholder = research dossier entry + (if the fact is consistency-critical) a hard-facts row + removing the bracket from the prose.

## Mini-example rows

```
| 1 | the inquest verdict is recorded on 14 March, two days after the death | chronology | D-03 | ch 2, 9, 17 |
| [verify train departure times] | ch 5 | period timetable for the northern line | end of Act I revision |
```
