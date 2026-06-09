# Audit: Wisdom-Dispensing Mentor-Scene Audit

id: mentor_scene_check | owner: codex | tier: risk
trigger: flag:mentor-scene
output: {audit_root}/codex/chapter_{NN}.mentor_scene.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:3777+ [field guide 11]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The source entry (field guide 11, THE WISDOM-DISPENSING MENTOR SCENE), faithful to the text:

> Two older characters appear. Each delivers exactly one perfectly calibrated anecdote from their past that maps precisely onto the younger character's current emotional state. The younger character receives the lesson gracefully. Everyone leaves improved.
> "Trust is built the way muscle is. Slowly, with repetition." "They don't need you to be a savior. They need you to be consistent."
> Real mentorship conversations are messier, more oblique, and frequently unhelpful. Sometimes the older person gives advice that doesn't apply. Sometimes they ramble. Sometimes the useful thing they say is buried in a story about something completely different and the younger person only realizes it later. AI can't do this because it optimizes for clarity of message. Real humans are not optimized.

Failure markers, per mentor-shaped scene (any scene where an older / senior / more experienced character advises, instructs, or counsels a junior one):

1. **Perfectly calibrated anecdote** — the elder's story from their past maps precisely onto the junior's current emotional state, with no residue that doesn't apply.
2. **Aphorism delivery** — the advice arrives as a polished, quotable maxim ("Trust is built the way muscle is. Slowly, with repetition.").
3. **Graceful reception** — the junior receives the lesson gracefully, understands it immediately, and visibly improves; no resistance, misunderstanding, boredom, or resentment.
4. **Everyone-leaves-improved closure** — the scene ends with both parties bettered and the emotional question resolved.
5. **Missing mess** — none of the real-mentorship textures: advice that doesn't apply, rambling, self-interest, the useful thing buried in a story about something completely different and only understood later, the elder being flat-out wrong.

The fix-direction, from the source: make the mentorship oblique, messy, or unhelpful. The elder may be wrong, self-interested, off-topic, or rambling; the value, if any, should be buried or deferred — realized later, not received on the spot.

Calibration: a mentor scene is not failed for containing good advice. It is failed for frictionless transmission — calibration + aphorism + graceful reception together. Books with a declared didactic register (fable, explicit teacher-student structure per {reading_guide}) may license cleaner transmission; cite the declaration, and still check whether the elder ever costs the junior anything.

## Required verdict format
Per mentor-shaped scene:
- `SCENE <location> — elder: <name>, junior: <name>`
  - Per marker 1-5: `HIT — "<quoted evidence>"` or `ABSENT — <what the scene does instead, quoted>`
  - `MESS LEDGER: <which real-mentorship textures are present, quoted — or NONE>`
  - Scene verdict: `OPTIMIZED (markers <list> hit, mess NONE)` or `HUMAN (mess present: <quote>)`

Chapter verdict:
- `MENTORS-HUMAN` — every mentor-shaped scene HUMAN. Must still quote the cleanest transmitted advice that survives and what mess offsets it.
- `WISDOM-DISPENSER (<n> scenes)`.

`REVISION ORDERS:` one per OPTIMIZED scene: quote the calibrated anecdote/aphorism, and direct one or more source-fix modes — (a) make the advice not apply or only partially apply, (b) bury the useful thing in a story about something else, with realization deferred to a named later beat, (c) give the elder self-interest, error, or rambling that costs scene time, (d) make the junior resist, misread, or resent the lesson. Orders must preserve the scene's plot function while breaking its transmission cleanliness; deleting the scene is not an order this audit may issue.

## Procedure
1. Load the chapter, the flag metadata identifying mentor-shaped scenes, voice cards / snapshots for elder and junior (especially what-they-get-wrong and under-pressure fields), {reading_guide}, and {calibration} if present.
2. Confirm the scene inventory: sweep the chapter for additional advice-giving scenes the flag missed (any senior-to-junior counsel, including peer characters momentarily in the elder role).
3. For each scene, test markers 1-5 with quotes. For marker 1, restate the anecdote's point and the junior's current state side by side — precise mapping is the failure.
4. Build the mess ledger from the source's textures (doesn't apply / rambling / buried-elsewhere / realized-later / elder wrong / elder self-interested).
5. Rule each scene OPTIMIZED or HUMAN; check any didactic-register declaration in the reading guide before finalizing, citing it where applied.
6. Write per-scene verdicts, the chapter verdict, and revision orders in the required format to the output path.
7. Queue WISDOM-DISPENSER orders into the current revision round; record acceptance or rejection with reasons in the revision memo.
