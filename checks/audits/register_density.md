# Audit: Calibration Register-Density Audit (calibration-gated)

id: register_density | owner: codex | tier: risk
trigger: calibration:density-baselines-present
output: {audit_root}/codex/chapter_{NN}.register_density.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: verve-legacy editor, genericized

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

**Calibration gate: this audit runs ONLY when the calibration artifact provides
binding density samples and marker definitions.** If the calibration declares no
density baselines, this audit does not run; do not invent markers.

Amplification-not-defense posture for the book's signature prose register (typically
the narrator form, or whatever form the calibration binds baselines to). Where the
chaos_up audit sharpens individual moves, this audit measures AGGREGATE counts: the
book's register is partly a matter of density, and density erodes silently across a
long draft even when individual lines pass.

The density markers and their baselines come ENTIRELY from
{calibration_density_markers}. Each marker entry supplies: a marker definition (what
counts as one instance), a unit (e.g., "instances per 1k words of the bound form"),
and a baseline measured from a named calibration sample (e.g., "marker X per 1k words,
baseline from calibration sample S"). Typical marker families a calibration may
define — counted only if the calibration defines them: signature assertion types per
1k words; signature threat/edge moves; signature crude or heightened images; anaphoric
or repetition patterns; terminal punch constructions; concrete-specificity counts
(named sums, named places, named artifacts) versus abstraction substitutes.

For each chapter containing the bound form (above the calibration's minimum word
threshold for that form), count every defined marker, normalize per unit, and compare
to baseline. Substantially below baseline (the calibration's threshold; default <50%
of expected) flags the marker for expansion — with specific restorable material drawn
from the calibration's own inventory, not invented content.

**One-directional**: the audit can RAISE density toward baseline, never lower it. A
chapter at or above baseline on a marker is AT-PEAK for that marker, with the counts
shown. The audit returns concrete additions with proposed text, not generic "increase
density" notes.

## Required verdict format

Header: form word count audited, sample baseline source named per marker.

Per marker in {calibration_density_markers}:

- `AT-PEAK — <marker> — measured <n>/unit vs baseline <b>/unit — counted instances quoted or line-cited`
- `BELOW-BASELINE — <marker> — measured <n>/unit vs baseline <b>/unit — PROPOSALS: <2+ concrete insertions with proposed text and placement, sourced from the calibration inventory>`

Chapter verdict: `DENSITY-AT-PEAK` (all markers at/above baseline; counts shown — a
verdict without the arithmetic is a FAILED audit) or `BELOW-BASELINE (markers: <list>)`
with proposals queued.

## Procedure

1. Check the gate: confirm the calibration artifact defines density markers and
   baselines ({calibration_density_markers}) and that this chapter contains the bound
   form above the calibration's word threshold. If either fails, record
   `NOT-APPLICABLE` with the reason and stop.
2. Extract the bound-form text from the chapter (exclude other forms per the reading
   guide's form boundaries) and compute its word count.
3. For each marker: count instances per the marker's definition, listing each counted
   instance with a quote or line citation (the count must be reproducible), then
   normalize per the marker's unit.
4. Compare to baseline. At or above: AT-PEAK with arithmetic shown. Below the
   calibration's flag threshold: BELOW-BASELINE.
5. For each BELOW-BASELINE marker, draft at least two concrete proposals: proposed
   insertion text in the binding register (drawn from the calibration's inventory of
   sanctioned material), with placement (after which line / in which paragraph). Never
   propose deletions to "balance" an over-baseline marker — one-directional.
6. Write the report in the required format and save to the output path. Queue
   proposals into the chapter's next revision round as amplification orders; the
   rewriter (Claude) executes them, this audit only specifies them.
7. If three consecutive audited chapters return BELOW-BASELINE on the same marker,
   escalate to the revision plan as systemic drift, not per-chapter noise.
