# Audit: Tempo-Variation Audit

id: tempo_variation | owner: codex | tier: risk
trigger: cadence:per-act
output: {audit_root}/codex/tempo_variation_{act}.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4854+ [Reddit 5 Fix 6] + prose_variability metrics

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

**Fix 6: Vary the Tempo.** Pacing isn't just about speed. It's about *variation*.
**Fast-fast-fast is exhausting. Slow-slow-slow is boring.** The magic is in the shift
between them. Think of pacing like breathing: **tension is the inhale, release is the
exhale — you need both.** The source's gear-shift instructions, which the chapters in
this act should embody:

* "This scene is a breath. Slow, character-focused, no plot advancement."
* "Now things speed up. Short sentences, quick cuts between locations."
* "This conversation should feel long and uncomfortable. Don't rush to the point."

After a high-tension sequence, a quiet scene; after calm, a ramp. The contrast is what
makes both halves work. Related pacing-profile calibration from the source corpus:
action scenes — short sentences, rapid exchanges, minimal internal thought; emotional
scenes — slow down, pauses, body language, let characters breathe; transitions — quick
and functional unless something happens.

This audit runs per act over the last N chapters (the act's chapters). It judges the
**sequence** of tempos, not any single chapter:

1. **Declared vs. delivered tempo.** Each chapter card declares a pacing profile. Does
   the chapter's prose actually run at that tempo (sentence length, scene cuts,
   interiority density per {prose_variability_report})?
2. **Variation across the sequence.** Map the act's chapters to a tempo strip (e.g.
   F-F-S-F-S-S). Three or more consecutive chapters at the same effective tempo is a
   flatline regardless of what the cards declared.
3. **Inhale/exhale placement.** Does a release follow each sustained tension peak, and
   does tension rebuild after each release? Releases stacked on releases, or peaks
   stacked on peaks, are findings even below the three-in-a-row threshold when they sit
   around the act's structural high points.

## Required verdict format

Per chapter in the act:

- `TEMPO — chapter <NN> — declared: <card profile> — delivered: <FAST | SLOW | MIXED> — evidence: <prose_variability metrics cited + one quoted passage typifying the delivered tempo> — match: YES | DRIFT(<direction>)`

Sequence block:

- `STRIP: <e.g. F F S F S S> (chapters <range>)`
- `FLATLINES: <none | chapters <range> at <tempo>, with the three same-tempo chapter openings quoted>`
- `BREATHING: <each tension peak named with its following release chapter, or MISSING-EXHALE / MISSING-INHALE findings>`

Act verdict: `VARIED` / `FLAT-FAST` / `FLAT-SLOW`. VARIED must still name the act's
nearest-to-flat stretch and why it escapes the verdict. `REVISION ORDERS`: per flatline
or breathing failure, a numbered order naming which chapter changes gear, to what tempo,
and by what means (compression to summary, dilation to scene, scene-cut rhythm,
interiority density) — orders that say "vary the pacing" without a target chapter and
mechanism are invalid.

## Procedure

1. Load the act's chapters, their chapter-card pacing profiles, and
   {prose_variability_report} (per-chapter sentence-length distributions, paragraph
   lengths, dialogue/narration ratio, scene-cut counts).
2. For each chapter, derive the delivered tempo from the metrics, then verify against
   the text — quote one typifying passage; metrics are leads, the page is the verdict.
3. Compare delivered vs. declared per chapter; log DRIFT with direction.
4. Build the tempo strip; scan for three-in-a-row flatlines and for inhale/exhale
   failures around the act's peaks (peaks identified from the skeleton/act outline).
5. Write the per-chapter lines, sequence block, act verdict, and revision orders in the
   Required verdict format.
6. Write the completed audit to {audit_root}/codex/tempo_variation_{act}.md. A FLAT-FAST
   or FLAT-SLOW act routes its orders into the act's revision plan before the next act
   is drafted.
