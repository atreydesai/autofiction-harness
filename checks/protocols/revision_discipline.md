# Protocol: Revision Discipline

purpose: how revision is conducted — read-and-cut method, bounded findings with acceptance tests instead of open-ended commentary, and the calibration examples that show what a useful correction looks like
runs: every revision pass and every audit-to-revision handoff; the bounded-findings format is mandatory for all review output
source_ref: collation:3023-3029 [14. Revise by reading and cutting], 3290-3309 [Examples of useful corrections]; drafter/prompts/quality_brief.md [Revision Discipline]

## The method, verbatim

> ### 14. Revise by reading and cutting
>
> Re-read as a first-time reader. Cut anything that is auditioning. Cut sentences whose only job is to announce the next sentence. Collapse paragraphs that restate each other. Replace the most generic clause in the piece with something specific or delete it. Most edits should make the text shorter, but do not confuse concision with chopping: combining two tightly related sentences can be the cleaner edit when it restores the relationship between the thoughts.

## Bounded findings (from the quality brief)

From drafter/prompts/quality_brief.md, Revision Discipline — reviews should produce bounded findings with acceptance tests. For each major finding, record:

- problem
- evidence
- likely cause
- revision direction
- acceptance test
- whether it was fixed, rejected, deferred, or transformed

Do not let review become endless commentary. Revise the manuscript.

Revision should continuously elevate the book. Each major pass should try to make the manuscript more original, more coherent, more emotionally exact, more dramatically pressured, more naturally voiced, and more beautiful at the prose level.

Harness enforcement: every audit finding and every revision-pass note must arrive in this six-field format. A finding without quoted evidence or without an acceptance test is incomplete and is returned to its author. A finding's disposition (fixed / rejected / deferred / transformed) must be recorded before the pass closes; rejected and deferred findings carry reasons into the residual-risks file.

## Examples of useful corrections, verbatim

Calibration for what a correction should do. These are the source's reference pairs:

> ## Examples of useful corrections
>
> - Generic -> specific. Avoid: `The change had broad implications across the team.` Prefer: `The change cut review time, but it also pushed more edge cases into the escalation queue.`
> - Puffery -> observable consequence. Avoid: `The project stands as a testament to the team's commitment to innovation.` Prefer: `The project reduced the weekly handoff from three meetings to one written checklist.`
> - Administrative detail -> material detail. Avoid: `The revision changed the process.` Prefer: `After the revision, decisions stopped being a silent queue in the background; someone had to choose what to slow down and what to push through.`
> - Specificity theater -> verified restraint. Avoid: `The February revision renamed the framework and rewrote intake handling.` Prefer: `Early revisions focused on intake edge cases and prioritization; if you cannot verify the milestone name or exact wording, leave it out.`
> - Hidden mechanism -> observable consequence. Avoid: `The internal logic finally understood what mattered.` Prefer: `After the change, obviously irrelevant outcomes stopped showing up in routine cases.`
> - Vague attribution -> supported claim. Avoid: `Experts say the redesign improved trust.` Prefer: `In the support queue, billing complaints fell after the pricing table stopped hiding plan limits.` If you use a source, name it and stay within what it proves.
> - Causal overreach -> relationship restraint. Avoid: `The redesign drove trust higher.` Prefer: `After the redesign, refund questions fell in the support queue.` If trust was not measured, do not claim it moved.
> - Future certainty -> sourced timing. Avoid: `The next revision arrives in April.` Prefer: `The next revision is scheduled for April, according to the published roadmap.` If the source is old or tentative, say `planned` or cut the date.
> - Catalog prose -> argument prose. Avoid: `First came change A, then change B, then change C.` Prefer: `The important shift was not that the thing accumulated more pieces. It was that later changes finally introduced friction where the earlier version let people coast.`
> - System-tour prose -> cross-wired prose. Avoid: one paragraph for `background`, one for `process`, one for `impact`, then a verdict. Prefer: trace one recurring constraint, show how it appears across the piece, and make the paragraphs depend on each other.
> - Rushed linearity -> developed thought. Avoid: `The plan changed. Results improved. Therefore it worked.` Prefer: `Results improved only after the review queue changed, which is why the earlier numbers were misleading.`
> - Choppy -> connected. Avoid: `The term does real work. It names a pattern that was floating unnamed.` Prefer: `The term does real work: it names a pattern that was floating unnamed.`
> - False crispness -> carried relationship. Avoid: `The uncertainty is real. The confident register wrapping it is a default.` Prefer: `The uncertainty is real, but the confident register wrapping it is a default.`
> - Period-as-dash replacement -> clearer clause relation. Avoid: `The post would land harder. It should stop at the number and draw the consequence directly.` Prefer: `The post would land harder if it stopped at the number and drew the consequence directly.`

## Harness notes

- The example pairs are mostly nonfiction-flavored; the corrections transfer directly to fiction narration and to harness-internal documents (cards, briefs, reports). The transformation type on the left of each arrow is what matters.
- "Cut anything that is auditioning" pairs with the Decoration Test and with checks/protocols/diagnostic_questions.md; "replace the most generic clause" pairs with the Specificity Test.
- Pass ordering for these edits is governed by checks/protocols/editing_stages.md (no line-level cutting on structurally unstable chapters).
