# Audit: Set-Piece Intensity Audit

id: set_piece_intensity | owner: codex | tier: risk
trigger: flag:high-leverage-scene
output: {audit_root}/codex/chapter_{NN}.set_piece.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: legacy-pipeline editor Set-Piece Intensity Audit, genericized

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Fires only on chapters containing scenes named in
{reading_guide_high_leverage_scenes} — the premise/reading-guide list of scenes that
MUST LAND at full intensity (the beats the book exists to deliver: the death, the
reveal, the confrontation, the locked closing move, whatever the guide names). These
are the scenes a reader quotes to a friend; "competently executed" is below the bar.

For each set piece in the chapter:

- **Quote the spec**: the exact premise/reading-guide text naming the scene and what
  it is supposed to do (including any locked text the scene must contain).
- **Quote the rendering**: the chapter's actual realization of the beat, in full
  enough excerpt to judge.
- **Ask: does the surrounding prose make this beat LAND, or does it bury / soften /
  decorate it?** Burial: the beat arrives mid-paragraph, under throat-clearing, or
  after the reader already inferred it. Softening: hedges, qualifiers, narrative
  distance, or register drift draining the beat the spec commits to. Decoration:
  figuration and atmosphere layered over the beat doing the emoting on the reader's
  behalf instead of letting the beat hit.

**Zero tolerance: a "fine" set piece is a failed set piece.** If the honest reaction
to the rendering is "fine," "solid," or "does the job," the verdict is
FLAT-WITH-MISSES. The set-piece list is short; everything on it must hit at peak.

## Required verdict format

Per set piece, one block:

```
SET PIECE: <name from reading guide>
  spec: "<quoted spec text>"
  rendering: "<quoted chapter text>"
  locked text present verbatim: yes | no | n/a
  verdict: HITS | FLAT-WITH-MISSES
  reasoning: <for HITS — what the surrounding prose does that makes it land, with the
    specific lines doing the work quoted; "it works" is not reasoning>
  misses: <for FLAT-WITH-MISSES — each miss: buried | softened | decorated | spec
    element absent, with the offending lines quoted>
  revisions: <for FLAT-WITH-MISSES — concrete surrounding-prose revisions: what to
    cut before the beat, what to sharpen at the beat, where the beat should fall in
    the paragraph/scene; locked text itself is never altered>
```

Chapter verdict: `ALL-HIT` or `FLAT-WITH-MISSES` (any set piece flat).

**FLAT-WITH-MISSES is HIGH priority**: it enters the next revision round ahead of
ordinary findings, and a chapter carrying it cannot be committed or classified done
until the set piece re-audits as HITS or the miss is escalated (a set piece that
cannot be salvaged by revision is evidence for structural surgery on the chapter, not
for accepting "fine").

## Procedure

1. From the calibration extraction, load {reading_guide_high_leverage_scenes} and
   identify which named scenes this chapter contains. If none, record `no set piece in
   chapter — audit not applicable` and stop (the trigger should have prevented this).
2. For each set piece, copy the spec text verbatim and locate the rendering in the
   chapter. A spec element with no locatable rendering is an automatic miss
   (spec element absent).
3. Verify any locked text byte-exact.
4. Read the rendering cold, then read it in chapter context. Judge landing in context:
   what does the prose immediately before and after do to the beat? Quote the lines
   that bury, soften, or decorate.
5. Apply zero tolerance: argue the beat is at peak with quoted evidence, or write the
   misses. Do not split the difference.
6. Write the blocks and chapter verdict; queue FLAT-WITH-MISSES revisions at HIGH
   priority into the current revision round.
7. Save the report to the output path. Re-run after revision until ALL-HIT.
