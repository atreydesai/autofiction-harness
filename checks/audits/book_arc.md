# Audit: Book-Level Intensity Arc Audit

id: book_arc | owner: codex | tier: book
trigger: phase:whole-book
output: {audit_root}/codex/book.arc.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: legacy-pipeline editor Book-Level Comedy/Derangement Arc Audit, genericized (register named by reading guide)

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The book's declared register ({reading_guide_register} — whatever intensity dimension
the reading guide names as the book's signature: comic escalation, dread, derangement,
romantic pressure, horror, conspiracy density, etc.) is plotted as an intensity curve
across ALL chapters. The audit asks:

- Does the intensity build from chapter 1 to the final chapter, or plateau?
- Where are the peaks and valleys?
- Are valleys **intentional** (tonal contrast, breath chapters, care beats the reading
  guide sanctions) or **accidental** (chapters that simply forgot the register)?
- Does the intensity escalate as the book's major-event arc approaches?

**Post-climax arc-trajectory check (separate from the pre-climax build).** For books
whose structural climax sits in the front half or middle of the manuscript, explicitly
check whether the post-climax chapters CLIMB the dramatic gradient or hold flat. The
post-climax section must not be a deflation — it should be the book's engine doing
more, at increasing scale, not aftermath-as-wind-down. Specifically:

- Compare each post-climax peak (per the reading guide's high-leverage-scenes list)
  against the climax itself: do they land harder than the climax?
- Compare the chapters BETWEEN post-climax peaks: are they escalation or observation?

## Required verdict format

Intensity table, all chapters:

```
Ch <NN> — intensity <1-10 on {reading_guide_register}> — evidence: "<the chapter's
  peak register moment, quoted>" — valley? <intentional (sanctioned purpose) |
  accidental>
```

Curve summary: peaks (chapters), valleys (chapters, intentional/accidental),
escalation toward the major-event arc (evidence), climax position (chapter, % mark).

Post-climax check (if climax at or before the midpoint-to-60% region):

```
post-climax peak <chapter> vs climax: HARDER | SOFTER — evidence both sides, quoted
between-peak chapters: ESCALATION | OBSERVATION — per chapter, one line
```

Book verdict (one of four):

- `ARC-BUILDS` — intensity builds to the final movement; every valley named and
  intentional. Evidence still required: quote the curve's three highest beats in
  order and show they ascend.
- `ARC-FLAT` — plateau; list the chapters to amplify, each with a revision order
  naming what register moves the chapter has room for.
- `ARC-INVERTED` — peaks early, declines; structural finding — escalate to the
  surgery plan (reorder / replace / rebuild), not just amplification.
- `POST-CLIMAX-DEFLATION` — the climax lands, then the arc holds flat or declines;
  post-climax chapters need amplification, replacement, or new chapter additions.
  Cross-reference any author-direction / reader-impression entries about post-climax
  pacing if present.

## Procedure

1. Extract {reading_guide_register} and the high-leverage-scenes list from the reading
   guide. If the guide names no register dimension, derive it from the premise's
   signature pleasure and record the derivation in the report header.
2. Score every chapter 1-10 on that dimension, quoting each chapter's peak register
   moment as evidence. Score from the text, not from chapter cards.
3. Plot the curve; mark climax position as a % of the manuscript.
4. Classify every valley: intentional requires citing the sanctioned purpose (reading
   guide care move, contrast beat, breath chapter named in the architecture);
   anything else is accidental and becomes a finding.
5. If the climax falls in the front half or middle, run the post-climax check in full.
6. Write the verdict; convert ARC-FLAT / ARC-INVERTED / POST-CLIMAX-DEFLATION findings
   into per-chapter amplification orders or surgery proposals and queue them.
7. Save the report to the output path.
