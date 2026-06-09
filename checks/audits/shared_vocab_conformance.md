# Audit: Shared-Vocabulary Ban Conformance

id: shared_vocab_conformance | owner: codex | tier: core
trigger: every-chapter
output: {audit_root}/codex/chapter_{NN}.shared_vocab.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:3382+ [Reddit 4 Fix 3 ban the shared vocabulary]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The source fix, applied verbatim:

> AI has favorite words. You'll start noticing them after a few sessions - the same verbs, the same adjectives, the same purple phrases showing up in every character's mouth.
> The problem? When every character uses the same vocabulary, they blur together.
> My fix: tell the AI which words belong to which character.
> Lena uses "beautiful" and "gentle." Marcus never uses either. He says "fine" and "solid."
> You can also just ban overused words globally. Pay attention to which words keep appearing in your sessions, then add them to a blacklist. It forces the AI to find alternatives. Those alternatives end up feeling more specific.

In this harness, vocabulary ownership lives in the voice cards: each character's **owned words** (words/phrases that belong to them) and **never-says list** (words, registers, constructions out of character). The reading guide and tics tracker hold the **global blacklist** of overused words. This audit mechanically enforces all three against the chapter:

1. **Never-says violations.** Any character speaking (or thinking, in their focalized interiority) a word or construction on their never-says list.
2. **Ownership leakage.** A word owned by character A appearing in character B's mouth. Leakage blurs both characters; the source's point is that ownership is exclusive unless the cards say otherwise.
3. **Global blacklist hits.** Any blacklisted overused word appearing in dialogue or narration, by anyone.
4. **Cross-character favorites.** Words not yet on any list that appear in 3+ different characters' mouths within the chapter — the "same verbs, same adjectives, same purple phrases" symptom. These are candidate additions to the blacklist or to a single owner's card.

Calibration: deliberate echo (one character quoting or mocking another's owned word, a motif the reading guide assigns to multiple characters) passes only with the on-page or in-guide evidence cited. Common function words and unavoidable domain terms are not "vocabulary" for this audit; the lists define scope.

## Required verdict format
Per finding:
- `NEVER-SAYS — <character>: "<quoted line>" (location) — card entry violated: "<verbatim list entry>"`
- `LEAKAGE — "<word/phrase>" owned by <A> (card cited) — spoken by <B>: "<quoted line>" (location)`
- `BLACKLIST — "<word/phrase>": <n> occurrences, locations — speakers/narration`
- `CROSS-FAVORITE — "<word/phrase>" — speakers: <names + quoted lines> — proposed disposition: assign to <character> | add to blacklist`
- `ECHO-OK — "<word>" — deliberate echo, evidence: "<quote or guide line>"`

Chapter verdict:
- `VOCAB-CONFORMS` — zero violations in classes 1-3. Must still report classes checked (cards loaded, blacklist size) and the nearest miss in each class.
- `VOCAB-VIOLATIONS (<n>)` — any class 1-3 finding. Class 4 findings are reported regardless of verdict.

`REVISION ORDERS:` one per class 1-3 finding: quote the line, name the speaker, and direct replacement with vocabulary from the speaker's own card (name the owned word or register to use). For class 4: an order to the tracker, not the prose — record the proposed disposition in the tics tracker / style file for orchestrator ratification.

## Procedure
1. Load the chapter; load every speaking character's voice card and extract verbatim their owned-words and never-says lists; load the global blacklist from {reading_guide} (tic catalog) and the run's tics tracker; load {calibration} if present.
2. Mechanically grep the chapter for every never-says entry per character, scoped to that character's dialogue lines and focalized interiority. Attribute each hit by reading the surrounding lines — attribution errors invalidate findings.
3. Grep for every owned word across all OTHER characters' dialogue. Record leakage with both card citations.
4. Grep for every global-blacklist entry across the full chapter text; count and locate.
5. Build a per-character content-word frequency table for dialogue; flag any non-listed word used by 3+ characters as CROSS-FAVORITE.
6. Test candidate findings against the deliberate-echo exception; cite evidence or deny.
7. Write findings, the chapter verdict, and revision orders in the required format to the output path.
8. This is a core-tier gate: if the verdict is VOCAB-VIOLATIONS, mark the chapter not-committable until orders are executed or explicitly rejected with reasons in the revision memo. Update the tics tracker with class 3 and 4 counts either way.
