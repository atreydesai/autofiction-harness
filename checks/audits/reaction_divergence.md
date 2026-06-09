# Audit: Reaction-Divergence Test (same stimulus, different characters)

id: reaction_divergence | owner: codex | tier: risk
trigger: flag:multi-character-scene
output: {audit_root}/codex/chapter_{NN}.reaction_divergence.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:3588+ [Reddit 4 Fix 4]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
The source test, applied verbatim:

> Here's a test I run: put two characters in the same situation and see if they respond differently.
> If both characters react to bad news by getting quiet and contemplative, you have a problem. One should get quiet. One should get loud. One should make a joke. One should blame someone.
> Same stimulus, different response. That's characterization.

The source's concrete-behavior calibration — character notes should specify "how this character handles stress" and "how they respond to conflict" as concrete behaviors, not prose:

> - Mira: deflects with humor, changes the subject, won't make eye contact.
> - Jonas: gets very still, speaks slower, asks clarifying questions.

In this harness those concrete behaviors live in the voice cards / character snapshots (stress-response and under-pressure fields). The audit checks:

1. **Shared-stimulus inventory.** Every moment in the chapter where two or more characters receive the same stimulus on the page: bad news, a reveal, a threat, an arrival, a death, a joke, an insult, an order, a win.
2. **Divergence.** For each shared stimulus, do the characters' reactions differ in KIND (quiet vs. loud vs. joke vs. blame vs. still vs. deflect), not merely in adjective? Two characters who both "go quiet and contemplative," both deliver a wry line, or both ask a measured clarifying question are a failure even if the wording differs.
3. **Card conformance.** Does each character's on-page reaction match their declared stress-response/under-pressure behavior? A character reacting against their card without scene-motivated cause is a finding even when the reactions diverge from each other.

Exception: deliberate unison (a crowd gasping, a drilled team executing, a beat where sameness IS the point) passes only if the sameness does narrative work the scene names or earns — say what that work is.

## Required verdict format
Per shared stimulus:
- `STIMULUS <location>: "<quoted trigger>" — reactors: <names>`
  - `DIVERGES — per character: <name>: "<quoted reaction>" → kind: <quiet|loud|joke|blame|still|deflect|other> — card-match: yes/no (cite the card field)`
  - `CONVERGES — "<quoted reactions>" — all reduce to: <the one shared reaction kind>`
  - `OFF-CARD — <name>: "<quoted reaction>" vs. card says: "<quoted card field>" — scene cause present: yes/no`

Chapter verdict:
- `REACTIONS-DIVERGE` — every shared stimulus DIVERGES with card-matched reactions (or earned unison, named). Must still quote the closest-to-converging pair you considered.
- `CONVERGENCE-FOUND (<n>)` — any CONVERGES or unexplained OFF-CARD finding.

`REVISION ORDERS:` one per finding: quote the converging reactions, assign each character a differentiated reaction kind drawn from their card's stress-response field (quote it), and state where in the beat the rewrite lands. "Make them react differently" without per-character card-sourced behavior is an invalid order.

## Procedure
1. Load the chapter, the voice cards / character snapshots for every character present in multi-character scenes (especially stress-response, under-pressure, and how-they-show-emotion fields), and {reading_guide} register notes; load {calibration} if present.
2. Build the shared-stimulus inventory: walk the chapter scene by scene and list every on-page event witnessed or received by 2+ characters. Include small stimuli (a joke, an awkward silence) — convergence hides in small beats.
3. For each stimulus, quote each character's reaction (dialogue, action, interiority) and classify its kind. Classify by behavior, not by the narrator's label.
4. Compare kinds across reactors. Identical or near-identical kinds → CONVERGES. Check each reaction against the character's card field and record card-match.
5. Test any sameness against the earned-unison exception; name the narrative work or deny the exception.
6. Write per-stimulus verdicts, the chapter verdict, and revision orders in the required format to the output path.
7. Queue CONVERGENCE-FOUND orders into the current revision round; record acceptance or rejection with reasons in the revision memo.
