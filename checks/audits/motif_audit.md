# Audit: Motif Audit (distribution + sharpness + arc)

id: motif_audit | owner: codex | tier: book
trigger: phase:whole-book
output: {audit_root}/codex/book.motif_audit.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: legacy-pipeline editor Motif Audit, genericized

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

For each recurring motif the reading guide declares (running jokes, repeated phrases,
recurring objects/gestures/rituals, character-attached callbacks — with whatever caps
the guide sets per motif), three independent checks:

1. **Distribution.** Is the motif under its reading-guide cap? Is it clustered (several
   occurrences bunched in adjacent chapters, then long silences) or spread so it stays
   alive in the reader's memory? Count every occurrence against the manuscript itself,
   not against the tracker — the tracker is verified, not trusted.
2. **Per-occurrence sharpness rollup.** Roll up the per-chapter sharpness grades
   (sharp / acceptable / weak) from the running tracker; re-grade any occurrence the
   tracker missed or graded without evidence. A motif with a high weak ratio is being
   spent, not used.
3. **Arc.** Does the motif build / escalate / shift meaning / pay off across the book —
   or is it static, the same beat replayed N times? Distribution and arc can diverge:
   a motif can hit its cap perfectly distributed and still feel arc-flat.

## Required verdict format

Per motif, one block:

```
MOTIF: <name> — cap: <N or none> — count: <actual, from manuscript>
  distribution: UNDER-CAP | AT-CAP | OVER-CAP; SPREAD | CLUSTERED (chapters: <list>)
  sharpness: <sharp>/<acceptable>/<weak> — weak instances quoted with locations
  arc: BUILDS | ESCALATES | SHIFTS | PAYS-OFF (final-instance quote) | STATIC
  verdict: HITS | DISTRIBUTION-PROBLEM | WEAK-INSTANCES | ARC-FLAT
```

A motif can carry multiple failure verdicts (e.g., DISTRIBUTION-PROBLEM + ARC-FLAT);
report all that apply.

- `HITS` — under cap, well distributed, low weak ratio, arc characterized with the
  payoff quoted. Show your work: quote the first, median, and final occurrence to
  demonstrate the arc.
- `DISTRIBUTION-PROBLEM` — over cap, or clustered. Orders: `CUT instance at <location>
  (redundant near cap)` / `MOVE instance from Ch <NN> to gap <range>`.
- `WEAK-INSTANCES` — listed, each with an order: `SHARPEN at <location>: <what the
  sharper version does>` or `CUT (weak + near cap)`.
- `ARC-FLAT` — orders that change the motif's trajectory: `ESCALATE instance at
  <location>` / `SHIFT meaning at <location>` / `ADD payoff beat near <location>`.

Book verdict: `ALL-MOTIFS-HIT` or `MOTIF-FINDINGS` (count per failure type).

## Procedure

1. Extract the motif list and caps from the reading guide; add any motif the running
   tracker or cold reads identified that the guide missed (flag it as undeclared —
   undeclared motifs over 4 occurrences are tic candidates, not motifs).
2. Grep + read for every occurrence of each motif across the manuscript; build the
   true count and chapter map. Reconcile against the tracker; tracker gaps are
   themselves findings (tracker incompleteness).
3. Grade or re-grade sharpness per occurrence with quotes — an occurrence is sharp
   only if it does new work where it stands; "present and recognizable" is
   acceptable at best.
4. Characterize the arc by reading the occurrences in sequence, first to last. If the
   final occurrence could swap positions with the first without loss, the arc is
   STATIC.
5. Write per-motif blocks and the book verdict; queue every order into the revision
   round (amplification orders route to the amplification audit's lane; cuts and
   moves to the revision plan).
6. Save the report to the output path.
