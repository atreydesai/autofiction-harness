# Audit: Claude-Tic Audit (Codex audits every Claude draft/revision)

id: claude_tic_audit | owner: codex | tier: core
trigger: every-chapter
output: {audit_root}/codex/chapter_{NN}.claude_tic_audit.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: verve-legacy task prompts + collation model-attributed tics

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Claude has its own LLM defaults that Codex must audit Claude's drafts and revisions
against. Role assignment is asymmetric for prose generation but symmetric for
tic-policing. This is a first-class quality gate before synthesis or acceptance, not
optional polish. Claude's prose defaults to watch for — the full thirteen-item list:

1. Em-dash overuse and em-dash-as-rhythm-crutch
2. "Shimmer" prose: over-poetic adjective stacks, atmospheric drift in places that
   need action
3. Recurring sentence-mood verbs ("mattered," "earned," "weighed," "carried")
4. Default-elegant noun phrases ("a kind of," "something like," "a small / quiet /
   careful X")
5. Habitual qualifiers and softening adverbs that drain momentum
6. Narrator-as-philosopher voice intrusion — wisdom inserts mid-scene
7. Subtle theme-explanation through narrator gloss after a beat lands
8. Recursive negation patterns ("not X, not Y, not even Z")
9. Self-aware meta-clauses ("if that was the word for it," "if there was a word
   for it")
10. Over-balanced sentence structures with parallel clauses
11. Closing scene-ends on a single short sentence used as profundity stamp
12. Default "lovely / quiet / small" register applied to scenes that should be ugly,
    big, or loud
13. Defaulting to physical reaction beats (heartbeat, throat tightens) when interior
    thought would do more work

The reading guide / calibration artifact may specify additional book-specific Claude
tics on top; audit those with the same discipline.

**Mechanical input.** The pattern registry's WATCH-tier counts for this chapter
({watch_counts}) are provided as mechanical input: per-pattern hit counts from the
quality-gate engine. They seed the audit (which tics to press hardest) but do not
bound it — judgment tics like shimmer, philosopher intrusion, and theme gloss have no
grep signature and must be read for. Zero WATCH hits never justifies skipping a tic.

## Required verdict format

Per tic, all thirteen plus any book-specific additions — every tic gets a line:

- `FOUND — tic <n> <name> — <count> instances — each quoted with line ref — ORDER: <fix per instance or pattern-level order>`
- `CLEAR — tic <n> <name> — checked: <what was scanned> — nearest miss: "<quote>" — why it passes`

A `CLEAR` without a nearest-miss quote is invalid for tics 1-5 and 8-11 (the
high-frequency tics); for the others, "no candidate found" must state what was read
for. Footer: WATCH-count reconciliation ({watch_counts} vs audit findings — explain
discrepancies). Chapter verdict: `TIC-CLEAN` or `TICS-FOUND (n)`; TICS-FOUND blocks
synthesis/acceptance until orders are executed or defended on the chapter card or
style file as deliberate signature.

## Procedure

1. Load the Claude-originated text (raw draft or revision — audit Claude's material
   before synthesis dilutes provenance), the reading guide's book-specific tic
   catalog, and the registry WATCH counts for this chapter ({watch_counts}).
2. Pass 1, mechanical-seeded: for each WATCH pattern with hits, verify each hit in
   context — a hit inside a register the reading guide licenses (e.g., a character
   whose voice card sanctions the construction) is noted as licensed, not FOUND.
3. Pass 2, read-through: read the full text once per tic family — rhythm tics (1, 10,
   11), diction tics (3, 4, 5), register tics (2, 12), narrator tics (6, 7), syntax
   tics (8, 9), and interiority tic (13) — quoting every instance.
4. Pass 3, book-specific: audit calibration-named Claude tics the same way.
5. Aggregate repeated patterns: a tic appearing more than twice in the chapter gets a
   pattern-level order (rewrite strategy), not just per-instance fixes. Update the
   book-wide tic tally file.
6. Write the report in the required verdict format, reconcile against {watch_counts},
   save to the output path, and queue orders into the synthesis step. Codex fixes
   arrangement-level issues directly during synthesis only when trivial; prose
   rewrites go back to Claude with the orders.
