# Audit: Zoom-Out Audit (every few chapters vs outline + promise)

id: zoom_out_audit | owner: codex | tier: risk
trigger: cadence:every-4-chapters
output: {audit_root}/codex/zoom_out_{NN}.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:5565-5587 [Reddit 9: every few chapters, zoom out]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Source, verbatim (Reddit 9, item 10), including its question list:

> 10. Every few chapters, zoom out
> Every five chapters or so, I ran a bigger developmental review.
> I wanted to know:
> - is the act structure still holding?
> - are the character arcs advancing?
> - are the themes developing?
> - are setups and payoffs being handled?
> - are any chapters redundant?
> - is the midpoint being seeded properly?
> - is momentum sagging anywhere?
> This kept me from only looking at chapters in isolation.
> A chapter can be good on its own and still be wrong for the book.

Three lenses over the window since the last run (and the book so far):
1. **Outline drift.** Compare the drafted chapters against the outline/act plan. List every divergence: beat moved, dropped, replaced, or invented. Per divergence, rule: CONSCIOUS-IMPROVEMENT (the outline should be amended to match) or DRIFT (the chapter should be pulled back). Unruled divergence is drift by default.
2. **Pacing across chapters.** Not chapter-internal pacing — the sequence. Chart what each chapter in the window DOES for the book (one line each: state change, arc movement, thread movement). Adjacent chapters doing the same job = redundancy candidate; a run of chapters with no arc movement = momentum sag.
3. **Arc-level sense.** Does the story still make sense at arc level — does the seven-question list above hold? Answer each of the source's seven questions individually, with evidence.

## Required verdict format

Seven verdict lines, one per source question, each PASS|FAIL with quoted evidence:
`ACT-STRUCTURE: PASS|FAIL — <where the window sits in the act plan; quote the beat that anchors it, or name the missing one>`
`CHARACTER-ARCS: PASS|FAIL — per principal: <arc position ch N-4 vs ch N, with a quote each>`
`THEMES: PASS|FAIL — <theme instances quoted, or "no thematic movement in window">`
`SETUPS/PAYOFFS: PASS|FAIL — <ledger items advanced/stalled in window, cited>`
`REDUNDANCY: PASS|FAIL — <chapter-job chart; name any two chapters doing the same job>`
`MIDPOINT-SEEDING: PASS|FAIL — <seeds on page for the midpoint/next structural beat, quoted, or ABSENT>`
`MOMENTUM: PASS|FAIL — <where it sags, with the chapter-job chart as evidence>`

PASS lines must show the chart/ledger rows actually examined and quote the weakest case accepted. Then:
1. **Drift table:** outline beat | chapter reality | ruling (CONSCIOUS-IMPROVEMENT → outline amendment text / DRIFT → pull-back order).
2. **Window verdict:** ON-COURSE / DRIFTING (1-2 fails) / OFF-COURSE (3+ fails, or act structure itself failing).
3. **Revision orders:** per FAIL, a chapter-targeted order (amend outline, cut/merge redundant chapter, insert seed at named point, add arc beat). Per source: "A chapter can be good on its own and still be wrong for the book" — orders may target chapters that passed every per-chapter audit.

## Edge cases and calibration

- **Outline as living document:** per source, "I did not treat the outline as a prison" — CONSCIOUS-IMPROVEMENT rulings are expected and healthy. The failure mode this audit exists for is UNCONSCIOUS drift: divergence nobody decided on. The ruling step is therefore mandatory per divergence, even when the answer is obvious.
- **Window boundaries:** judge the window in book context, not in isolation — a slow window directly after a climax may be an intentional breath; cite the act plan if claiming so.
- **Redundancy vs reprise:** two chapters doing the same job is redundancy; a chapter deliberately rhyming with an earlier one while moving the arc is reprise. The test is the chapter-job chart: if the one-line job is identical, it is redundancy regardless of surface differences.
- **Midpoint question generalizes:** before the midpoint, check midpoint seeding; after it, check seeding of the next structural beat (crisis, climax) — the source's question is about the next load-bearing beat, not the literal midpoint forever.

## Procedure (owner=codex)
1. Read the outline/act plan, the chapters in the window, the seed/thread ledger, continuity.md, and the previous zoom_out report.
2. Build the chapter-job chart and the drift table mechanically before judging.
3. Answer the seven source questions in order, quoting evidence; rule every divergence.
4. Emit verdicts, drift table, window verdict, revision orders; write to the output path. DRIFTING/OFF-COURSE marks the report ACTIONABLE before the next drafting block; OFF-COURSE additionally halts drafting pending outline reconciliation.
