# Audit: Ripple Audit After Major Revisions

id: ripple_audit_post_revision | owner: codex | tier: risk
trigger: event:major-revision
output: {audit_root}/codex/ripple_audit_{rev}.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:5953-5977 [Reddit 9: after major revisions, run a ripple audit]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Source, verbatim (Reddit 9, item 11), including its scope list:

> 11. After major revisions, run a ripple audit
> If I changed an already-drafted chapter in a meaningful way, I checked what that broke downstream.
> A revision can change:
> - later facts
> - character states
> - object locations
> - seeded details
> - timelines
> - promises
> - mysteries
> - payoffs
> This is where a lot of long-form drafts quietly break. You revise Chapter 7, but the consequences show up in Chapters 14, 22, and 31.
> So after a major change, I asked the AI to audit every downstream consequence.

Fires after ANY structural change: a chapter cut, two chapters merged, chapters reordered, or a major rewrite of an already-drafted chapter. The audit scans EVERY chapter that references the changed material — downstream chapters by default, and upstream chapters too when the change removes or relocates a payoff whose setup precedes it.

Procedure of record:
1. **Change manifest.** State precisely what changed: chapters touched, beats added/removed/moved, facts altered. Quote before/after for each substantive delta.
2. **Reference sweep.** For each delta, find every other chapter that references the changed material — by named entity, event, object, promise, seed, or timeline anchor. Search the manuscript text AND continuity.md/{timeline} entries that point at the changed chapters.
3. **Break classification.** For each reference, classify against the source's eight scope categories: later facts / character states / object locations / seeded details / timelines / promises / mysteries / payoffs.
4. **Tracker fallout.** continuity.md, {timeline}, {npc_goals}, the seed/thread ledger, and meanwhile_ledger.md all contain entries keyed to the old text. Each stale entry is a finding.

## Required verdict format

Open with the change manifest. Then, per scope category, one line:
`FACTS | STATES | OBJECTS | SEEDS | TIMELINES | PROMISES | MYSTERIES | PAYOFFS: INTACT|BROKEN(N) — per break: ch NN "<quoted surviving reference>" vs revised material "<quote>"`

An INTACT line must list the references actually swept for that category and quote the nearest-to-broken case considered. Bare INTACT = FAILED audit.

Close with:
1. **Break map:** `revised ch NN → breaks in ch NN, NN, NN` (the "revise Chapter 7, consequences in 14, 22, 31" picture, made explicit).
2. **Revision orders:** per break, the exact downstream/upstream line(s) to change and the replacement sense; per stale tracker entry, the corrected entry text. Orders are queued before any further drafting on affected chapters.
3. **Verdict:** NO-RIPPLE-DAMAGE / RIPPLE-DAMAGE (N breaks). RIPPLE-DAMAGE is ACTIONABLE: the orchestrator applies orders before the revision is marked complete — a structural change is not "done" until its ripples are repaired.

## Edge cases and calibration

- **Trigger threshold:** "major" = cut, merge, reorder, or any rewrite that changes facts/beats — not line edits. When in doubt, the convenient_invention diff report for the revision is the tiebreaker: any fact-level change promotes the revision to major.
- **Reorder-specific sweep:** chapter reordering breaks relative references ("as she'd learned the week before," "two nights after the fire") even when no text changed; sweep for relative-time and first-mention phrases across the moved span.
- **Cut-specific sweep:** a cut chapter's unique facts may survive ONLY as downstream references — each such orphaned reference must be either re-homed (the fact re-established somewhere) or removed; "the reader will assume it happened offscreen" is not a disposition.
- **Cascade rule:** if executing the revision orders here constitutes another major change, this audit re-fires on that change. Record the chain (rev → rev') in the report header so loops are visible.

## Procedure (owner=codex)
1. Read the revision diff (or pre/post chapter files), the full manuscript, continuity.md, {timeline}, {npc_goals}, the seed/thread ledger, and meanwhile_ledger.md.
2. Build the change manifest from the diff; never trust the revision's own summary of itself.
3. Run the reference sweep mechanically (entity/event/object/date term search across all chapters), then read each hit in context to classify INTACT vs BROKEN.
4. Audit every downstream consequence per the source — and upstream setups when payoffs moved or died.
5. Emit the verdict block, break map, and revision orders; write the report to the output path; update stale tracker entries in the same run.
