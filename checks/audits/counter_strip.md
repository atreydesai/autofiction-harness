# Audit: Counter-Strip Audit (anti-over-correction)

id: counter_strip | owner: codex | tier: core
trigger: every-revised-chapter
output: {audit_root}/codex/chapter_{NN}.counter_strip.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: verve-legacy editor, genericized

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The anti-over-correction backstop. Defensive zeal can cut legitimately strong lines:
every other audit in the pipeline pushes toward removal or replacement, and an
audit-driven editor will sometimes strip something good because it superficially
matched a banned pattern. On every revised chapter (including narrow-scope amplification
edits), sample 5-10 cut lines from the pre/post-revision diff. Per cut, ask: was this
cut justified by a Gate / drift / sanitization / audit finding, or was it editor
over-zealousness? A good line that pattern-matched a tic but was doing real
character/scene/register work is an over-cut and must be restored.

**Mis-fire logging.** Every over-cut implies an audit that mis-fired. Log the
mis-firing pattern (which audit, which rule, what kind of line it wrongly caught) to
`calibration/audit_calibration_notes.md` in the stage workspace, so future audit
prompts can be tuned against the pattern.

**Impression-aware calibration (reduced protection).** If {author_direction_notes}
(author-direction reactions captured for this book) flag this chapter or this pattern
— naming a specific register as the PROBLEM — the Counter-Strip Audit operates with
REDUCED PROTECTION on the flagged dimension. The dimension the note flags is the
dimension the editor is supposed to change, NOT preserve. Default Counter-Strip
protects "what's working"; when an author-direction note names a register as the
problem, that register is not what's working in that chapter. Example shape: a
character's quiet-tender register is normally protected as voice — but if the notes
flag that quietness as the problem, Counter-Strip lets amplification edits land
instead of fighting to preserve it. The note is the tiebreaker against the audit's
default protection.

**Evidence-documentation watch (>20% delta).** If the revised chapter's net word count
is more than 20% below the pre-revision count, note the delta and require the
synthesis memo to document what evidence supported the compression — cold-read
findings, author-direction matches, specific audit failures, per cut. **The watch does
NOT block compression when evidence supports it**; it requires explicit per-cut
evidence. Cuts justified by author-direction notes, audit failures, or cold-read
findings are GOOD cuts — the editor should make them. Cuts justified by "the
manuscript is over the length floor" are FORBIDDEN reasoning; word count is an
outcome, never a driver, and any cut citing manuscript-level length as its evidence is
an automatic over-cut.

## Required verdict format

Header: pre/post word counts, delta %, sample size, applicable {author_direction_notes}
entries with the reduced-protection dimensions named.

Per sampled cut:

- `JUSTIFIED — cut: "<quoted line>" — evidence: <named Gate / drift finding / audit verdict / author-direction match, with artifact reference>`
- `OVER-CUT — cut: "<quoted line>" — what it was doing: <character/scene/register work> — mis-firing audit: <audit + rule> — ORDER: RESTORE (verbatim or with stated adaptation)`
- `FORBIDDEN-REASONING — cut: "<quoted line>" — only stated evidence is manuscript-level length — ORDER: RESTORE + memo correction`

Chapter verdict: `NONE OVER-CUT` (per-cut reasoning shown for every sample — a bare
verdict is a FAILED audit) or `OVER-CUT (n)` with the restoration list and the
mis-fire log entries written.

## Procedure

1. Diff the pre-revision chapter against the integrated revision. Extract all deleted
   lines/passages; compute pre/post word counts and the delta.
2. Sample 5-10 cuts: include the longest cuts, any cut touching dialogue or a
   character-signature line, any cut in a passage {author_direction_notes} flags, and
   a random remainder. With fewer than 5 total cuts, audit all of them.
3. Load {author_direction_notes}; record which dimensions, if any, get reduced
   protection for this chapter. Do not protect a flagged register.
4. For each sampled cut, locate the claimed justification in the synthesis memo and
   audit reports. Verify the evidence actually covers THIS line, not just the
   paragraph around it. Judge whether the line was doing work the audits missed.
5. Issue per-cut verdicts. For every OVER-CUT, write the restoration order and append
   the mis-fire pattern to `calibration/audit_calibration_notes.md` (audit name, rule,
   wrongly-caught line shape).
6. If delta > 20% compression, verify the synthesis memo carries per-cut evidence;
   missing evidence sends the memo back for completion before commit. Reject any
   length-floor reasoning as FORBIDDEN.
7. Save the report to the output path. OVER-CUT restorations execute in the current
   round; the chapter does not commit with unexecuted restoration orders.
