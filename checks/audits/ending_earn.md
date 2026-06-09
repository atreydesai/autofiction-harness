# Audit: Ending-Earn Audit (final chapters + coda)

id: ending_earn | owner: codex | tier: book
trigger: phase:whole-book + phase:final-assembly
output: {audit_root}/codex/book.ending_earn.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: legacy-pipeline editor Ending-Earn Audit, genericized

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Runs on the final chapter(s) and any coda — once at whole-book critique, again at
final assembly on the candidate manuscript.

The audit asks:

- **Does the ending close what the book opened?** Name the book's opening promise(s) —
  the disturbance, question, or pressure the first chapters commit to — and quote where
  the ending answers, transforms, or deliberately refuses each. An ending that closes a
  different book than the one that was opened does not earn.
- **Does each locked final line LAND?** If {calibration_locked_text} declares locked
  ending text (exact final lines, locked coda beats), each locked line must be present
  verbatim AND the surrounding prose must make it hit. Locked lines are inviolable in
  text; the surrounding prose is revisable to make them land — that is this audit's
  main lever.
- **Do callbacks pay off setups?** Trace every callback in the ending to its setup
  chapter: quote the setup, quote the payoff, judge whether the payoff is earned by the
  setup or merely references it. A callback whose setup a reader will not remember is
  an unearned wink; a setup with no callback is a dropped promise (cross-check the
  thread ledger / promise-payoff map).
- **Is the ending standalone, well-paced, and does it leave the reader wanting to talk
  about the book?** Standalone: comprehensible and satisfying without sequel deferral.
  Well-paced: no post-landing trickle of explanation after the true ending beat.

## Required verdict format

```
OPENING→CLOSE: per opening promise — <promise> (set up Ch <NN>: "<quote>") —
  CLOSED ("<ending quote>") | TRANSFORMED (evidence) | REFUSED-DELIBERATELY (evidence
  of intent) | UNANSWERED
LOCKED LINES: per locked line — "<line>" — PRESENT-VERBATIM yes/no — LANDS |
  BURIED (what in the surrounding prose mutes it)
CALLBACK CHAIN: per callback — setup Ch <NN> "<quote>" → payoff "<quote>" —
  EARNED | REFERENCED-ONLY | ORPHANED-SETUP | UNSET-CALLBACK
STANDALONE/PACING: verdict + the quoted passage where the book truly ends, and
  anything that continues past it
```

Book verdict:

- `EARNS` — every opening promise closed/transformed/deliberately refused, every locked
  line present and landing, callback chain complete and earned, ending standalone.
  Show your work: include the full callback chain even when it passes, and name the
  weakest link.
- `DOESN'T` — with specific gaps. Each gap converts to a revision order:
  `REVISE surrounding prose at <location> so "<locked line>" lands` / `ADD setup at
  Ch <NN> for <callback>` / `CLOSE promise <X> at <location>` / `CUT post-ending
  trickle after "<quote>"`. Locked text itself is never edited.

**`DOESN'T` at final assembly blocks final assembly.** No final candidate ships with an
unearned ending.

## Procedure

1. Load: final chapter(s) + coda, chapter 1 and any prologue/part-one openings, the
   thread ledger / promise-payoff map, {calibration_locked_text} (if any), and the
   reading guide's ending/high-leverage-scene entries.
2. Build the opening-promise list from the actual opening chapters (quote each), not
   from the outline.
3. Verify every locked line byte-exact against {calibration_locked_text}; then judge
   landing by reading the final pages cold and asking what a first-time reader feels
   at the locked line — if the answer is "nothing extra," it is BURIED.
4. Trace the callback chain both directions: ending→setups and ledger setups→ending.
5. Write verdicts in the required format; emit revision orders; queue them at HIGH
   priority (ending findings outrank most chapter-level findings).
6. At final assembly, re-run from scratch on the assembled candidate — do not reuse the
   whole-book pass verdict. Save each pass to the output path (suffix `_final` for the
   final-assembly pass).
