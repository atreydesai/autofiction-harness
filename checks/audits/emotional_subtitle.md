# Audit: Emotional-Subtitle Audit (dialogue + redundant label)

id: emotional_subtitle | owner: codex | tier: risk
trigger: watch:emotional-subtitle
output: {audit_root}/codex/chapter_{NN}.emotional_subtitle.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4142-4147 [field guide 18]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The source entry (field guide 18, THE EMOTIONAL SUBTITLE), faithful to the text:

> AI doesn't trust its own dialogue. When a character says something that clearly communicates fear, anger, grief, or any other emotion, the AI attaches a physical sensation or narrator label to make sure you got it. Examples: Her hands trembled. "Please don't go." His jaw clenched, anger rising in his chest. "I said no." A wave of grief washed over her. "She's gone, isn't she." His voice was barely a whisper, fragile and uncertain. "Do you still love me?"
>
> In each case the dialogue already carries the emotion. "Please don't go" is desperation. "I said no" is anger. "She's gone, isn't she" is grief. The narrator adds the trembling hands, the clenching jaw, the wave of grief, the fragile whisper — not because the reader needs them but because the AI doesn't believe the dialogue landed. It's the prose equivalent of a laugh track. The character delivers the line. The narrator tells you how to feel about it.
>
> The test is simple: cover the stage direction with your hand. Read the dialogue alone. If the emotion is obvious, the stage direction is a subtitle on a film that's already in your language. Cut it.

Operational criteria:

1. **Subtitle pairs.** Every dialogue line adjacent (before or after, same beat) to a physical sensation or narrator emotion-label: trembling hands, clenched jaw, tightening chest/throat, racing heart, waves of [emotion], voice descriptions (barely a whisper, fragile, cold, hard), and explicit labels (anger rising, fear creeping).
2. **The cover test, per pair.** Read the dialogue alone. If the emotion is obvious from the line, the stage direction is a subtitle → cut. If the dialogue alone is ambiguous and the body beat disambiguates, it is doing work.
3. **Information-adding beats are not subtitles.** A body beat that CONTRADICTS the line (calm words, shaking hands), adds new information (who notices, what it costs to say), or carries blocking the scene needs, passes. Redundancy is the failure, not body language itself.
4. **Aggregate laugh-track density.** Even pairs that individually pass can accumulate; if most emotional lines in a scene carry a body escort, the narrator does not trust the dialogue. Report density per scene.

## Required verdict format
Per subtitle pair:
- `SUBTITLE — "<stage direction>" + "<dialogue line>" (location) — cover test: dialogue alone reads as <emotion> — direction adds: NOTHING — order: CUT`
- `WORKING — "<stage direction>" + "<dialogue line>" — adds: <contradiction | new information: what | blocking: what>`

Per scene: `DENSITY <scene id>: <n> emotional lines, <m> escorted (<m/n>%) — verdict: TRUSTED | LAUGH-TRACK`

Chapter verdict:
- `DIALOGUE-TRUSTED` — no SUBTITLE pairs and no LAUGH-TRACK scene. Must still quote the closest call: the WORKING pair nearest to redundancy, and what saved it.
- `SUBTITLED (<n> pairs, <m> laugh-track scenes)`.

`REVISION ORDERS:` one per SUBTITLE pair: quote the pair, order the cut of the stage direction (default), or — where the beat carries needed blocking — order its replacement with non-emotional blocking. For LAUGH-TRACK scenes, name which escorts to cut to bring the scene under trust. Orders may not swap one body cliché for another.

## Procedure
1. Load the chapter, the mechanical watch counts for `fieldguide-emotional-subtitle` ({watch_counts}), {reading_guide} register notes, and {calibration} if present. The watch pattern is a best-effort adjacency heuristic (dialogue + body-reaction keyword on the same line, either order); it produces leads, not verdicts. Verify each hit in context, discard false positives by name, and sweep for pairs the regex missed (beats on adjacent lines, label-only escorts with no body keyword).
2. Build the full subtitle-pair inventory across the chapter, including pairs not surfaced by the watch.
3. Run the cover test on each pair: read the dialogue alone, name the emotion it carries unaided, then rule what the stage direction adds (NOTHING / contradiction / new information / blocking).
4. Compute per-scene escort density and rule TRUSTED or LAUGH-TRACK per scene.
5. Issue per-pair verdicts, scene densities, the chapter verdict, and revision orders in the required format; write to the output path.
6. Queue SUBTITLED orders into the current revision round; record acceptance or rejection with reasons in the revision memo.
