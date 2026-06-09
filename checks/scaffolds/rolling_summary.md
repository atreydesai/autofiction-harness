# Scaffold: Rolling Summary + Memory Packet

artifact: {workspace}/summaries/chapter_NN.md (per-chapter summaries) + {workspace}/summaries/rolling.md (the current rolling synopsis / memory packet)
purpose: maintained memory objects for long-form generation — models are unreliable at retrieving buried information from the middle of long contexts, so each drafting prompt gets a small, current state packet instead of the whole manuscript
created: after chapter 1 ("always after the first chapter, and aggressively once the draft crosses any context boundary")
updated: refresh the rolling summary after every scene or every 1,500-2,500 words, whichever comes first; per-chapter summary written at every chapter commit (staged-workflow step 9)
updated_by: orchestrator
source_ref: collation:6347-6381 [LLM creativity: story bibles, rolling summaries, salience-based context injection] + collation:5762-5808 [Reddit 9 staged workflow steps 9-10] + collation:6600-6608 [canon-update prompt]

## Design rule (source, verbatim)

> The practical design pattern is to maintain several **small canonical objects** instead of one giant bible: a world-rules page, character delta sheets, unresolved-thread ledger, style ledger, and rolling synopsis. Then inject only the slices relevant to the current scene.

> The main trade-off is context bloat. A giant story bible becomes low-salience sludge and can make the model *less* reliable, not more. The goal is not "maximum background," but "minimum state required for the next valid move." In practice, that means aggressively pruning stale memory and refreshing the rolling summary after every scene or every 1,500–2,500 words, whichever comes first.

## Per-chapter summary template

After each chapter commits (Reddit 9 step 9: "Write a short chapter summary."; canon-update prompt: "chapter summary in 120 words"):

```
CHAPTER <NN> SUMMARY (~120 words)
- events: <placeholder — what happened, in causal order>
- state changes: <placeholder — character deltas, injuries, object locations, relationship shifts>
- open threads touched: <placeholder — thread-ledger ids advanced, deepened, or seeded here>
- knowledge state: <placeholder — who learned what; who still doesn't know what>
- carried forward: <placeholder — anything the next chapter must not contradict>
```

The previous chapter's summary is a required ingredient of the next chapter's draft prompt (Reddit 9 staged workflow).

## Rolling memory packet template

The packet injected into drafting prompts. Source's worked example, verbatim:

```text
<canon_memory>
<world_rules>
- Debt contracts are hereditary unless broken by sanctuary law.
- Tide calendars determine legal travel windows.
</world_rules>

<character_delta name="Sera">
- current public goal: protect her brother
- hidden goal: reach sanctuary before winter court
- new contradiction: she now needs the magistrate she despises
- voice notes: clipped syntax under pressure, visual attention to hands and fabric
</character_delta>

<unresolved_threads>
- stolen ledger missing since Chapter 2
- abbey bell heard underwater, unexplained
- vow made to Yune: "I won't leave you to debt"
</unresolved_threads>

<style_ledger>
- imagery clusters so far: salt, linen, rust, votive flame
- avoid overusing "cold" and "silence"
</style_ledger>
</canon_memory>
```

Populate each block from the dedicated artifacts: world_rules from the canon sheet/world bible, character_delta from the character snapshots' current state, unresolved_threads from the thread ledger, style_ledger from the style sheet + tic tally. **Inject only the slices relevant to the current scene.**

## When it refreshes

- after every scene or every 1,500-2,500 words, whichever comes first (rolling packet)
- at every chapter commit (per-chapter summary + canon update: chapter summary, character delta sheets, new world facts, revised unresolved-promises ledger)
- prune aggressively: drop stale deltas and resolved threads from the packet — minimum state required for the next valid move
