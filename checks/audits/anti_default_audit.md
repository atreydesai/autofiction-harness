# Audit: Anti-Default / Derivative-Drift Audit (architecture)

id: anti_default_audit | owner: claude | tier: book
trigger: phase:architecture + phase:full-book-critique
output: {audit_root}/claude/book.anti_default.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: legacy-pipeline drafter Phase 2 Anti-Default Audit + quality_brief.md Novelty Within Genre / derivative-drift review

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

**Mode A — architecture time.** The drafter's architecture phase produces at least
three substantially-different candidate book shapes (or chapter maps, for
shape-committed premises) — different dramatic engines, primary-relationship arcs,
opposition shapes, ending shapes, structural forms. This audit runs adversarially
against the candidates before one is chosen: which candidate is the default the model
would produce for any premise in this genre? Are the three candidates genuinely
different books, or the same book with different filenames? The chosen shape must
survive this audit with concrete reasons recorded; rejected shapes are kept on file.

**Mode B — full-book critique.** The same battery runs on the drafted manuscript as a
derivative-drift review (quality brief): *if a scene, subplot, character, or world
element feels like it could have been imported from another book, revise it until it
belongs uniquely to this one.*

The question battery (quality brief, "Novelty Within Genre" — all six, verbatim, asked
of every major plot, world, character, or formal choice):

- What is the obvious version of this genre move?
- What would a competent but derivative book do here?
- What have readers seen too many times?
- What specific new pressure, inversion, image, rule, relationship, or consequence does this book add?
- Does the choice deepen the premise, or is it merely decorative weirdness?
- Does the choice create story energy that later chapters can use?

Also enforce the quality brief's avoid-list: generic genre furniture with renamed
labels; stock chosen-one, quest, rebellion, court intrigue, academy, dungeon,
apocalypse, or romance beats unless transformed by the specific premise; jokes or
clever inversions that do not change consequence; worldbuilding that is elaborate but
dramatically inert; novelty that breaks continuity, motivation, or reader trust.

## Required verdict format

Per audited element (candidate shape in Mode A; scene/subplot/character/world element
in Mode B):

```
<element> — DEFAULT | DERIVATIVE (names the book/trope it imports from) | DISTINCT
  obvious version: <one sentence>
  competent-but-derivative version: <one sentence>
  what this book adds: <specific new pressure/inversion/image/rule/relationship/
    consequence — or "nothing," which forces DEFAULT/DERIVATIVE>
  deepens premise or decorative: <verdict + evidence>
  downstream story energy: <what later chapters can use — quoted/cited, or "none">
```

Book/architecture verdict:

- `DISTINCT` — every audited element DISTINCT, with the battery answered per element
  (a DISTINCT verdict without the obvious-version and derivative-version named is
  invalid — you cannot know it's distinct without naming what it beat).
- `DEFAULTS-FOUND` — each DEFAULT/DERIVATIVE element gets a revision order: Mode A:
  `REJECT shape <id>` or `TRANSFORM <element>: <the specific pressure/inversion the
  shape must add>`; Mode B: `REVISE <location> until it belongs uniquely to this book:
  <direction>`. In Mode A, three candidates that converge on the same book is itself a
  finding: `RE-BRAINSTORM with forced divergence on <axis>`.

## Prompt template

Send to a fresh Claude session:

```
You are an adversarial novelty critic. Your job is to catch the default version of
this book before it gets written (or to catch where the manuscript has drifted into
one). LLM-generated fiction reliably regresses toward the obvious genre execution —
assume that has happened here and prove it where it has.

For each element listed below, answer ALL six questions:
- What is the obvious version of this genre move?
- What would a competent but derivative book do here?
- What have readers seen too many times?
- What specific new pressure, inversion, image, rule, relationship, or consequence
  does this book add?
- Does the choice deepen the premise, or is it merely decorative weirdness?
- Does the choice create story energy that later chapters can use?

Then give a verdict per element: DEFAULT, DERIVATIVE (name what it imports from), or
DISTINCT (name the obvious version it beat and how). Flag any element that is generic
genre furniture with renamed labels, a stock genre beat untransformed by this premise,
a clever inversion that changes no consequence, dramatically inert worldbuilding, or
novelty that breaks continuity, motivation, or reader trust. No verdict without
evidence. Convert every DEFAULT/DERIVATIVE into a concrete revision direction.

PREMISE / READING GUIDE:
{reading_guide}

ELEMENTS UNDER AUDIT (candidate shapes, or manuscript with element list):
{candidates_or_manuscript}
```

Mode A fills {candidates_or_manuscript} with the candidate shapes plus the premise's
committed elements (committed elements are exempt from rejection but not from the
"what does this book add" question). Mode B fills it with the manuscript and the major
scenes/subplots/characters/world elements to sweep. Findings queue into architecture
selection (Mode A) or the full-book revision plan (Mode B).
