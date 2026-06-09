# Audit: Opening Hook Audit (first 50 words)

id: opening_hook | owner: codex | tier: core
trigger: every-chapter
output: {audit_root}/codex/chapter_{NN}.opening_hook.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: legacy editor "The Opening Hook Audit" + collation weak-endings/openers [1.13 atmospheric front-loading]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Per-chapter check on the **first 50 words**: does the opening pull the reader forward, or
is it scene-setting throat-clearing?

Criteria:

1. **The 50-word pull.** Quote the chapter's first 50 words. Do they raise a question,
   start a motion, or land a voice the reader must follow — or do they clear their
   throat? Verdict: PULLS (with reasoning) or WEAK (with a proposed alternative opening,
   written out).

2. **Atmospheric front-loading (named criterion, from the source ban list).**
   **Pattern:** Scene opens with weather, skyline, or architecture before character
   presence.
   **What it looks like:**
   * "The New York skyline glowed through the penthouse window, casting neon over the glass table."
   * "Rain traced the windows of the Tokyo apartment, the city lights flickering below."
   * "The waves crashed against the shore outside, the moonlight pooling across the floor."
   **Why it fails:** Begins with set dressing, not story. Creates distance when immediacy
   is needed. Mimics film language rather than character consciousness. Filler buying
   time before committing to actual behavior.
   **Flagging trigger:** If the first sentence could be read over a slow pan in a movie
   trailer, cut it. Start with character.
   **Repairs (from the source):** Start with character in action or decision. Introduce
   environment through character perception, not camera pan. Let setting emerge from
   what the character notices and why. Anchor atmosphere in sensory detail that matters
   to the scene.

3. **First-scene commitment (chapter-1 + part-opening elevation).** For chapter 1 and
   every part-opening chapter, the bar rises from the first 50 words to the entire first
   scene: would this opening commit a FIRST-TIME reader — someone with no loyalty to the
   book — through the whole first scene? Read the full first scene and locate the first
   point where such a reader could put the book down.

**Locked text:** any opening beats listed as locked in {calibration_locked_text} are
inviolable in text; surrounding prose is revisable. Proposed alternatives must preserve
locked beats verbatim and may only reposition or rewrite around them.

## Required verdict format

- `CRITERION 1: PULLS — first 50 words quoted — reasoning: <what specifically pulls: question raised / motion started / voice landed>`
  or `CRITERION 1: WEAK — first 50 words quoted — failure: <throat-clearing diagnosis> — PROPOSED ALTERNATIVE: <full replacement opening, ~50 words, honoring {calibration_locked_text}>`
- `CRITERION 2: CLEAN — strongest atmospheric candidate quoted and why it survives (character-bound perception, not camera pan)`
  or `CRITERION 2: FRONT-LOADED — offending sentences quoted — repair order using the source's four repairs`
- `CRITERION 3 (chapter-1/part-openings only): COMMITS — the scene's strongest put-down point quoted and why a first-time reader passes it`
  or `CRITERION 3: LOSES-THE-READER — the put-down point quoted — revision orders for the surrounding prose (locked beats untouched)`

Chapter verdict: `HOOKED` only if all applicable criteria pass; otherwise `WEAK-OPEN`.
Then `REVISION ORDERS`: one numbered, executable order per failed criterion.

## Procedure

1. Load the chapter text, {reading_guide} (register and POV commitments for openings),
   {calibration} and {calibration_locked_text} (locked opening beats, if any).
2. Quote the first 50 words exactly. Judge criterion 1; if WEAK, draft the alternative
   opening yourself — a WEAK verdict without a written alternative is a failed audit.
3. Apply the criterion 2 trailer-pan trigger to the first sentence and first paragraph;
   quote any weather/skyline/architecture material that precedes character presence.
4. If this chapter is chapter 1 or a part-opening, read the entire first scene and judge
   criterion 3 from a first-time reader's position: mark the exact line where commitment
   could break.
5. Check every proposal against {calibration_locked_text}; locked beats appear verbatim
   in any alternative.
6. Write the verdicts, chapter verdict, and revision orders in the Required verdict
   format to {audit_root}/codex/chapter_{NN}.opening_hook.md. A WEAK-OPEN chapter is not
   committable until the orders are executed or rejected with reasons in the revision
   memo.
