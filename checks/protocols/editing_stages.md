# Protocol: Editing Stages and Sequencing

purpose: defines the editorial stage order for the harness — macro before scene, scene before line, line before copy, copy before proof — plus the style-sheet artifact and the timeline model; macro-before-line ordering is the spine of every revision schedule
runs: governs the editor stage's pass ordering and the orchestrator's revision-round scheduling; consulted whenever a pass is added, reordered, or skipped
source_ref: collation:6827-6838 [Scene revision and line editing], 6841-6885 [Copyediting and proofreading], 6919-6925 [Revision, Editing, and Collaborative Feedback], 6929-6958 [Editing stages compared], 7298-7314 [Compound-modifier hyphenation], 7013-7046 [Illustrative milestone timeline]. Inline citation-marker artifacts from the source research reports (e.g. "citeturn…") have been removed; the text is otherwise verbatim.

## The ordering principle, verbatim

> ## Revision, Editing, and Collaborative Feedback
>
> Revision should proceed from largest problem to smallest. If you line-edit a chapter whose structural role will later disappear, you are polishing waste. The EFA and Jane Friedman are aligned on this point: developmental work addresses content, organization, and genre expectations; line editing addresses language and style at the sentence and paragraph level; copyediting handles grammar, usage, punctuation, and consistency; proofreading is a final prepublication check and is not the same thing as editing.

## Scene revision and line editing, verbatim

> ### Scene revision and line editing
>
> Once structure is defensible, move to the scene level. Ask of every scene: why does it exist; what is its pressure point; what exactly changes; what information does the reader gain; and could the same function be achieved more economically elsewhere? If a scene provides atmosphere, backstory, and voice but no change, either intensify its conflict or cannibalize its useful material into a scene that does change something. Because setting, POV, and symbolism all operate at scene scale, this is also where you sharpen recurring motifs, tune discourse distance, and ensure that description belongs to the perceiving consciousness.
>
> Line editing begins only after structural and scene-level decisions are mostly stable. The Editorial Freelancers Association defines line editing as sentence- or paragraph-level work focused on language and style; the main concern is not just correctness but how the prose moves. In fiction, line editing asks whether syntax, rhythm, diction, metaphor, emphasis, paragraphing, and repetition are serving the narrative stance. It also asks whether an individual sentence is doing the right job. A sentence can be beautiful and still be wrong for its location.
>
> Technically, line editing is where you hear the book. Read aloud. Mark where the sentence’s stress position falls. Watch for repeated sentence openings, weak verb clusters, unwanted abstraction, accidental cliché, overwritten gesture beats, and paragraphs that begin at the wrong conceptual level. If voice is a priority, examine not just elegance but **fit**: does this sentence sound like the narrator, the viewpoint consciousness, and the emotional temperature of the moment? Elbow’s account of voice is useful here not as drafting advice only, but as a reminder that living prose often begins in fluency and is later refined, not manufactured through sterile caution alone.

## Copyediting and proofreading, verbatim

> ### Copyediting and proofreading
>
> Copyediting is not line editing, and proofreading is not copyediting. The CIEP’s and EFA’s current definitions are unusually clear. In the conventional workflow, developmental or structural editing comes first; copyediting follows once final content is substantially agreed; proofreading happens after design and layout as the final quality check. If you reverse that order, you waste money and create fresh errors.
>
> Copyediting focuses on grammar, punctuation, spelling, consistency, formatting, and clarity at the level of publishable correctness. It should also produce or maintain a **style sheet** recording spelling decisions, hyphenation, capitalization, numerals, timeline notes, recurring character facts, and any idiosyncratic stylistic rules your novel uses intentionally. A novel with multiple foreign terms, special calendars, epistolary elements, or fantasy proper nouns especially needs this.
>
> Proofreading happens on the designed proof or final formatted file, not on the unstable manuscript. According to CIEP, proofreaders check both words and layout, catching typographical and formatting problems missed earlier or introduced during design. That means if you self-publish, you should proofread the actual EPUB/PDF/print proof, not assume a clean Word file guarantees a clean book.

The same section's part-time timeline model, verbatim:

> ```mermaid
> gantt
>     title Illustrative part-time timeline for a 90,000-word novel
>     dateFormat  YYYY-MM-DD
>     section Development
>     Idea and premise testing      :a1, 2026-01-05, 14d
>     Research and architecture     :a2, after a1, 28d
>     section Draft
>     First draft                   :b1, after a2, 112d
>     Cooling interval              :b2, after b1, 14d
>     section Revision
>     Macro revision                :c1, after b2, 35d
>     Beta feedback                 :c2, after c1, 21d
>     Scene revision                :c3, after c2, 28d
>     Line edit                     :c4, after c3, 21d
>     Copyedit and proof            :c5, after c4, 21d
>     section Submission
>     Query, synopsis, formatting   :d1, after c5, 21d
> ```
>
> This timeline is an illustrative planning model, not a universal prescription. It reflects the evidence that skilled writing is recursive, revision-heavy, and better served by spaced practice than by compressed emergencies.

The source's stage-comparison table from the same section:

> | Stage | Primary question | Typical tasks | When to do it | Common mistake |
> |---|---|---|---|---|
> | Developmental or structural revision | Does the book fundamentally work? | Architecture, plot, arc, POV system, pacing, stakes, world logic | After full draft | Polishing sentences before fixing structure |
> | Scene revision | Does each scene earn its space? | Cut/combine scenes, sharpen turns, rebalance exposition, tighten dialogue | After macro revision | Keeping atmospheric filler scenes |
> | Line editing | Does the prose carry the story well? | Rhythm, clarity, emphasis, continuity of voice, paragraph design | After scene list is mostly stable | Confusing line beauty with scene necessity |
> | Copyediting | Is the text correct and consistent? | Grammar, punctuation, spelling, style sheet, consistency, formatting | After content is final | Copyediting a manuscript still undergoing major chapter changes |
> | Proofreading | Is the final designed file clean? | Typos, layout issues, widows/orphans, formatting glitches, missed corrections | After layout or final ebook/print conversion | Treating proofreading as a substitute for editing |

Style-sheet artifact in the harness: the editor stage maintains a living style sheet file recording exactly what the spec above names — spelling decisions, hyphenation, capitalization, numerals, timeline notes, recurring character facts, and intentional idiosyncratic rules. Copyedit-tier passes read it before editing and update it after; consistency findings that contradict the style sheet are fixed toward the sheet, not ad hoc.

## Editing stages compared, verbatim

> ### Editing stages compared
>
> | Stage | Main question | Typical output | Do not use this stage for |
> |---|---|---|---|
> | **Developmental edit** | Does the book work as a book? | Editorial letter, manuscript evaluation, structural recommendations. | Fixing commas or performing style polish |
> | **Line edit** | Does the prose carry effect well? | Sentence/paragraph-level edits for style, clarity, emphasis, cadence. | Repairing broken premise or plot logic |
> | **Copyedit** | Is the manuscript correct and consistent? | Grammar, punctuation, usage, style sheet, cross-reference checks. | Rebuilding major scenes or arcs |
> | **Proofread** | Is the final version clean? | Typos, formatting mistakes, final production-level checks. | Any substantial revision |
>
> A reliable revision workflow:
>
> ```mermaid
> flowchart TD
>     A[Finish draft] --> B[Set aside briefly]
>     B --> C[Diagnostic reread and reverse outline]
>     C --> D[Structural revision]
>     D --> E[Targeted scene rewrites]
>     E --> F[Beta readers or critique group]
>     F --> G[Second structural pass]
>     G --> H[Line edit]
>     H --> I[Copyedit and style sheet]
>     I --> J[Proofread on final file]
>     J --> K[Submission or production package]
> ```
>
> This order reflects professional editorial sequencing: one editor may perform multiple services, but EFA guidance emphasizes that these are usually distinct phases and are typically done in stages.

Harness mapping for the flowchart: "Set aside briefly" = a fresh-context cold read; "Beta readers or critique group" = the judgment-audit battery (cold_read_full_book, reverse_outline, macro_revision_diagnostics and the rest of the manifest); "Submission or production package" = final assembly behind the final-test gate.

## Compound-modifier hyphenation rule, verbatim

Applied at the copyedit tier, and recorded on the style sheet:

> ### Compound-modifier hyphenation to scrutinize
>
> LLMs often flatten compound-modifier hyphenation into a single reflex: if two words act like a modifier, insert a hyphen. Human usage is more positional and more relaxed.
>
> For temporary compounds, hyphenate before the noun: `a well-known author`, `a high-quality service`, `a long-term plan`. After the noun, often after a linking verb, usually open the compound: `The author is well known`, `The service is high quality`, `The plan is long term`.
>
> Watch for:
> - predicative over-hyphenation: `is well-known`, `seems high-quality`, `became long-term`
> - `-ly` adverb compounds: `highly-qualified`, `newly-designed`, `statistically-significant`
> - reflexive `ever-` compounds: `ever-changing`, `ever-evolving`, `ever-growing`
> - set phrases where the hyphen adds nothing: `high school`, `ice cream`, `real estate`
>
> Do not strip all hyphens. Keep them when they prevent ambiguity, when the compound precedes the noun, or when the term is conventionally hyphenated: `state-of-the-art`, `cost-effective`, `user-friendly`. The problem is the reflex, not the mark.

## Illustrative milestone timeline, verbatim

The source's planning model. The harness compresses calendar time but preserves the stage order and the proportions between stages:

> ### Illustrative milestone timeline
>
> ```mermaid
> gantt
>     title Example novel schedule from concept to readiness
>     dateFormat  YYYY-MM-DD
>     axisFormat  %b
>
>     section Development
>     Idea testing and premise design      :a1, 2026-01-01, 14d
>     Research and worldbuilding           :a2, after a1, 28d
>     Outline / scene list                 :a3, after a1, 21d
>
>     section Drafting
>     First draft                          :b1, after a3, 120d
>
>     section Revision
>     Cooling-off and diagnostic reread    :c1, after b1, 14d
>     Structural revision                  :c2, after c1, 42d
>     Beta readers / critique round        :c3, after c2, 28d
>     Rewrite from feedback                :c4, after c3, 35d
>     Line edit                            :c5, after c4, 21d
>     Copyedit and corrections             :c6, after c5, 21d
>     Proofread / final checks             :c7, after c6, 14d
>
>     section Packaging
>     Query, synopsis, blurb, formatting   :d1, after c7, 21d
> ```
>
> For many working adults, a more realistic total range is **six to eighteen months** for a submission-ready novel, depending on length, complexity, and whether research is heavy or editors are booked out. Faster is possible; slower is normal. What matters is preserving stage order.

## Binding rule for the harness

Macro-before-line ordering is the spine. No pass may line-edit, copyedit, or proof a chapter whose structural role is still in question; a structural finding voids any line-level work already done on the affected chapters, which re-enter the sequence at scene revision. "What matters is preserving stage order."
