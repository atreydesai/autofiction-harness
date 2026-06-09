# Audit: Yes-But / No-And Outcome Audit

id: yes_but_no_and | owner: codex | tier: risk
trigger: sample:every-2nd-chapter
output: {audit_root}/codex/chapter_{NN}.yes_but_no_and.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4399+ [Reddit 5 Fix 3]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

**Fix 3: The "Yes, But / No, And" Framework** — borrowed from improv and tabletop RPGs;
gold for model-drafted fiction. When a character attempts something:

* **Yes, but**: It works, but something goes wrong or something new surfaces.
* **No, and**: It doesn't work, and something else gets worse too.

These two responses generate story. **"Yes" and "No" on their own are dead ends.** The
source's prompting rule, which this audit enforces on the page: "When my character takes
action, respond with 'yes, but' or 'no, and' consequences. Pure success or failure
should be rare." When every action carries a consequence that feeds the next scene, the
story pulls itself forward instead of stalling after each beat.

Scope: classify **every significant character attempt in the chapter** — any moment
where a character tries to get, do, learn, persuade, escape, conceal, or prevent
something and the text shows an outcome. "Significant" excludes trivial physical
business (opening a door that opens) unless the chapter treats it as contested.

Classification:

1. **YES-BUT** — the attempt works, but something goes wrong or something new surfaces.
   Both halves must be quotable.
2. **NO-AND** — the attempt fails, and something else gets worse too. Both halves must
   be quotable.
3. **PURE-YES** — clean success, no cost, catch, or new surface. Dead end.
4. **PURE-NO** — clean failure, no additional worsening, no new pressure. Dead end.

Pure outcomes are not banned outright — the source says they should be *rare*. The
failure condition is frequency and placement: any pure outcome at a load-bearing attempt
(an attempt the chapter card or thread ledger marks as consequential), or pure outcomes
forming the majority of the chapter's attempts.

## Required verdict format

One verdict line per attempt:

- `YES-BUT — attempt: <who tries what> — the YES quoted — the BUT quoted — what it feeds in a later scene: <named>`
- `NO-AND — attempt: <who tries what> — the NO quoted — the AND quoted — what it feeds in a later scene: <named>`
- `PURE-YES — attempt: <who tries what> — outcome quoted — load-bearing: <YES per <card/ledger ref> | no>`
- `PURE-NO — attempt: <who tries what> — outcome quoted — load-bearing: <YES per <card/ledger ref> | no>`

Tally line: `TALLY: <yes-but> YES-BUT / <no-and> NO-AND / <pure-yes> PURE-YES /
<pure-no> PURE-NO out of <total> attempts.`

Chapter verdict: `OUTCOMES-GENERATIVE` only if no load-bearing pure outcome exists and
pure outcomes are a clear minority; otherwise `DEAD-END-OUTCOMES`. A passing verdict
must still quote the attempt closest to a pure outcome and say why it survives.

`REVISION ORDERS`: per flagged pure outcome, a numbered order converting it — for
PURE-YES, name the "but" (what goes wrong or newly surfaces); for PURE-NO, name the
"and" (what else gets worse). Each order states where the consequence lands in a
subsequent scene.

## Procedure

1. Load the chapter text, the chapter card, and {thread_ledger} (to identify
   load-bearing attempts and where consequences should feed).
2. Enumerate every significant character attempt in chapter order; for each, locate the
   on-page outcome.
3. Classify each attempt; for YES-BUT and NO-AND, quote both halves — an unquotable
   "but"/"and" reclassifies the outcome as pure.
4. Compute the tally; check load-bearing status of every pure outcome against the card
   and ledger.
5. Write per-attempt verdicts, the tally, the chapter verdict, and the revision orders
   in the Required verdict format.
6. Write the completed audit to {audit_root}/codex/chapter_{NN}.yes_but_no_and.md. A
   DEAD-END-OUTCOMES chapter is not committable until the orders are executed or
   rejected with reasons in the revision memo.
