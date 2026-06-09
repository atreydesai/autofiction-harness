# Audit: Full-Book Cold Read (Claude, mandatory at final assembly)

id: cold_read_full_book | owner: claude | tier: book
trigger: phase:full-book-critique + phase:final-assembly
output: {audit_root}/claude/final_cold_read.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: legacy-pipeline mandatory final cold read (drafter final assembly + editor Phase 5 whole-book cold reads + reader-engagement battery)

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

A full-book cold read of the assembled manuscript by a fresh Claude session, run at
full-book critique AND (not optional) on the final-assembly candidate. The cold reader
sees the manuscript plus {reading_guide} only — no skeleton, chapter cards, story
bible, worklog, or prior critiques. Reading the planning artifacts contaminates the
cold-reader perspective and lets the audit inherit the writer's blind spots.

The cold read identifies, at whole-book level: drift from the binding standard,
missed inviolable/committed elements, motif distribution problems, continuity issues,
ending strength, register consistency across chapters, pacing collapse, dropped
subplots, and lost-reader moments.

The reader-engagement question battery (mandatory, answered explicitly, each with
chapter locations and quotes):

- Where did you feel like skimming?
- Was there any character introduced where you couldn't place who they were?
- Did the chapter ordering lose you?
- Where did interest drop off?
- Did any plot beat confuse you?
- Did any recurring exchange or conversation feel like a slog?
- Where did you feel surprised — and where did you feel like you saw it coming?

Conditional battery — ONLY if {reading_guide} declares substantial aftermath sections
(material running past the book's major reveal or climax):

- Did interest drop after the major reveal (act-3 sag)?
- Did POV shifts cost the reader?
- Did time-scale shifts lose the reader?
- Are all required aftermath beats present per the reading guide's
  high-leverage-scenes list?

Disposition rule (binding): every finding must be **resolved**, **deferred with
recorded reasons**, or **explicitly rejected with reasons** — recorded in the run's
revision plan / residual-risks file. Final assembly is blocked until every finding has
one of the three dispositions. Disagreements between this cold read and the
orchestrator's assessment are valuable; do not reconcile them by fiat.

## Required verdict format

- `FINDINGS` — numbered list; each: `<chapter/location> — <category: drift |
  inviolable-miss | motif | continuity | ending | register | pacing | subplot |
  lost-reader> — "<quote>" — <why a cold reader stumbles here> — <proposed revision
  order>`.
- `ENGAGEMENT BATTERY` — every question above answered with locations and quotes.
  "Nowhere" answers require naming the candidate passages checked and why they
  survived (show your work).
- `AFTERMATH BATTERY` — answered if triggered; otherwise one line: `not declared in
  reading guide — skipped`.
- Book verdict: `NO-HIGH-LEVERAGE-FINDINGS` (engagement battery still fully answered
  with evidence) or `FINDINGS-OPEN` (count + the three highest-leverage ones named).
- Disposition table appended by the orchestrator after triage: per finding,
  RESOLVED / DEFERRED (reason) / REJECTED (reason).

## Prompt template

Send to a fresh Claude session with no other project context:

```
You are a cold reader. You have never seen this book, its outline, or its authors'
intentions. You receive only the manuscript and the reading guide below. Read the
ENTIRE manuscript in order before writing anything.

You are a skeptical professional editor, not an encouraging coach. No praise, no
softening. Every claim needs a chapter location and a quote. If a dimension genuinely
holds, prove it by naming what you checked and the nearest failure candidate.

Report, with quoted evidence and proposed revision orders:
1. Whole-book findings: drift from the reading guide's voice/register rules, missed
   committed or locked elements, motif distribution problems, continuity errors,
   ending strength, register consistency across chapters, pacing collapse, dropped
   subplots, moments a first-time reader gets lost.
2. Answer each engagement question explicitly: Where did you feel like skimming? Was
   there any character introduced where you couldn't place who they were? Did the
   chapter ordering lose you? Where did interest drop off? Did any plot beat confuse
   you? Did any recurring exchange or conversation feel like a slog? Where did you
   feel surprised — and where did you feel like you saw it coming?
3. {aftermath_questions_if_declared}
4. End with a verdict: NO-HIGH-LEVERAGE-FINDINGS or FINDINGS-OPEN, and rank your three
   highest-leverage findings.

READING GUIDE:
{reading_guide}

MANUSCRIPT:
{manuscript}
```

Fill {aftermath_questions_if_declared} with the conditional battery when the reading
guide declares aftermath sections; otherwise with "(no aftermath sections declared —
skip this item)". The orchestrator then triages every finding into the disposition
table; unresolved dispositions block final assembly.
