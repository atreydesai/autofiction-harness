# Audit: Arc-Position Audit (does the chapter know its act?)

id: arc_position | owner: codex | tier: risk
trigger: cadence:per-act
output: {audit_root}/codex/arc_position_{act}.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4399+ [Reddit 5 Fix 4 think in arcs]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

**Fix 4: Think in Arcs, Not Scenes.** This is where most model-drafted writing falls
apart at the macro level. Applied verbatim:

* The model has no concept of story structure. It doesn't know you're in Act 1 or
  Act 3. It doesn't know that tension should escalate before it peaks. **Every scene
  starts from the same emotional baseline.**
* You have to be the architect. The model is a great builder but a terrible planner.

The source's phase-temperature language, which each chapter must legibly inhabit:

* "We're in the early phase. Conflicts are emerging but not confronted yet. Keep things simmering."
* "We're approaching the midpoint. Tensions should start surfacing. Alliances get tested."
* "We're building toward the climax. Everything should feel like it's converging."

The model doesn't need a detailed outline; it needs to know the *temperature* of the
story right now. In this harness, the architect's plan is {skeleton}: each chapter has a
position, a phase, and a function. This audit runs per act and asks, chapter by chapter:

1. **Phase match.** Does the chapter's pressure level and function match its {skeleton}
   position? An Act-1-temperature chapter (conflicts emerging, simmering) sitting in the
   convergence run-up is a finding; a premature confrontation in the simmer phase is a
   finding.
2. **Baseline reset (the signature failure).** Does the chapter start from the same
   emotional baseline as if nothing has accumulated — characters at default calm,
   tensions reintroduced from zero, prior-chapter weight absent from the opening scenes?
3. **Stakes escalation.** For each major character in the act: are their stakes in this
   chapter **higher than the same character's stakes three chapters ago**? Compare
   what they stand to lose, concretely, at both points. Flat or shrinking stakes outside
   a card-licensed breather chapter is a finding.

## Required verdict format

Per chapter in the act:

- `ON-ARC — chapter <NN> — skeleton phase/function: <quoted from {skeleton}> — pressure evidence quoted — function performed: <named>`
- `BASELINE-RESET — chapter <NN> — opening quoted — the accumulated weight it ignores: <named, with the prior chapter's closing pressure quoted>`
- `OFF-PHASE — chapter <NN> — skeleton phase: <quoted> — delivered temperature: <early-simmer | midpoint-surfacing | climax-convergence | post-peak> — evidence quoted`

Stakes block, per major character:

- `STAKES — <character> — chapter <NN>: <what they stand to lose, quoted/derived> vs chapter <NN-3>: <same> — verdict: ESCALATED | FLAT | SHRUNK (breather-licensed: <card quote or no>)`

Act verdict: `KNOWS-ITS-ACT` only if zero BASELINE-RESET, zero OFF-PHASE, and no
unlicensed FLAT/SHRUNK stakes; otherwise `ARC-BLIND`. A passing verdict must still name
the chapter closest to a baseline reset and quote why it escapes. `REVISION ORDERS`:
per finding, a numbered order — rewrite the opening to carry accumulated pressure
(name what it carries), retune the chapter's temperature to its skeleton phase (name
the beats to add/cut), or raise the named character's stakes (name the new concrete
loss exposure).

## Procedure

1. Load the act's chapters, {skeleton} (phase, position, and function per chapter), the
   chapter cards (breather licenses), and the closing pages of the chapter preceding
   the act.
2. For each chapter, quote its skeleton phase/function, then judge delivered
   temperature from the page; classify ON-ARC / OFF-PHASE.
3. Check each chapter's opening scene against the prior chapter's closing pressure;
   classify BASELINE-RESET where accumulation is absent.
4. For each major character, build the stakes comparison against the same character
   three chapters earlier; classify ESCALATED / FLAT / SHRUNK and check breather
   licenses.
5. Write per-chapter verdicts, the stakes block, the act verdict, and the revision
   orders in the Required verdict format.
6. Write the completed audit to {audit_root}/codex/arc_position_{act}.md. An ARC-BLIND
   act routes its orders into the act's revision plan before the next act is drafted.
