# Audit: Consequence Test (scene state-change)

id: consequence_test | owner: codex | tier: core
trigger: every-chapter
output: {audit_root}/codex/chapter_{NN}.consequence_test.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4376-4378 [BANNED Consequence Test] + 4383-4391 scene-level craft

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The source test, applied verbatim:

* Does something change because of this scene / beat / line?
* If nothing changes, the scene isn't done.

The scene is the smallest unit that should normally change the novel's state. If nothing
meaningfully changes — **knowledge, power, intimacy, commitment, danger, social standing,
or self-understanding** — the passage may still be beautiful prose, but it is not doing
adequate narrative work. Scene writing becomes technically easier when five things are
defined: **whose scene it is, what they want, what resists them, what turns, and what
decision or condition exits the scene**. Cause and effect must be visible not only across
acts but across paragraphs.

Two functional scene types (a scene should be one or the other, and they chain into each
other):

1. **Proactive scene: Goal–Conflict–Setback.** The POV character enters with a goal,
   opposition appears, conflict escalates through failed attempts, and the scene exits on
   a setback or costly partial win.
2. **Reactive scene: Reaction–Dilemma–Decision.** Emotional reaction to the prior
   setback, a dilemma with no clean option, and a decision that becomes the next scene's
   goal.

A scene that is neither — no objective, no interference, no changed condition at the
end — is static exposition, however polished. Also check entry/exit logic: enter as late
as possible while preserving orientation; exit as soon as the turn has happened and the
reader can project forward. A scene that continues past its state-change is a finding
even if the state-change exists.

Quiet scenes are not automatic failures: a reactive scene's state-change may be entirely
internal (a decision, a shift in self-understanding, a commitment made or broken). But
the change must be locatable in the text — quotable — not inferred charitably.

## Required verdict format

One verdict line per scene in the chapter:

- `STATE-CHANGED(<dimension>) — scene <n> (<first line quoted>) — type: <proactive|reactive> — change: <one sentence naming what is different after the scene, with the quoted lines where the change registers>`
  where `<dimension>` is one or more of: knowledge / power / intimacy / commitment /
  danger / social standing / self-understanding.
- `INERT — scene <n> (<first line quoted>) — strongest candidate change considered: <quote> — why it fails: <the candidate is decor, restatement, or already true before the scene>`

For every STATE-CHANGED scene, also note `EXIT: ON-TURN` or `EXIT: OVERRUNS (<quoted
material after the turn>)`.

Chapter verdict: `ALL-SCENES-CHANGE` (only if zero INERT; still list the weakest
STATE-CHANGED scene and why it survives) or `INERT-FOUND`.

`REVISION ORDERS`: one numbered order per INERT scene (give it a goal/resistance/turn,
fold it into an adjacent scene, or cut it) and per OVERRUNS exit (cut point named).

## Procedure

1. Load the chapter text and the chapter card; segment the chapter into scenes (location/
   time/POV breaks). Number them.
2. For each scene, identify whose scene it is, what they want, what resists them, what
   turns, and what decision or condition exits the scene. Classify proactive
   (Goal–Conflict–Setback) or reactive (Reaction–Dilemma–Decision); a scene that is
   neither is presumptively INERT.
3. Apply the Consequence Test: name what changes — knowledge, power, intimacy,
   commitment, danger, social standing, self-understanding — and quote the lines where
   the change registers on the page. If you cannot quote it, the verdict is INERT.
4. For INERT verdicts, quote the strongest counter-candidate you considered and state
   why it fails (decoration, restatement of an existing state, or atmosphere).
5. Check exit logic on every scene: mark OVERRUNS where text continues past the turn.
6. Write per-scene verdicts, the chapter verdict, and the revision orders in the
   Required verdict format.
7. Write the completed audit to {audit_root}/codex/chapter_{NN}.consequence_test.md. If
   the chapter verdict is INERT-FOUND, the chapter is not committable until the orders
   are executed or rejected with reasons in the revision memo.
