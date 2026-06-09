# Audit: Tension-Naming Conformance Audit

id: tension_naming | owner: codex | tier: risk
trigger: flag:card-names-tension
output: {audit_root}/codex/chapter_{NN}.tension_naming.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:4480+ [Reddit 6 #4 explicitly request tension]

## Critique stance (mandatory)

Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

**#4 Explicitly Request Tension.** You can just *ask* — name the kind of tension you
want upfront. The source's examples of named tension types:

* This session should feel tense. Someone in my party is hiding something.
* I want to feel outmatched. The enemy should seem unbeatable at first.
* There should be a moral dilemma with no clean answer.

The model is remarkably good at executing on specific emotional beats **if** they are
named upfront. In this harness, the naming lives on the chapter card: when a card
declares a tension type (this audit fires only on such chapters), the chapter must
deliver *that* tension — not generic unease, and not a different tension that happens to
be easier to write.

Three checks:

1. **Delivery.** Is the named tension type present and sustained on the page? Evidence
   must be scene material — concealment behavior for "someone is hiding something,"
   demonstrated enemy superiority for "outmatched," genuinely costly horns for "moral
   dilemma with no clean answer" — not narration asserting that things felt tense.
2. **Substitution.** Did the chapter swap in a different tension type (e.g., the card
   names interpersonal suspicion; the chapter delivers external danger instead)? A
   well-executed wrong tension is still a failure against the card; name the delivered
   type.
3. **Announcement vs. enactment.** Tension labeled by the narrator ("the air was thick
   with tension," "something felt off") instead of built through behavior, withheld
   information, or stakes is NOT delivery — it is the model writing the request back at
   the reader. Quote and flag all announcement-only passages.

Special case for "no clean answer" dilemmas: if the text quietly provides a clean
answer (one horn turns out costless, or a third option dissolves the dilemma), the
tension was named but defused — failure under check 1.

## Required verdict format

- `CARD: <quoted tension declaration from the chapter card>`
- Per scene that carries the tension obligation:
  `DELIVERS(<type>) — scene <n> — enactment quoted: <the behavior/stakes/withholding that produces the named tension> — sustained: <where it holds or drops>`
  or `WRONG-TENSION — scene <n> — delivered type: <named> — evidence quoted — what the card's type required instead`
  or `NO-TENSION — scene <n> — announcement-only passages quoted: <list> — no enacted tension found`
- Chapter verdict: `DELIVERS(<type>)` only if the named tension is enacted and sustained
  across the chapter's obligated scenes; otherwise `WRONG-TENSION` or `NO-TENSION`
  (whichever dominates). A DELIVERS verdict must still quote the chapter's weakest
  tension stretch and say why it does not break the verdict.

`REVISION ORDERS`: per failing scene, a numbered order naming the enactment to add
(who conceals what, how superiority is demonstrated, what each dilemma horn costs),
plus deletion orders for every announcement-only tension label.

## Procedure

1. Load the chapter text, the chapter card (quote its tension declaration exactly), and
   character sheets for the characters carrying the tension.
2. Identify which scenes carry the tension obligation per the card.
3. For each obligated scene, collect candidate tension evidence; sort it into enacted
   (behavior, stakes, withheld information) vs. announced (narrator labels). Only
   enacted evidence counts toward delivery.
4. Classify each obligated scene DELIVERS / WRONG-TENSION / NO-TENSION; for dilemmas,
   test both horns for real cost.
5. Write the card quote, per-scene verdicts, chapter verdict, and revision orders in
   the Required verdict format.
6. Write the completed audit to {audit_root}/codex/chapter_{NN}.tension_naming.md. A
   WRONG-TENSION or NO-TENSION chapter is not committable until the orders are executed
   or rejected with reasons in the revision memo.
