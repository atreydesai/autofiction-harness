# Audit: Plain-Translation Audit (binding-register defense)

id: plain_translation | owner: claude | tier: risk
trigger: every-revised-chapter (editor core) + flag:register-drift (drafter)
output: {audit_root}/claude/chapter_{NN}.plain_translation.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: verve-legacy editor, genericized

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The primary tool for catching prose drift. **Generative-not-evaluative**: produce a
rewrite of the original prose, then compare. Asking a model "is this prose good?"
produces unreliable answers — models have a documented bias toward performed-literary
register when evaluating. Asking it to "rewrite as the binding-register version and
compare" produces a concrete on-the-page comparison whose verdict is harder to evade.

**Critical recalibration: the "plain" version is the BINDING-REGISTER version, not
generic-clarity prose.** Compare each paragraph against the binding-register sample for
that paragraph's form, as the reading guide defines the book's forms (e.g., narrator
prose, conversation/exchange formats, close-third human POV, documentary inserts —
use the reading guide's own form vocabulary). The comparison samples come from the
calibration artifact ({calibration_samples}); the audit must name the specific sample
it is comparing against, per form:

- **Narrator-form passages**: compare against the calibration's narrator sample(s).
- **Close-third passages**: compare against the character's voice-card sample, NOT
  generic-clarity prose. The question becomes: "is the voice-card-aligned version
  measurably worse than the original on character interiority, scene work, AND
  binding-standard fidelity?" Generic-clarity audits strip close-third voice.
- **Conversation/exchange forms and documentary forms**: the calibration's register
  for these forms is binding even when it violates standard clarity gates. Do NOT
  plain-translate them to literary-clarity prose. If the calibration declares an
  amplification direction, these forms get the chaos_up audit INSTEAD of this one;
  if no amplification direction is declared, this audit checks them only against
  their own form samples, never against narrator or essayistic register.

The audit question per paragraph: *"Is the binding-register version measurably worse
than the original on information density, dramatic content, AND binding-standard
fidelity?"* If the binding-register version preserves what the original was doing
without the drift, the binding-register version replaces.

**Inviolable elements are never plain-translated.** The calibration artifact specifies
what is locked ({calibration_locked_text}). Skip those passages entirely.

**The Aphorism Gate is universally applied at zero tolerance** unless the calibration
artifact specifies otherwise. Any line that reads as a portable maxim — quotable out of
context, marketing-pull-quote-shaped, tattoo-able, chapter-epigraph-shaped — is a Gate
failure. This applies especially to forms where literary-essay register tends to
install pull-quote shapes. The Aphorism Gate overrides any rule asking the editor to
"engineer quotable moments"; if the calibration says no portable maxims, no portable
maxims survive.

**The Verbatim-Echo Gate is universally applied** — any non-transformative verbatim
repetition between speakers or between sentences is a failure, except where the
calibration artifact specifies motif-repetition as deliberately load-bearing.

## Required verdict format

Per audited paragraph:

- `HOLDS — "<first words...>" — sample compared: <named sample> — binding-register rewrite is worse because: <density/drama/fidelity evidence>`
- `DRIFTED — original: "<quote>" — binding-register version: "<rewrite>" — what the rewrite preserves and what drift it removes — ORDER: REPLACE`
- `LOCKED — skipped, listed under calibration's inviolable text`

Gate findings (separate sections): `APHORISM-GATE — "<quoted line>" — ORDER: <cut or
de-quotablize>` and `VERBATIM-ECHO — "<quoted instances>" — ORDER: <vary or cut>`
(or, for each gate, the strongest counter-candidate considered and why it passes).

Chapter verdict: `REGISTER-HOLDS` or `DRIFT-FOUND` (with order count). Bare verdicts
without per-paragraph comparisons are a FAILED audit.

## Prompt template

You are a skeptical professional editor defending a book's binding register against
drift. Do not evaluate whether prose is "good" — generate and compare. No praise.

Reading guide form definitions and register rules (binding):
{reading_guide_register_excerpt}

Binding-register calibration samples, by form (compare against these by name):
{calibration_samples}

Voice cards for close-third focalizers in this chapter:
{voice_cards}

Locked text you must NOT rewrite (skip entirely, mark LOCKED):
{calibration_locked_text}

Chapter text (form boundaries marked):
{chapter_text}

For every non-locked paragraph: (1) identify its form per the reading guide; (2) write
the binding-register version against the named sample for that form — for close-third,
the named voice-card sample; (3) answer: is the binding-register version measurably
worse than the original on information density, dramatic content, AND binding-standard
fidelity? If not worse, the rewrite replaces — emit DRIFTED with both versions. Do not
plain-translate conversation/documentary forms toward literary clarity; check them only
against their own form samples. Then sweep the whole chapter for the Aphorism Gate
(zero tolerance: portable maxims, pull-quote shapes, tattoo-able lines, epigraph
shapes) and the Verbatim-Echo Gate (non-transformative repetition between speakers or
sentences; calibration-declared load-bearing motifs exempt: {calibration_motif_exemptions}).
Emit verdicts in the required format and end with the chapter verdict. If everything
HOLDS, you must still show per-paragraph comparisons for the 5 highest-risk paragraphs
and quote the strongest aphorism/echo candidates you cleared.
