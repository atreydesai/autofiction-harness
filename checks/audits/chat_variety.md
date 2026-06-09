# Audit: Conversation-Variety Audit (recurring speakers)

id: chat_variety | owner: codex | tier: risk
trigger: flag:recurring-conversation
output: {audit_root}/codex/chapter_{NN}.chat_variety.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: legacy editor prompt ["The Chat-Variety Audit"], genericized to any recurring-speaker conversation form

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Applies to any RECURRING conversation form between the same speakers across multiple chapters: chat/message logs, letters, phone calls, recurring dinner-table scenes, interview transcripts, radio check-ins, confession-booth visits — any form where the same speakers reconvene. Run on every chapter containing such a conversation where the speakers have conversed in a prior chapter.

**Half 1 — Variety dimensions.** For each recurring-speaker conversation in the chapter, compare against ALL prior conversations between the same speakers on:
- **Relational stake-shift.** What changed BETWEEN the speakers this conversation versus their last one? If nothing changed in the relationship — only the topic — the conversation is topic-substituted: the same scene wearing a different subject.
- **Format.** Different conversation shape from prior instances (short exchange / long scene / annotated or interrupted / fragmentary-overheard / one-sided / embedded-in-action — whatever form-set the book uses)?
- **Length.** Substantially different from prior conversations between these speakers, OR justified-as-same-length by stake?
- **Temporal mode.** Different time-of-day / time-stamp / narrative-time context (mid-crisis vs aftermath vs years-later) from prior instances?
- **Register.** Different register beat from prior instances (per the book's register palette — e.g., tender / hostile / procedural / absurd / confessional / oblique)?

**Half 2 — Earns-its-place criterion (judged regardless of distinctness from prior conversations).** Does this conversation carry comedy, menace, pointedness, transgression, or genuine revelation? Would a reader skim this conversation to get to the next one? A conversation that is technically distinct from prior ones but still BORING — flat in register, no payoff, no character revelation — fails the audit regardless of variety dimensions. The criterion: each recurring conversation must earn its page-count by being funny, charged, pointed, or revealing.

Both halves are required. Variety without earning fails. Earning without variety (the same great scene replayed) also fails.

## Required verdict format

Per conversation: header `SPEAKERS: <A> + <B> — ch {NN} instance #k of m — prior instances: ch NN, NN...`

Then one line per variety dimension:
`STAKE-SHIFT | FORMAT | LENGTH | TEMPORAL | REGISTER: VARIED|REPEATED — this: "<quote/characterization>" vs prior (ch NN): "<quote/characterization>"`

And the second-half line:
`EARNS-ITS-PLACE: EARNS|BORING — the payoff, quoted: "<line>" — or: what a skimming reader would lose: NOTHING`

A VARIED or EARNS line must quote both sides / the actual payoff line; the EARNS line must also name the strongest skim-risk passage considered. Bare passes = FAILED audit.

Conversation verdict: **VARIED+EARNS** / **TOPIC-SUBSTITUTED** (0-1 dimensions varied) / **VARIED-BUT-BORING** (dimensions pass, earns-its-place fails).

Close with revision orders: every flagged conversation enters the next revision round with the question: *"what relational stake-shift, format, length, temporal mode, register beat, or payoff distinguishes this conversation? And if nothing, can it be intensified to earn its place, cut entirely, or merged with another conversation?"* — answered concretely per conversation: the specific shift to make, or CUT, or MERGE-WITH ch NN instance. "Make it more distinct" is not an order.

## Edge cases and calibration

- **First instance between a pair:** no prior to compare; skip Half 1, but Half 2 (earns-its-place) still applies in full. Log the instance so later runs have their baseline.
- **Group conversations:** treat each stable speaker-set as its own pair-equivalent. A two-person exchange embedded in a group scene counts against that pair's history if it carries the beat.
- **Deliberate ritual repetition:** a book may intentionally repeat a conversation form (the same toast every dinner) as a motif. That is only a defense if the repetition itself shifts meaning — quote what recontextualizes the repeat this time. "It's a motif" without a per-instance delta is REPEATED.
- **Length judgment:** "substantially different" means a reader would notice — roughly 2x or 0.5x prior typical length, or an obvious form change. Same-length passes only with a stated stake justification, quoted.
- **Register palette:** take the palette from the book's reading guide/calibration files if present; otherwise infer it from the manuscript's own demonstrated range and say which you used.
- **Do not over-fire:** one varied dimension with a strong earns-its-place payoff can be a deliberate quiet variation; flag at 0-1 varied dimensions, not at "fewer than all five."
- **Mixed forms count as one history:** if a pair converses by letter in ch 04 and by phone in ch 11, both belong to the same pair history — the form change itself scores as FORMAT variation, but stake-shift is still judged across forms.
- **Quoting forms without quote marks:** for scene-form conversations (dinner table, walks), "quote" means the load-bearing exchange, two to four lines, not the whole scene.

### Report header fields
`chapter: {NN} | conversations audited: N | pairs with prior history: N | flagged: N`
This header is mandatory; a report that audits zero conversations must state why the flag fired anyway.

## Procedure (owner=codex)
1. From the recurring-conversation manifest (or by scanning the manuscript for repeated speaker-pairs in conversation forms), list every recurring-speaker conversation in the chapter and locate all prior instances per pair.
2. Re-read the prior instances, not summaries of them — variety judgments require the actual prior text.
3. Score the five variety dimensions per conversation with paired quotes, then apply the earns-its-place criterion independently.
4. Emit per-conversation verdict blocks and the revision orders; write the report to the output path. TOPIC-SUBSTITUTED or VARIED-BUT-BORING marks the report ACTIONABLE for the next revision round. Book-level per-pair arc checking is out of scope here — it belongs to the book-level conversation audit (chat_audit_book).
