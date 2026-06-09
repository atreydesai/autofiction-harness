# Audit: Immediate Continuity Check (post-draft)

id: continuity_check_immediate | owner: codex | tier: core
trigger: every-chapter
output: {audit_root}/codex/chapter_{NN}.continuity_check.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:5933-5949 [Reddit 9: run continuity checks immediately] + collation:5892-5929 [continuity log categories] + legacy tracker reconciliation

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Source, verbatim (Reddit 9, item 8):

> 8. Run continuity checks immediately
> After drafting, I asked the AI to compare the chapter against the continuity log, character bible, and world bible.
> The output I wanted was simple:
> - contradictions found
> - new facts introduced
> - new promises or compacts
> - continuity log additions
> Then I pasted those additions into the continuity log.
> Do not wait until later. You will forget. The AI will forget. The book will not forgive you.

Continuity log categories, verbatim (Reddit 9, item 5) — the chapter is checked against, and its additions filed under, exactly these:

> - facts introduced
> - character state changes
> - object locations
> - injuries
> - deaths
> - promises made
> - unresolved mysteries
> - planted seeds
> - payoff targets

And the failure modes the log exists to prevent, verbatim:

> - a character having an injury in one chapter and forgetting it in the next
> - an object appearing in two places
> - a promise being made and never paid off
> - a mystery being raised and accidentally abandoned
> - a seed planted in Act I disappearing before Act III

Cross-check dimensions (every chapter, immediately after drafting): **names** (spellings, titles, relationships), **timeline** (chapter's internal time vs {timeline} and the previous chapter's end-state), **knowledge state** (who knows what — no character may act on information they have not on-page acquired), **object state** (locations, possession, condition), **injuries** (and other body/health clocks). Each chapter fact is verified against continuity.md and canon_sheet.md.

## Required verdict format

Per dimension, one line:
`NAMES | TIMELINE | KNOWLEDGE | OBJECTS | INJURIES: CLEAN|CONTRADICTION — chapter: "<quote>" vs tracker/canon: "<quote>" — fix target: CHAPTER|TRACKER`

A CLEAN line must list the specific items checked (e.g., "checked: Marek's limp ch12, the brass key last seen ch09, who knows about the forgery") and quote the closest near-miss considered. Bare CLEAN = FAILED audit.

Then four sections matching the source's required output:
1. **Contradictions found** — each with both quotes and a ruling: which side is canon, and the exact revision order (chapter line to change, or tracker entry to correct).
2. **New facts introduced** — every fact the chapter establishes for the first time, sorted into the nine log categories above.
3. **New promises or compacts** — explicit and implied obligations between characters.
4. **Continuity log additions** — the ready-to-paste block for continuity.md, in the nine-category structure.

Verdict: **CLEAN** / **CONTRADICTIONS (N)**. Per source timing rule — "Do not wait until later" — any CONTRADICTION is ACTIONABLE-IMMEDIATE: the chapter or the tracker is revised NOW, before the next chapter drafts. Deferral is not an available disposition.

## Procedure (owner=codex)
1. Read the just-drafted chapter, continuity.md, canon_sheet.md, {timeline}, and the previous chapter's closing state.
2. Extract every checkable fact from the chapter (names, times, knowledge transfers, object handlings, injuries/deaths, promises, mysteries, seeds) before comparing — extraction first prevents agreement bias.
3. Verify each fact against the trackers; quote both sides for every mismatch; rule which side is canon using canon_sheet.md precedence.
4. Emit the verdict block and the four output sections; write the report to the output path.
5. Apply the continuity-log additions to continuity.md in the same run. If verdict is CONTRADICTIONS, halt the pipeline's next-chapter draft until the named fixes land in chapter or tracker.
