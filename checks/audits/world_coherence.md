# Audit: World-Coherence Thought Experiment

id: world_coherence | owner: claude | tier: book
trigger: phase:mid-run + phase:full-book-critique
output: {audit_root}/claude/book.world_coherence.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:5337-5345 [Reddit 7: A Little Thought Experiment]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Source, verbatim:

> A Little Thought Experiment
> Think about the last town your character visited. Can you picture what's happening there right now, even though you're not there?
> If the answer is yes, your world is alive. If the answer is "I have no idea, I left and the AI forgot about it," try these fixes. The difference is night and day.
> I sometimes pause my main gameplay to simulate the world advancing. That's fun too, honestly.

Book-level question: **would this world keep running if the protagonist vanished?** Run the thought experiment against the manuscript as written — the page evidence, not the trackers' aspirations.

1. **Departed-location test.** For every significant location the protagonist has left, answer the source question: can you state, FROM PAGE EVIDENCE, what is happening there "right now" (at the current point in {timeline})? "I have no idea" = that location died on exit.
2. **Vanishing-protagonist test.** Remove the protagonist mentally. Which conflicts, schemes, and pressures still proceed? List every faction/antagonist/secondary character whose entire activity is reactive to the protagonist — those are stage machinery, not world.
3. **Pre-existence test.** Per the Schrödinger framing ("No sense that things were happening before you showed up"): does the manuscript show things that were already in motion before the protagonist arrived at each major location (feuds mid-fight, construction half-done, grief half-grieved)? Quote instances or mark absent per location.
4. **Cross-audit synthesis.** Aggregate the verdicts of npc_offscreen_goals, meanwhile_audit, time_visibility, and ripple_effects since the last run. Repeated FROZEN/STAGE-PLAY/DEAD-JUMP/FORGOTTEN findings are the symptoms; this audit names the disease at book level.

## Required verdict format

Per location: `<LOCATION>: ALIVE | DEAD-ON-EXIT — "what's happening there now": <one sentence, with citing quote from ch NN> or "NO IDEA"`
Per actor/faction: `<NAME>: SELF-PROPELLED | PROTAGONIST-REACTIVE — evidence: "<quote>"`
Pre-existence: `<LOCATION>: WAS-RUNNING ("<quote>") | SPAWNED-ON-ARRIVAL`

A passing line must name what you checked and quote the strongest counter-candidate (the most suspiciously convenient sign of life you almost rejected).

Close with:
1. **Book verdict:** WORLD-ALIVE / WORLD-HOLLOW (majority dead-on-exit or protagonist-reactive) / STAGE-PLAY (world exists only where the protagonist stands).
2. **Revision orders:** ranked list — for each dead location and reactive faction, one concrete world-advancing intervention (a meanwhile beat to seed, an {npc_goals} trajectory to add, a ripple to thread into a named chapter). Orders feed the next revision queue and the meanwhile ledger; "make the world feel more alive" is not an order.

## Edge cases and calibration

- **Intentionally closed worlds:** a single-room chamber drama or a sealed-bunker novel has a legitimately tiny world. Scale the location list to what the book establishes; do not invent an obligation to worldbuild. But anything the book DID establish and then abandoned still counts.
- **Reactive-by-design antagonists:** an antagonist whose plan is genuinely about the protagonist (a stalker, a rival heir) is allowed to be protagonist-focused — but must still have a life outside the obsession (income, allies, habits). Judge the texture, not the target.
- **Mid-run vs full-book passes:** the mid-run pass weights revision orders toward upcoming chapters (cheap fixes); the full-book pass weights toward retrofit beats in existing chapters and must rank orders by cost.
- **Evidence standard:** one quoted line per verdict minimum; an inference chain without any quote is not page evidence.

## Prompt template (owner=claude)

You are auditing a novel manuscript for world coherence. You are a skeptical professional editor; apply the Critique stance above in full.

Inputs: the manuscript so far ({manuscript_glob}), {timeline}, {npc_goals}, meanwhile_ledger.md, the continuity tracker, and all prior npc_offscreen_goals / meanwhile_audit / time_visibility / ripple_effects reports under {audit_root}.

Run the thought experiment: "Think about the last town your character visited. Can you picture what's happening there right now, even though you're not there?" — and extend it to every significant departed location, then to the book-level question: would this world keep running if the protagonist vanished?

Work in this order:
1. List every significant location and recurring actor/faction with chapter ranges of appearance.
2. Apply the departed-location, vanishing-protagonist, and pre-existence tests, quoting page evidence verbatim for every verdict line. Trackers do not count as page evidence — they tell you what SHOULD be alive; only quotes prove it is.
3. Synthesize prior sibling-audit findings into the diagnosis.
4. Emit the verdict block exactly in the Required verdict format, then the ranked revision orders.

Do not soften. A world that is alive in the trackers and dead on the page is WORLD-HOLLOW. Write the report to the output path.
