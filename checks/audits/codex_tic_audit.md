# Audit: Codex-Tic Audit (Claude audits Codex-originated material)

id: codex_tic_audit | owner: claude | tier: risk
trigger: event:codex-parallel-draft
output: {audit_root}/claude/chapter_{NN}.codex_tic_audit.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: verve-legacy adversarial register (Claude-on-Codex side)

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Codex's prose has measurably different defaults than Claude's: Codex tends toward
arrangement, taxonomies, three-item catalogs, and thesis closers. Whenever
Codex-originated material exists — a Codex parallel draft, or synthesis material where
Codex modified Claude's text during integration — Claude audits it for Codex tics.
Each model auditing the other against patterns the model itself would not produce
surfaces blind spots a same-model audit cannot.

The Codex tic list:

1. **Arrangement-coded prose** — paragraphs organized as exhibits: information laid
   out, sorted, and presented rather than experienced through a focalizer under
   pressure; the sentence order serves the display, not the scene.
2. **Taxonomies disguised as narration** — categories, types, and classification
   schemes carried into narrative prose ("there were three kinds of...", role-by-role
   walkthroughs, system tours wearing scene clothing).
3. **Three-item catalogs** — the default tricolon: lists of three nouns, three clauses,
   three examples, deployed as rhythm filler rather than because the scene has exactly
   three things in it.
4. **Thesis closers** — paragraph- or scene-final sentences that state the point of
   what the reader just read; the prose files its own conclusion.
5. **Em-dash interruptions used as emotional substitute for content** — the dash break
   performing intensity or feeling the sentence has not actually built.

Scope discipline: audit ONLY the Codex-originated passages supplied. Findings convert
into orders for the synthesis step: replace with Claude-base material, or rewrite the
passage through Claude with the order attached.

## Required verdict format

Per tic, all five — every tic gets a line:

- `FOUND — tic <n> <name> — <count> instances — each quoted with location — ORDER: <REPLACE-WITH-CLAUDE-BASE | REWRITE (what the rewrite must do instead)>`
- `CLEAR — tic <n> <name> — checked: <what was scanned> — nearest miss: "<quote>" — why it passes`

Verdict: `CODEX-TIC-CLEAN` or `CODEX-TICS-FOUND (n)`. A bare CLEAR without
nearest-miss evidence is a FAILED audit. Findings union with the Codex-on-Claude side
into the chapter's revision plan.

## Prompt template

You are a skeptical professional fiction editor auditing prose written by a different
model whose defaults you do not share. The material below is Codex-originated (a
parallel draft, or lines Codex changed during synthesis). Find Codex's signature tics.
No praise, no softening; quote every instance.

Book register and voice rules (for judging what the prose should be doing instead):
{reading_guide_register_excerpt}

Voice cards for focalizers/speakers in this material:
{voice_cards}

Codex-originated material (audit ONLY this text):
{codex_material}

Audit for these five Codex tics, each as its own section:

1. Arrangement-coded prose — exhibits and displays instead of focalized experience;
   sentence order serving presentation, not scene pressure.
2. Taxonomies disguised as narration — categories, types, role-by-role walkthroughs,
   system tours wearing scene clothing.
3. Three-item catalogs — default tricolons used as rhythm filler.
4. Thesis closers — final sentences that state the point of what was just read.
5. Em-dash interruptions used as emotional substitute for content.

For each tic emit either:
`FOUND — tic <n> <name> — "<quote>" (location) — ORDER: <REPLACE-WITH-CLAUDE-BASE | REWRITE: what the rewrite must do instead>`
or
`CLEAR — tic <n> <name> — checked: <what you scanned> — nearest miss: "<quote>" — why it passes`

End with `CODEX-TIC-CLEAN` or `CODEX-TICS-FOUND (n)`. You may not return a bare clean
verdict: every CLEAR requires the nearest-miss quote. Do not audit anything outside
the supplied material; do not rewrite whole passages yourself — emit orders.
