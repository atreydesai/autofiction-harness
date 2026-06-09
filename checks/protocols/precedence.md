# Protocol: Precedence and Safety Rails

purpose: the conflict-resolution hierarchy for the whole harness — which artifact wins when rules collide — plus the safety rails that bound what the enforcement machinery is allowed to do
runs: standing policy for every stage, every check, and every audit; consulted whenever two instructions disagree
source_ref: collation:2421-2434 [Precedence]; collation:2860-2873 [Safety rails]

## The original hierarchy, verbatim

> ## Precedence
>
> When rules conflict:
> 1. Truth, safety, accessibility, and platform/legal requirements
> 2. Explicit user instructions
> 3. Genre and medium norms
> 4. Core rules
> 5. Optional watchlists and heuristics
>
> If the user asks for bullets, use bullets. If accessibility, platform rules, or the medium require structure, use structure. If the user asks for a neutral summary, do not force first person or extra stance into it.

## The harness mapping

Transposed to the harness's artifacts, when instructions conflict the higher layer wins:

1. **Premise + reading guide + calibration artifact** (the "explicit user instructions" and "genre and medium norms" layer): what the book is, who it is for, and the calibrated register it is written in. Nothing downstream may override these.
2. **Stage task prompt** (drafter/long_novel_task.md, editor/long_novel_editing.md): the operating orders for the current stage, valid only within layer 1.
3. **checks/protocols/ + audit templates** (checks/audits/, audit_manifest.tsv): the binding procedures — pre-draft, mid-draft, post-draft, required checks, editing-stage order, final test — and the audit specifications that enforce them.
4. **Pattern registry BANNED/CAP tiers** (checks/patterns/*.tsv via checks/quality_gate.py): mechanical blocking rules. They yield to layers 1-3 only through the explicit defense mechanisms (allowlist entries defended on a chapter card or in style_and_voice.md; Character Voice vs. Ban List for dialogue) — never silently.
5. **WATCH watchlists**: counted and reported, never blocking. Heuristics for the judgment audits, not rules.

Examples in harness terms: if the reading guide establishes a register, a CAP threshold tuned for a different register is recalibrated, not obeyed blindly. If a protocol and a watchlist disagree, the protocol wins. If a pattern-registry hit conflicts with a calibrated character voice, the voice card defense (layer 1 via the documented mechanism) wins — on the record, with justification.

Truth, safety, and accessibility remain above everything: no layer may instruct the engine to make text less accurate, less safe, or less usable.

## Safety rails, verbatim — binding engine policy

These rails bound the enforcement machinery itself. The pattern registry, the gate, the audits, and every revision pass must operate inside them; any tier entry, audit instruction, or fix that violates them is invalid regardless of layer.

> ## Safety rails
>
> These are not AI tells by themselves: em dashes, semicolons, `however`, competent punctuation, well-formed paragraphs, and the right word even if it appears on somebody's banned list.
>
> Do not invent typos. Do not break grammar on purpose. Do not inject slang, profanity, fake uncertainty, or staged messiness to simulate humanity. No mandatory `actually` turn. No manufactured negativity. No programmatic sentence-length wobble. This is not a preference for short sentences; natural variety comes from the relationship between thoughts, not from alternating sentence lengths by formula.
>
> Do not make text less usable or less accessible in the name of sounding less AI-written. Removing needed headings, lists, descriptive links, citations, caveats, or next steps is not a style improvement.
>
> The recurring problem is regularity and mismatch, not any one feature. Use em dashes where they belong; do not reach for them as a default connective. If you keep using the same punctuation move in the same role, vary it rather than banning it. In casual internet prose, paragraph-after-paragraph em dashes are now a socially recognized AI cue, so prefer commas, colons, conjunctions, subordinate clauses, or full stops unless the dash clearly earns its keep. A full stop is not the automatic replacement; sometimes the fix is to make the relationship between the clauses clearer. For temporary compound modifiers, hyphenate before the noun and usually open after it; do not let the model turn every compound into a hyphenated unit.

## What this means for the harness machinery

- No registry tier may ban em dashes, semicolons, `however`, competent punctuation, or well-formed paragraphs outright; regularity of use is what CAP tiers meter.
- No fix may invent typos, break grammar, inject slang or profanity, fake uncertainty, or stage messiness to dodge a detector. A "fix" of that kind is itself an OPEN finding (see Required check 10, checks/protocols/required_checks.md).
- No pass may strip needed structure (headings, lists, front matter, apparatus) from harness documents or from the manuscript to look less AI-written.
- The compound-modifier rail is operationalized at the copyedit tier (checks/protocols/editing_stages.md) and on the style sheet.
