# Scaffold: Master Spec

artifact: {workspace}/master_spec.md
purpose: the one document that defines the book before drafting begins — the spec is law until consciously changed
created: drafter Phase 1 (premise interpretation), before any drafting
updated: only by conscious decision when the book changes direction; never allowed to drift silently behind the draft
updated_by: orchestrator
source_ref: collation:5724-5758 [Reddit 9 "1. Start with a master spec"]

## How the harness uses this

The source instruction, verbatim:

> Before drafting, make one document that defines the book.

> The important part is that this document becomes law. Not forever, but until you consciously change it. If the book changes direction, update the spec. Don't let the draft quietly wander away from what you meant to write.

> The most useful sections for me were the **narrative voice**, **theme hierarchy**, and **banned phrases/patterns**. Those helped keep the AI from sliding into generic prose.

Every chapter packet includes this spec (or its relevant slices). The drafter treats it as binding; the editor treats divergence from it as a finding unless the spec was consciously revised first (record revisions with date + reason in the change log below).

## Template

All thirteen sections below are the source's own list ("Mine included:"). Fill every one.

```
MASTER SPEC — <project>

## Working title
<placeholder>

## Genre
<placeholder>

## Target length
<placeholder — words; the drafter treats a manuscript substantially below this as a checkpoint, not a book>

## POV and tense
<placeholder — e.g. close third past, first present, rotating focalizers; name them>

## Comparable works
<placeholder — 2-4 comps and what each one is a comp FOR>

## Tone targets
<placeholder — registers the book lives in; what it must never sound like>

## Premise
<placeholder — dynamic premise sentence + story paragraph; see checks/scaffolds/premise_development.md>

## Theme hierarchy
<placeholder — ranked: primary theme, secondary themes; what wins when they conflict>

## Narrative voice
<placeholder — the voice spec: sentence rhythm, diction range, interiority style, narration distance, allowed and forbidden registers>

## Banned phrases or patterns
<placeholder — book-specific bans on top of the harness pattern registry (checks/patterns/); list phrases, constructions, and tics this book must refuse>

## Structural model
<placeholder — the chosen architecture: act model, beat framework if any, chapter map shape>

## Midpoint revelation
<placeholder — what reframes the story at the middle>

## Ending target
<placeholder — the ending direction the book is writing toward; what changes irreversibly>

## Spec change log
| date | section changed | old → new | reason |
|---|---|---|---|
```

## Notes

- The spec is the first item in the staged chapter-draft prompt (see checks/scaffolds/prompt_library.md: "the novel spec" is the first listed ingredient).
- Pacing expectations live in the structural-model and tone-targets sections plus the per-chapter cards (checks/scaffolds/chapter_outline_card.md); world rules live in checks/scaffolds/world_bible.md; the character list lives in the character snapshots (checks/scaffolds/character_snapshot.md). This spec names them; the dedicated artifacts carry the detail.
