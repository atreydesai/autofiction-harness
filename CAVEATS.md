# CAVEATS — The Harness's Calibration Philosophy

The checks in this repository are deliberately tiered, deliberately incomplete as detectors, and deliberately suspicious of their own zeal. The source corpus this harness was distilled from contains explicit caveat and limitation entries, and they are binding on every check. This file holds those entries verbatim, each with its source reference, followed by a short statement of how the harness applies them.

---

## 1. The Safety Rails

> source_ref: collation:2860-2873 [Writing ruleset — Safety rails]

> ## Safety rails
>
> These are not AI tells by themselves: em dashes, semicolons, `however`, competent punctuation, well-formed paragraphs, and the right word even if it appears on somebody's banned list.
>
> Do not invent typos. Do not break grammar on purpose. Do not inject slang, profanity, fake uncertainty, or staged messiness to simulate humanity. No mandatory `actually` turn. No manufactured negativity. No programmatic sentence-length wobble. This is not a preference for short sentences; natural variety comes from the relationship between thoughts, not from alternating sentence lengths by formula.
>
> Do not make text less usable or less accessible in the name of sounding less AI-written. Removing needed headings, lists, descriptive links, citations, caveats, or next steps is not a style improvement.
>
> The recurring problem is regularity and mismatch, not any one feature. Use em dashes where they belong; do not reach for them as a default connective. If you keep using the same punctuation move in the same role, vary it rather than banning it. In casual internet prose, paragraph-after-paragraph em dashes are now a socially recognized AI cue, so prefer commas, colons, conjunctions, subordinate clauses, or full stops unless the dash clearly earns its keep. A full stop is not the automatic replacement; sometimes the fix is to make the relationship between the clauses clearer. For temporary compound modifiers, hyphenate before the noun and usually open after it; do not let the model turn every compound into a hyphenated unit.

**Harness enforcement note.** The quality-gate engine (checks/quality_gate.py + checks/patterns/*.tsv) enforces these rails as policy, not as advice: em dashes, semicolons, and "however" may only ever appear in CAP or WATCH rows, never BANNED. Em-dash density is a CAP (reddit2-emdash-density, with the dialogue-interruption exception row reddit2-emdash-dialogue-good); "however" and the other competent connectives have no blocking row anywhere in the registry (signpost-opener density is WATCH-only); single common words downgraded from source ban lists (e.g., "steel", "finally") carry an explicit "safety rail: never BANNED" note in their TSV rows. No check in this harness ever orders fake typos, broken grammar, or staged messiness as a remedy.

---

## 2. The Accumulation Principle — Density, Not Single Instances

> source_ref: collation:1180-1212 [BANNED — The Accumulation Principle]

> ### **The Accumulation Principle**
>
> No single banned element makes prose bad. One "jaw tightens" is fine. One trailing participle is fine. One "something shifted" might even be the right choice in context.
>
> The problem is accumulation.
>
> When the same constructions, the same physical tells, the same vague interiority placeholders appear over and over—across characters, across scenes, regardless of context—the prose flattens. It stops feeling like a specific story about specific people and starts feeling like it was assembled from a bag of interchangeable parts.
>
> This is the actual AI tell. Not any single word or phrase, but the *density of defaults*. AI writing sounds like AI writing because it reaches for the statistically common option every time. It doesn't know to vary. It doesn't know that one character's stress response should look different from another's. It doesn't know that the third "silence stretched between them" in a chapter has lost all power. It just keeps generating the highest-probability completion.
>
> Human writers fall into the same trap—reaching for familiar constructions on autopilot, defaulting to the first phrase that comes to mind. The result is identical: prose that reads as generated rather than written.
>
> **The Test:**
>
> When you catch a banned element, don't just ask "is this bad?" Ask:
>
> * How many times have I used this in the last ten pages?
> * Have I used it for multiple characters interchangeably?
> * Is this the first appearance (possibly fine) or the fifth (definitely a pattern)?
>
> A single "the weight of it settled in his chest" might work. The third one in a chapter means you're leaning on a crutch.
>
> **The Corollary:**
>
> This also means witch-hunting individual constructions is pointless. Someone who flags every em-dash or every "And" sentence-start as "AI writing" has missed the point. The question isn't whether a construction appears—it's whether it appears *reflexively, repeatedly, and interchangeably*.
>
> Density. Pattern. Accumulation. That's what to watch for.

---

## 3. Why the Patterns Exist — Root Cause Statements

### 3a. They Simulate Rather Than Create

> source_ref: collation:1456-1465 [BANNED — They Simulate Rather Than Create]

> ### **They Simulate Rather Than Create**
>
> * Rhythm that sounds literary but carries no meaning
> * Gestures that look like emotion but specify nothing
> * Metaphors that feel poetic but clarify nothing

### 3b. The Root Problem + They Default to Familiar

> source_ref: collation:2333-2352 [BANNED — 3.1 THE ROOT PROBLEM; They Default to Familiar]

> ## **3.1 THE ROOT PROBLEM**
>
> All banned constructions, words, and phrases fail for the same reasons:
>
> ### **They Default to Familiar**
>
> * Reach for the first phrase that comes to mind
> * Rely on reader recognition of trope rather than earned response
> * Substitute genre convention for character-specific behavior

### 3c. 3.9 The Operating Principle

> source_ref: collation:2146-2163 [BANNED — 3.9 THE OPERATING PRINCIPLE]

> ## **3.9 THE OPERATING PRINCIPLE**
>
> This guide is not about restriction—it's about clearing space for the story that actually matters.
>
> Every banned element is a shortcut that prevents the writer from doing the harder, better work of:
>
> * Figuring out what's actually happening
> * Understanding how this specific character would respond
> * Building tension through structure rather than announcing it through diction
> * Trusting the reader to feel what's been earned rather than being told what to feel
>
> The bans exist to force precision. The precision serves the story.

### 3d. 3.10 The AI Pattern Problem

> source_ref: collation:1865-1881 [BANNED — 3.10 THE AI PATTERN PROBLEM]

> ## **3.10 THE AI PATTERN PROBLEM**
>
> Beyond bad craft, many banned patterns are identifiable AI tells. This matters for two reasons:
>
> **1\. Detection Risk** Readers increasingly recognize AI-generated prose. Patterns that signal AI origin break immersion and undermine trust in the narrative voice.
>
> **2\. The Underlying Failure Is the Same** AI defaults to statistically common patterns because it lacks specific knowledge of character, scene, and consequence. When human writers use the same patterns, they're making the same error—substituting generic rhythm for specific meaning.
>
> The AI detection problem and the craft problem share a root cause: regression to the mean. AI writing sounds like AI writing because it's averaging across millions of texts. Human writing that sounds like AI writing is doing the same thing unconsciously.
>
> **The corrective is identical:** Be specific. Ground every description in character perception. Make every gesture do work. Let consequence emerge from action rather than being announced by narration.

---

## 4. The Em Dash — The Dose Makes the Poison

> source_ref: collation:95-136 [Reddit thread 2: em dash — TL;DR]

> TL;DR
> Remember that the dose determines the poison. If there's another way to phrase your sentence or show specificity, use it. If it's only peppered through your prose in key areas, the em dash is not inherently a sign of AI. Make the em dash work for its place of honor on the page.
> If you think I’m off, or missed something, please comment below! Collectively, we can tackle this issue and get good at editing the AI.

The same source names the legitimate home of the em dash explicitly — dialogue interruptions and stutters ("Aiko—!"; "I—I just grabbed whatever") are the *good* use, which is why the harness's em-dash density CAP is scoped to narration and subtracts dialogue-interruption hits before counting (source_ref: collation:116-126 [Reddit thread 2: em dash — Interruptions]).

---

## 5. Provenance, Detectors, and Over-Correction

### 5a. This harness is not a detector

> source_ref: collation:7512-7521 [Writing ruleset — Scope; under "Provenance, authorship adjudication, detector caveats, and over-correction warnings"]

> ## Scope
>
> This document is for drafting and revising text. It is not a reliable method for deciding whether existing text was written by a human or an AI, and it is not an authorship-adjudication tool. In high-stakes settings, provenance beats surface style; see `Provenance in high-stakes contexts` below.

The same applies to this harness: the pattern registries and audits exist to *revise drafts*, not to adjudicate authorship of anyone's text. Surface style is weak evidence; do not repurpose these checks as an accusation engine.

### 5b. The curly-quote caveat

> source_ref: checks/sources/wikipedia_signs_of_ai_writing.md [WP:AICURLY — Curly quotation marks and apostrophes]

> Curly quotes alone do not prove LLM use. Directional quotation marks (curly or typographer) are often used in published works written and edited using the Chicago Manual of Style.[27] Microsoft Word has a "smart quotes" feature that converts straight quotes to curly quotes. So does the default system-wide configuration on macOS and iOS devices, except on some applications (or if turned off, as may be necessary for programming). Grammar correcting tools such as LanguageTool may also have such a feature. Curly quotation marks and apostrophes are common in professionally typeset works such as major newspapers. Citation tools like Citer may repeat those that appear in the title of a web page: for example,
> McClelland, Mac (2017-09-27). "When ‘Not Guilty’ Is a Life Sentence". The New York Times. Retrieved 2025-08-03.
> Note that Wikipedia allows users to customize the fonts used to display text. Some fonts display matched curly apostrophes as straight, in which case the distinction is invisible to the user. Additionally, Gemini and Claude models typically do not use curly quotes.

This is why the harness check (wp-aicurly-quote-inconsistency) flags only *inconsistent mixing* of curly and straight quotes within one manuscript — never the mere presence of curly quotes — and why a Claude-drafted manuscript should not be expected to show this tell at all.

---

## 6. Evidence Limitations and Scope

### 6a. Open questions and limitations

> source_ref: collation:7485-7493 [Academic novel manual — Open questions and limitations]

> ### Open questions and limitations
>
> No report can specify your exact best process independent of genre, temperament, and life constraints. Discovery-heavy writers and architectural planners both produce excellent novels, and the evidence supports structured practice and revision more strongly than it supports any one planning ideology. Treat the method choices below as tools to test, not dogmas to obey. citeturn30view1turn32view0turn39view0

### 6b. Scope and source base

> source_ref: collation:7496-7508 [LLM writing outputs report — Scope and source base]

> ## Scope and source base
>
> This report stays strictly at the level of **observable output**. It is about what readers, editors, teachers, and writers repeatedly notice in LLM prose, especially fiction: recurring diction, familiar rhetorical habits, flattening of voice, drift in long works, excessive agreeableness, and the practical prompt patterns people use to push output back toward sharper prose. The evidence base here mixes formal work on story generation, editing corpora, style imitation, writing feedback, diversity, and sycophancy with informal but often highly detailed practice reports from writer communities, prompt-engineering forums, and fiction-writing tool documentation. Formal sources are especially useful for what can be measured reliably. Informal sources are especially useful for what writers notice first, long before it appears in a benchmark. citeturn11view5turn11view0turn39view0turn34view1turn19view0turn31view2turn24view0turn24view1
>
> The strongest formal evidence is around **long-range coherence failures**, **homogenization and reduced diversity**, **stylistic idiosyncrasies that editors repeatedly remove**, **voice imitation limits**, and **sycophancy or positivity bias**. The weakest formal evidence is around some of the exact “AI smell” complaints common in fiction circles—such as em-dash overuse, the “it’s not X, it’s Y” construction, weak chapter endings, and sanitization of dark themes—where the best evidence is still mainly community observation, journalism, or tool-community documentation rather than large-scale fiction benchmarks. That gap matters: some of the most practically important complaints are well-established experientially before they are well-measured academically. citeturn14view0turn19view0turn19view1turn12view0turn12view1turn29view3turn28view4turn25search6turn25search10
>
> A final scope boundary is important. A fair amount of formal research improves story quality by using **fine-tuning, symbolic planning systems, retrieval pipelines, or specialized multi-stage architectures**. Those papers are still useful here because they indicate which output problems are real and which kinds of structure help. But whenever a paper’s actual intervention depends on training, model internals, or system-level augmentation, I treat it as **evidence about the problem** rather than as a recommended mitigation. The mitigations in this report are limited to what an ordinary user can do with prompting, context construction, examples, and conversational workflow. citeturn11view3turn11view4turn39view1

(The `citeturn...` strings are citation-marker artifacts preserved from the source file.)

### 6c. The collation's own De-duplication Register and Cross-Source Overlap Index

> source_ref: collation:37-59 [De-duplication Register; Cross-Source Overlap Index]

> ## De-duplication Register
>
> - Exact duplicate source sections removed by normalized text match: 0.
> - Similar but non-identical passages were retained as separate entries. Entries that disagree or qualify one another are kept side by side inside the same thematic cluster.
> - Related entries were placed under source-derived subheadings; no section text was shortened to make it fit a heading.
> - Each retained entry is tagged with its source tag in the entry heading. Source wording, examples, caveats, tables, and code blocks are preserved inside the entries.
>
> ## Cross-Source Overlap Index
>
> - **Em dashes / punctuation as AI cue and legitimate punctuation:** [AI-isms Bible], [Reddit thread 2: em dash], [LLM writing outputs report], [Writing ruleset], [BANNED], [Reddit thread 10: haunted prose field guide]
> - **"Not X, but Y" / contrast framing / negative parallelism:** [BANNED], [AI-isms Bible], [LLM writing outputs report], [Reddit thread 10: haunted prose field guide], [Writing ruleset]
> - **Rule-of-three / fragment lists / staccato dramatic rhythm:** [BANNED], [AI-isms Bible], [LLM writing outputs report], [Reddit thread 10: haunted prose field guide], [Writing ruleset]
> - **AI vocabulary clusters: delve, tapestry, nuanced, multifaceted, testament, pivotal/crucial/vital:** [BANNED], [AI-isms Bible], [LLM writing outputs report], [Writing ruleset], [Reddit thread 1: prose dials]
> - **Character specificity through behavior, voice, examples, stress response, wound, and contradiction:** [Reddit thread 3: character snapshots], [Reddit thread 4: character voice], [Novel process report], [Academic novel manual], [Reddit thread 9: AI writing workflow], [BANNED]
> - **Long-form continuity via story bible, character bible, world bible, summaries, memory packets, and logs:** [Reddit thread 9: AI writing workflow], [LLM creativity report], [LLM writing outputs report], [Reddit thread 7: living world], [Academic novel manual]
> - **Planning before prose / scene cards / chapter outline / chapter objective-conflict-revelation-close:** [Reddit thread 9: AI writing workflow], [LLM creativity report], [LLM writing outputs report], [Novel process report], [Academic novel manual]
> - **Example-based style transfer / demonstration beats specification / few-shot style anchors:** [Reddit thread 1: prose dials], [Reddit thread 8: demonstration beats specification], [LLM creativity report], [LLM writing outputs report], [Reddit thread 4: character voice]
> - **Negative constraints and banned-word lists with caveats:** [BANNED], [AI-isms Bible], [LLM writing outputs report], [Writing ruleset], [Reddit thread 1: prose dials]
> - **Pacing, unresolved threads, complication, yes-but/no-and, seeds and payoff:** [Reddit thread 5: pacing], [Reddit thread 6: challenge/consequences], [LLM creativity report], [Novel process report], [Academic novel manual]
> - **World as constraint / NPC goals / meanwhile prompt / consequences ripple:** [Reddit thread 7: living world], [Reddit thread 6: challenge/consequences], [Novel process report], [Academic novel manual], [Reddit thread 9: AI writing workflow]
> - **Revision staged from macro to line/copy/proof / beta readers / critique calibration:** [Academic novel manual], [Novel process report], [LLM writing outputs report], [Reddit thread 9: AI writing workflow], [BANNED], [Writing ruleset]
> - **Publication/submission/self-publishing/hybrid publishing workflows:** [Academic novel manual], [Novel process report]
> - **Limitations, caveats, scope, provenance, and surface-style non-determinism:** [Writing ruleset], [BANNED], [LLM writing outputs report], [LLM creativity report], [Reddit thread 2: em dash], [Reddit thread 1: prose dials]

---

## 7. How the Harness Applies These

- **Tiers exist because of items 1-2.** BANNED is reserved for constructions the sources ban with no allowable form (chat leakage, placeholder blanks, the negation formula). CAP and WATCH exist because the Accumulation Principle says the real tell is *density of defaults*, not any single hit — so common words and legitimate punctuation are counted and capped, never blocked outright, and the Safety Rails make that a hard policy: em dashes, semicolons, "however", and competent prose features can only ever be CAP or WATCH.
- **Judgment audits exist because most rules are context-dependent.** A regex can count the syntactic frame of a superficial analysis or a significance claim; it cannot decide whether the analysis is vacuous, the significance unearned, or the consensus claim undramatized. Those calls go to the audits (checks/audits/), which inherit the sources' own caveats and allowable forms rather than treating every hit as a violation.
- **The allowlist and the Character-Voice-vs-Ban-List exception exist because the sources themselves demand register exceptions.** Dialogue may legitimately contain what narration may not (interrupting em dashes, weaseling characters, "Of course!"); a character voice card may claim a banned term; a reading-guide register may recalibrate a CAP threshold. Every exception is taken on the record, with a defended justification — never silently — because the same sources that grant the exceptions also warn against over-correction: do not make the prose worse, falser, or less usable in the name of seeming less AI-written.
