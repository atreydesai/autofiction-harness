# Audit: LLM-Judge Rubric Evaluation

id: llm_judge_rubric | owner: claude | tier: book
trigger: phase:full-book-critique + phase:final-assembly
output: {audit_root}/claude/book.llm_judge.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:7250-7291 [Evaluation toolkit]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

The source (Evaluation toolkit) prescribes a **layered** evaluation: automatic metrics
to detect pathologies, LLM judges for scalable pairwise comparison, targeted human
reading for final ground truth. Four automated **metric families**: (1) repetition/
diversity metrics (distinct-n, self-BLEU-style overlap); (2) distributional
surprise/fit metrics (MAUVE, precision-recall over embeddings); (3) novelty metrics
(n-gram overlap against the author's own prior chapters and a reference corpus);
(4) constraint-verification checks (do promised entities, clues, callbacks appear where
they should). Automated metrics are **warning systems, not arbiters** — a chapter may
look diverse lexically and still be narratively dead.

**Bias cautions (binding):** rubric-based LLM evaluation can correlate well with human
judgment but is biased toward LLM-generated text; off-the-shelf zero-shot judges have
questionable reliability for creative writing and are **biased toward length and style
over substance**; non-experts and LLM judges overvalue linguistic complexity and
length, while experts attend to semantic complexity. Use LLM judges for **relative
comparisons under strict rubrics, not as final truth**. To reduce **positional bias**,
swap A/B order and average across multiple judge runs.

The judge-rubric prompt skeleton, verbatim:

```text
Compare Story A and Story B for creative writing quality.

Score and justify on:
- Originality and surprise
- Narrative coherence and payoff
- Voice and sentence-level craft
- Imagery and emotional resonance
- Technical control without generic polish

Important:
- Ignore length unless it materially improves the writing
- Penalize ornamental but empty prose
- Penalize surprise that breaks causality
- Prefer risk-taking only when it remains narratively usable

Return:
Reasoning: [brief comparison]
Preferred: [A or B]
```

**Human-evaluation protocol notes (carried as process guidance):** stratified reading
rather than full-book scoring every iteration — sample one early scene, one midpoint
scene, one late scene, plus chapter summaries and the final ending; pairwise preference
judgments with short rationale notes; ship a change only if it improves at least one
pillar without materially degrading the others.

**Execution constraint:** the judge runs as a FRESH Claude session with NO project
context — no premise, no reading guide, no worklog, no prior critiques. It sees only
the manuscript sample(s) and the rubric. Project context contaminates the judgment with
intent; the judge must grade what is on the page.

## Required verdict format

- Pairwise mode (Draft N vs Draft N-1 on stratified samples): per rubric criterion, a
  one-line comparison with one quote from each side; then `Reasoning:` and `Preferred:
  [A or B]` per the skeleton. Run twice with A/B order swapped; report both runs and
  the aggregate. An order-dependent preference is reported as `POSITIONAL — no stable
  preference`.
- Single-manuscript mode (final assembly, no comparison draft): per criterion,
  `<criterion>: <score>/10 — weakest passage: "<quote>" — strongest passage: "<quote>"
  — revision order or "none, because <evidence>"`.
- Book verdict: `PREFERRED-CURRENT` / `PREFERRED-PRIOR` / `POSITIONAL` (pairwise) or
  `JUDGE-PASS` / `JUDGE-FAIL` (single, fail = any criterion ≤ 6). `PREFERRED-PRIOR` and
  `JUDGE-FAIL` send their per-criterion findings into the revision queue.

## Prompt template

Send to a fresh Claude session with no other context:

```
You are judging fiction. You have no information about who wrote these texts, how, or
why. Judge only what is on the page. Do not be agreeable: length, ornament, and
performed-literary style are not quality, and you are known to overrate them — correct
for that. Every score must cite quoted evidence; an unsupported high score is invalid.

Compare Story A and Story B for creative writing quality.

Score and justify on:
- Originality and surprise
- Narrative coherence and payoff
- Voice and sentence-level craft
- Imagery and emotional resonance
- Technical control without generic polish

Important:
- Ignore length unless it materially improves the writing
- Penalize ornamental but empty prose
- Penalize surprise that breaks causality
- Prefer risk-taking only when it remains narratively usable

Return:
Reasoning: [brief comparison]
Preferred: [A or B]

STORY A:
{sample_a}

STORY B:
{sample_b}
```

Single-manuscript mode: replace the comparison block with "Score {manuscript_sample} on
the five criteria, 1-10 each, quoting the weakest and strongest passage per criterion,"
keep every other instruction. Samples per run: {early_scene}, {midpoint_scene},
{late_scene}, {final_ending} (stratified, per the protocol). Run each pairwise prompt
twice with A/B swapped; the orchestrator aggregates and converts findings into
revision orders.
