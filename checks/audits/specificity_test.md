# Audit: Specificity Test (portable-line)

id: specificity_test | owner: codex | tier: risk
trigger: sample:every-3rd-chapter
output: {audit_root}/codex/chapter_{NN}.specificity_test.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4318-4320 [BANNED Specificity Test]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The source test, applied verbatim:

* Could any line appear unchanged in a different story with different characters?
* If yes, it's not specific enough. Rewrite.

A "portable" line is one that, lifted out of this chapter and dropped into a different
novel — different premise, different characters, different world — would read as if it
had been written for that novel. Portability is the signature of default-register LLM
prose: the line is doing genre work, not book work.

Apply the swap test to every sampled line:

1. **Story swap.** Replace this book's premise with a generic premise in the same
   genre. Does the line survive unchanged?
2. **Character swap.** Replace the named characters with placeholders. Does the line
   still "work"? If yes, it was never about these characters.
3. **World swap.** Strip the book's specific objects, institutions, idioms, and
   pressures (as catalogued in the reading guide). Is anything left of the line?

A line passes only if it is anchored to something only this book owns: a premise
mechanic, a character's established history or voice, a world-specific object or
institution, a scene-specific pressure. Reading-guide register markers and motif
vocabulary count as anchors; generic genre furniture does not.

Lines that are deliberately plain (functional blocking, transitional logistics) are not
automatic failures — flag them only when they sit at a load-bearing position: scene
openings, scene endings, emotional peaks, reveals, paragraph-final positions.

## Required verdict format

Per sampled line, one verdict line:

- `ANCHORED — "<quoted line>" — anchor: <the specific premise/character/world element that pins it here>`
- `PORTABLE — "<quoted line>" — survives swap to: <one-sentence alternate story it would fit unchanged> — position: <load-bearing | incidental>`

Chapter verdict:

- `SPECIFIC` — only if every load-bearing sampled line is ANCHORED. Must still list the
  3 weakest ANCHORED lines with the anchor named (show your work).
- `PORTABLE-FOUND` — one or more PORTABLE lines at load-bearing positions. Each gets a
  revision order: `REWRITE <location>: <what book-specific anchor the rewrite must use>`.

Revision orders must name the anchor source (premise element, voice card, continuity
fact, reading-guide motif), not just say "make it more specific."

## Procedure

1. Load the chapter text, the reading guide's premise-specific vocabulary (motifs,
   institutions, register markers), and the relevant voice cards.
2. Sample at least 15 lines, biased toward load-bearing positions: the first and last
   line of every scene, every paragraph-final sentence in emotional-peak passages,
   every line of figuration, and a spread of dialogue lines across speakers.
3. For each sampled line, run the three swap tests above. Write the alternate-story
   sentence for every PORTABLE verdict — if you cannot articulate the other story it
   fits, the verdict is ANCHORED, not PORTABLE.
4. Cross-check PORTABLE hits against the reading guide: a line using a declared motif
   or calibrated register marker is ANCHORED even if its syntax is plain.
5. Write the per-line verdicts and the chapter verdict in the required format.
6. Convert every load-bearing PORTABLE into a revision order naming the anchor source.
   Queue the orders into the current revision round; this audit's findings are not
   advisory.
7. Save the report to the output path. If the chapter verdict is PORTABLE-FOUND, mark
   the chapter not-committable until the orders are executed or explicitly rejected
   with reasons in the revision memo.
