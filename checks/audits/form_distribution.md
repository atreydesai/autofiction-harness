# Audit: Form-Distribution Audit (vs reading-guide targets)

id: form_distribution | owner: codex | tier: book
trigger: phase:whole-book
output: {audit_root}/codex/book.form_distribution.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: legacy-pipeline editor Form-Distribution Audit, genericized

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Books whose reading guide binds a form mix (e.g., X% transcript/exchange material, Y%
close-third narration, Z% documentary inserts, W% narrator interludes — using whatever
form vocabulary the guide establishes) drift toward the model's comfortable default
form over a long run. This audit measures the manuscript's ACTUAL form distribution
and compares it against:

1. **{reading_guide_form_targets}** — the binding percentages, with whatever tolerance
   the guide states (default tolerance if unstated: ±5 percentage points per form).
2. **The Phase-1 / draft baseline, if present** — the form-distribution snapshot taken
   of the original draft before revision began. Comparing against the baseline
   separates upstream drift (the draft already missed the targets) from revision drift
   (revision moved the mix). Revision that silently converts bound forms into default
   narration is sanitization-shaped drift even when every individual edit looked
   justified.

If the reading guide declares no form targets, this audit records the measured
distribution as a baseline artifact and returns `NO-TARGETS-DECLARED` — it does not
invent targets.

## Required verdict format

```
MEASURED: per form — <form>: <word count> (<percent>%)
TARGETS:  per form — <form>: <target>% (tolerance ±<N>)
BASELINE: per form — <form>: <baseline>% (or "no baseline artifact")
DELTA:    per form — vs target: <+/-pp>; vs baseline: <+/-pp>
DRIVERS:  per out-of-tolerance form — the chapters contributing most to the deviation,
          each with word counts and one quoted example of the misclassified or
          drifted material
```

Book verdict:

- `ON-TARGET` — every form within tolerance of the guide's targets. Show your work:
  report the per-form deltas anyway, name the form closest to its tolerance edge, and
  state the classification rules used.
- `FORM-DRIFT` — any form out of tolerance. Per out-of-tolerance form, revision
  orders that name chapters: `REBALANCE Ch <NN>: convert <passage> back to <form>` /
  `ADD <form> material at <structural gap>` / `CUT excess <form> at <location>` — and
  a direction note: whether the drift is upstream (present in baseline) or introduced
  by revision (baseline was on-target).

Form-drift findings route to the structural plan when the fix is chapter-level
(add/cut/convert chapters) and to per-chapter revision when the fix is passage-level.

## Procedure

1. Extract {reading_guide_form_targets} and the guide's form vocabulary. Write down
   the classification rule you will apply for each form (what counts as exchange
   material vs narration vs documentary insert vs interlude) BEFORE measuring, so the
   measurement cannot be fitted to the verdict.
2. Classify every section of every chapter by form and count words mechanically
   (script-assisted where possible; spot-check 10% of classifications by hand and
   report the spot-check error rate).
3. Load the Phase-1/draft baseline artifact if present; recompute it with the same
   classification rules if its method is undocumented.
4. Compute deltas vs targets and vs baseline; identify driver chapters for every
   out-of-tolerance form.
5. Write the verdict in the required format; queue rebalance orders.
6. Save the report to the output path, including the raw per-chapter form table as an
   appendix so the next run can diff against it.
