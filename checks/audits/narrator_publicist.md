# Audit: Narrator-Publicist Audit (critical distance)

id: narrator_publicist | owner: claude | tier: risk
trigger: sample:every-4th-chapter + flag:protagonist-heavy
output: {audit_root}/claude/chapter_{NN}.narrator_publicist.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4025+ [field guide 9]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The source entry (field guide 9, THE NARRATOR FALLS IN LOVE WITH THE PROTAGONIST), faithful to the text — the failure examples:

> "The green hood low over a face few people bothered to understand and fewer still had profited from trying." "A long moment, the kind that made people reconsider their life choices." "He moved with that particular grace that suggested the universe owed him an apology for making him move at all." "She gave a slight shrug — one of those economical movements that somehow conveyed entire paragraphs of unconcern."

And the rule:

> The narrator is not a publicist. If every description of your main character reads like a press release for how mysterious and dangerous and effortlessly cool they are, the narrator has lost critical distance. The fix: describe what the character actually does and let the reader decide if it's impressive. A character who is genuinely impressive doesn't need the narrator campaigning on their behalf.

Press-release markers to hunt in every description of the protagonist (and any clearly favored character):

1. **Mystique assertions** — descriptions claiming the character is misunderstood, unreadable, underestimated, or beyond others' comprehension ("a face few people bothered to understand").
2. **Effect-on-others framing** — the character's presence graded by hypothetical or generalized reactions ("the kind that made people reconsider their life choices") rather than by a specific person's specific reaction in the scene.
3. **Cosmic-flattery figuration** — imagery whose only content is that the character is special ("the universe owed him an apology").
4. **Gesture inflation** — small movements credited with outsized communicative power ("conveyed entire paragraphs of unconcern").
5. **Adjective campaigning** — mysterious / dangerous / effortless / cool and their synonyms asserted by the narrator rather than produced by action.

The pass condition is the source's fix inverted into a test: strip the campaigning clause; does the description still tell us what the character actually DID? If nothing remains, the line was pure publicity. Free-indirect admiration is excused only when it is a scene character's perception, attributable on the page to a perceiver whose judgment the book treats as fallible — name the perceiver. A close-third narrator voicing the protagonist's own self-image counts as a finding unless the book frames that self-image critically somewhere the chapter can point to.

## Required verdict format
Per flagged description:
- `PUBLICITY — marker <1-5> — "<quoted line>" (location) — strip test: what action remains: <residue or NONE> — attributable perceiver: <name or NONE>`
- `EARNED — "<quoted line>" — the on-page action that backs it: "<quote>"`

Chapter verdict:
- `CRITICAL-DISTANCE-HELD` — no unattributed publicity. Must still quote the most admiring surviving line and name the perceiver or action that earns it.
- `PUBLICIST-FOUND (<n> lines)`.

`REVISION ORDERS:` one per PUBLICITY line: quote it, and rewrite-direct per the source fix — replace the campaign with what the character actually does, in scene materials, letting the reader decide if it's impressive. Where marker 2 applies, the order must replace generalized reactions with one named character's specific reaction. Orders that merely tone down the adjective are invalid; the assertion itself must convert to action or be cut.

## Prompt template (owner=claude)
You are auditing chapter {NN} for narrator-publicist failure — the narrator campaigning for the protagonist instead of describing them. Begin from the Critique stance above. Your bias to fight: publicity lines are engineered to read as stylish; you will be tempted to admire them. Admiration is the symptom under audit.

Inputs:
- Chapter text: {chapter_file}
- Protagonist and favored-character list with snapshots/voice cards: {character_snapshots}
- Reading-guide narrator-stance rules (POV distance, declared narrator attitude): {reading_guide}
- Calibration notes, if present: {calibration}

Steps:
1. Collect every narrator description of the protagonist (and any character the prose visibly favors): appearance, movement, gesture, presence, reputation. Quote each with location.
2. Test each against markers 1-5. For every hit, run the strip test: delete the campaigning clause and record what concrete action remains.
3. For every admiring line, attempt attribution: is a specific on-page perceiver doing the admiring, and does the book treat that perception as theirs (fallible) rather than as fact? Name the perceiver or rule NONE.
4. Check the reading guide for a declared narrator attitude (e.g., an unreliable narrator who IS a publicist by design). If declared, audit whether the publicity is framed as characterization of the narrator — cite the declaration and the framing evidence; otherwise findings stand.
5. Issue per-line verdicts, the chapter verdict, and revision orders.

Write the completed audit, in the Required verdict format, to {audit_root}/claude/chapter_{NN}.narrator_publicist.md. Findings must be revision orders an editor can execute without re-deriving your reasoning.
