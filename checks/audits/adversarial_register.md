# Audit: Adversarial Register Audit (cross-model, both directions)

id: adversarial_register | owner: codex | tier: core
trigger: every-revised-chapter
output: {audit_root}/codex/chapter_{NN}.adversarial_register.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: verve-legacy editor, genericized (comp-drift + genre-cliché checks calibration-driven)

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Cross-model defensive pass on every chapter that received non-trivial revision. Each
model audits the OTHER model's material against patterns the auditing model would not
itself produce — this surfaces blind spots a same-model audit cannot. This is the
pipeline's defining cross-model method; do not skip it on revised chapters.

**Direction 1 — Codex audits Claude-originated material** (Claude drafts/revisions)
for Claude tics: the thirteen-item list in the claude_tic_audit, plus any
book-specific drift patterns the calibration artifact names.

**Direction 2 — Claude audits Codex-originated material** (any Codex parallel draft,
and Codex's synthesis decisions where Codex changed Claude's material) for Codex tics:
arrangement-coded prose, three-item catalogs, thesis closers,
taxonomies-disguised-as-narration, em-dash interruptions used as emotional substitute
for content. Runs via the codex_tic_audit prompt.

**Comp-author drift check (both directions).** Additionally ask: does this revision
read like one of the reading guide's named comp authors ({reading_guide_comps})? Comps
are aiming-targets, not imitation-targets — pastiche of any comp is a Gate failure.
The auditor names the specific comp author the prose drifted toward and quotes the
specific passage. Comp-drift findings enter the next revision round.

**Genre-Cliché Check (both directions).** Different from comp-author drift: catches
genre-default register, not named-author pastiche. For each chapter ask: is this
chapter delivering its premise in the GENRE'S DEFAULT PRESTIGE REGISTER — the register
a well-read reader has already met dozens of times in this genre's prestige titles —
rather than in the premise's own declared register ({reading_guide_register})? The
reading guide defines what the premise's distinct register looks like; the auditor must
quote examples of whichever register the chapter is actually written in. Verdict:
**GENRE-CLICHE** (with specific examples of the cliché register) or **PREMISE-CODED**
(with specific examples of the premise's distinct register). GENRE-CLICHE findings
enter the next revision round at HIGH priority — the premise wants something the
genre's default register cannot deliver.

## Required verdict format

Four sections, each with quoted evidence per finding:

1. `CODEX-ON-CLAUDE:` per tic found — `<tic name> — "<quote>" (line ref) — ORDER: <fix>`;
   if clean, name the tics checked and quote the nearest miss per high-risk tic.
2. `CLAUDE-ON-CODEX:` same format (omit with reason `NO-CODEX-MATERIAL` if no Codex
   parallel draft or Codex-modified synthesis material exists in this chapter).
3. `COMP-DRIFT:` per comp in {reading_guide_comps} — `CLEAR` or
   `PASTICHE — <comp author> — "<quote>" — ORDER: <fix>`.
4. `GENRE-CLICHE-CHECK:` verdict `GENRE-CLICHE` (examples + HIGH-priority orders) or
   `PREMISE-CODED` (examples of the premise's distinct register on the page).

Chapter verdict: `CLEAN` only if all four sections show evidence; otherwise
`FINDINGS (n)` with the union of orders queued into the chapter's revision plan.

## Procedure

1. Determine material provenance from the synthesis memo and draft files: which
   passages are Claude-originated, which are Codex-originated (parallel draft text
   that survived synthesis, plus any line Codex altered during integration).
2. Run Direction 1 yourself (Codex): audit all Claude-originated material against the
   claude_tic_audit list plus calibration-named drift patterns. Quote every instance
   with line references.
3. If Codex-originated material exists, dispatch Direction 2 to Claude via the logged
   call wrapper using the codex_tic_audit prompt template, passing only the
   Codex-originated passages. Otherwise record `NO-CODEX-MATERIAL`.
4. Run the comp-author drift check on the whole revised chapter against each comp in
   {reading_guide_comps}: read for cadence, move-set, and signature devices of each
   comp; quote any passage that reads as that author.
5. Run the Genre-Cliché Check: characterize the chapter's working register, compare
   against {reading_guide_register}, and issue GENRE-CLICHE or PREMISE-CODED with
   quoted examples either way.
6. Union all findings (both directions + comp-drift + genre-cliché) into one orders
   list; write the report in the required format; queue orders into the chapter's
   revision plan with GENRE-CLICHE orders marked HIGH.
7. Save to the output path (Direction 2's raw Claude output saves beside it under the
   claude audit root). Unresolved findings block final assembly for this chapter.
