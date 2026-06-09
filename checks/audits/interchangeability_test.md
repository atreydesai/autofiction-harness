# Audit: Interchangeability Test (any-character line)

id: interchangeability_test | owner: codex | tier: risk
trigger: sample:every-3rd-chapter
output: {audit_root}/codex/chapter_{NN}.interchangeability_test.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4321-4323 [BANNED Interchangeability Test]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The source test, applied verbatim:

* Could this physical tell / metaphor / ending belong to any character?
* If yes, it's not character-specific. Rewrite.

Where the Specificity Test asks "could this line live in another book," this test asks
"could this element belong to another character in THIS book." It targets three element
classes:

1. **Physical tells** — gestures, reaction beats, body language assigned to a
   character: jaw tightening, exhaled breath, hands through hair, heartbeat, throat.
   If the tell could be reassigned to any other character in the cast without anyone
   noticing, it is stock inventory, not characterization.
2. **Metaphors and interior images** — figuration attributed to a focalizer's
   perception. The image must be one THIS character would reach for, given their
   history, vocabulary, work, class texture, and voice card. An elegant image in the
   head of a character whose voice card says otherwise is a failure even if the image
   is good.
3. **Endings** — scene-final and chapter-final beats. A closing move (a look out a
   window, a held silence, a single short sentence) that any POV character could have
   ended on is an interchangeable ending.

The reassignment test: for each element, name the character it is attached to, then ask
whether swapping in every other named character in the chapter produces any felt
wrongness. If no swap feels wrong, the element is interchangeable. Check against the
voice cards: a passing element should be traceable to something on that character's
card (register, tics, interiority rhythm, relationship-specific behavior) or to
established continuity facts about them.

## Required verdict format

Per element, one verdict line:

- `CHARACTER-SPECIFIC — "<quoted element>" (<character>) — would break if reassigned because: <voice-card or continuity basis>`
- `INTERCHANGEABLE — "<quoted element>" (<character>) — survives reassignment to: <other character(s) named> — class: <tell | metaphor | ending>`

Chapter verdict:

- `DISTINCT` — every audited element CHARACTER-SPECIFIC. Must still quote the 3
  elements that came closest to interchangeable and say why they pass.
- `INTERCHANGEABLE-FOUND` — list every failing element with a revision order:
  `REWRITE <location>: replace with a tell/image/ending derived from <specific voice-card line or continuity fact>`.

## Procedure

1. Load the chapter, all voice cards for characters appearing in it, and the reading
   guide's character-specific care moves and tic catalog.
2. Inventory every physical tell (search reaction-beat verbs and body nouns), every
   metaphor/simile attributed to a focalizer, and the final beat of every scene plus
   the chapter ending. Audit the full inventory, not a sample, unless it exceeds 30
   items — then audit all endings and metaphors plus the 15 most repeated tells.
3. For each element, run the reassignment test against at least two other cast members
   and check for a basis on the owning character's voice card.
4. Treat reading-guide-declared character signatures (owned motifs, care moves,
   character-specific tics) as automatic passes; note them as the basis.
5. Write per-element verdicts and the chapter verdict in the required format.
6. Convert every INTERCHANGEABLE into a revision order that names the voice-card line
   or continuity fact the replacement must grow from. Queue into the revision round.
7. Save the report to the output path. INTERCHANGEABLE-FOUND on an ending blocks
   commit until resolved; tell-class findings may be batched but must be executed
   within the current revision round.
