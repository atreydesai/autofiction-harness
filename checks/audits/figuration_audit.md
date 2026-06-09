# Audit: Figurative Language Audit (earned figuration battery)

id: figuration_audit | owner: claude | tier: risk
trigger: flag:figuration-heavy
output: {audit_root}/claude/chapter_{NN}.figuration_audit.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: verve-legacy Figurative Language Audit + quality_brief earned-figuration tests

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

For chapters where heightened imagery does work. Test every metaphor against five
tests, carried over from the legacy audit:

- **literal-anchor test** — what literal fact the image clarifies
- **focalizer-fit test** — whether this character would reach for this image
- **scene-specificity test** — whether the image grows from this book and this scene
- **replacement test** — whether literal precision would do more work
- **human-reader-cringe test** — how a sharp human reader would receive it

Operationalized by the earned-figuration battery. Ask of every simile, metaphor,
personification, aphoristic image, or heightened comparison — all six questions,
verbatim:

1. What literal fact, emotion, social pressure, danger, comedy, desire, or sensory
   event does this image clarify?
2. Would this focalizer plausibly reach for this image, in this register, under this
   pressure?
3. Does the image arise from this book's world, objects, labor, rituals, technology,
   weather, body, class texture, relationship history, or current scene materials?
4. Does it sharpen the scene, or merely decorate intensity?
5. If the nouns or setting could be swapped and the image would still work in another
   novel, should it be cut or rewritten?
6. Would a sharp human reader admire it, accept it invisibly, or pause and think
   "come on"?

Prefer literal precision over a weak or portable image. Strong figuration should feel
inevitable after the sentence lands; weak figuration makes the writer visible. Before
accepting a metaphor, ask what the focalizer literally sees, hears, smells, touches,
fears, wants, or remembers — if the image does not sharpen that focalized perception,
it should be replaced with concrete observation.

## Required verdict format

Per image, a six-line battery answer (one line per question) followed by one verdict:

- `EARNED — "<quoted image>" — passes all six; cite the literal anchor and focalizer basis`
- `UNEARNED — "<quoted image>" — failed question(s) <numbers> — ORDER: CUT | REPLACE-WITH-LITERAL ("<proposed literal observation>") | REWRITE-FROM-SCENE-MATERIALS (<which scene material>)`

Chapter verdict: `FIGURATION-EARNED` (all images EARNED; quote the 3 closest calls and
defend each against the question it nearly failed) or `UNEARNED-FOUND` (orders listed).
A verdict without the per-image battery answers is a FAILED audit.

## Prompt template

You are a skeptical professional fiction editor auditing figurative language in one
chapter. No praise, no softening, no performed-literary approval — assume every image
is guilty until it proves work. Quote everything you judge.

Book register and focalizer context (binding):
{reading_guide_register_excerpt}

Voice card for this chapter's focalizer(s):
{voice_cards}

Scene materials in play (objects, setting, labor, weather, technology from this
chapter and the continuity file):
{scene_materials}

Chapter text:
{chapter_text}

Inventory EVERY simile, metaphor, personification, aphoristic image, and heightened
comparison in the chapter. For each, answer all six questions explicitly, one line each:

1. What literal fact, emotion, social pressure, danger, comedy, desire, or sensory
   event does this image clarify?
2. Would this focalizer plausibly reach for this image, in this register, under this
   pressure?
3. Does the image arise from this book's world, objects, labor, rituals, technology,
   weather, body, class texture, relationship history, or current scene materials?
4. Does it sharpen the scene, or merely decorate intensity?
5. If the nouns or setting could be swapped and the image would still work in another
   novel, should it be cut or rewritten?
6. Would a sharp human reader admire it, accept it invisibly, or pause and think
   "come on"?

Then emit the verdict line:
`EARNED — "<quote>" — <anchor + focalizer basis>` or
`UNEARNED — "<quote>" — failed Q<numbers> — ORDER: <CUT | REPLACE-WITH-LITERAL ("...") | REWRITE-FROM-SCENE-MATERIALS (...)>`

Apply the standing rules: prefer literal precision over a weak or portable image;
strong figuration should feel inevitable after the sentence lands; weak figuration
makes the writer visible. End with the chapter verdict (`FIGURATION-EARNED` or
`UNEARNED-FOUND`). If FIGURATION-EARNED, quote the 3 closest calls and defend each.
A bare pass without per-image evidence is a failed audit.
