# Protocol: Diagnostic Questions and Repair Moves

purpose: the question battery the drafter and reviser ask when a flagged pattern needs replacing, plus the "Instead of" repair protocols and the precedence principles that resolve conflicts between rules
runs: referenced by every drafting prompt (paired with checks/protocols/mid_draft_flagging.md) and by every revision pass (paired with checks/protocols/post_draft_revision.md)
source_ref: collation:1468-1487 [For Physical Tells; Instead of Generic Physical Tells], 1821-1840 [For Metaphors; Instead of Dead Metaphors], 2355-2361 [For Transitions], 4620-4641 [For Endings; Instead of Stillness Endings], 4317-4333 [For Vague Interiority; For Dialogue Tags], 4337-4346 [Instead of Atmospheric Front-Loading], 2792-2801 [Instead of Echo-Line Poetics], 4305-4313 [They Tell Rather Than Show], 2365-2371 [Specificity vs. Brevity], 2134-2141 [Convention vs. Precision], 3177-3183 [Rhythm vs. Clarity], 4385-4392 [Character Voice vs. Ban List]

## How the harness uses this

A gate hit or mid-draft flag names a pattern; this file supplies the question to ask and the move to make. Ask the diagnostic first — the answer IS the rewrite. If the question cannot be answered concretely, the problem is upstream (an underspecified beat or character), and the fix belongs on the chapter card or voice card, not in line-level paraphrase.

## The failure mode this battery repairs, verbatim

> ### **They Tell Rather Than Show**
>
> * Label that emotion occurred rather than dramatizing it
> * Announce that time passed rather than showing what filled it
> * Declare that something changed rather than making the change visible

## Diagnostic questions, verbatim

> ### **For Physical Tells**
>
> **Ask:** How does *this specific character* show this emotion? What's their particular outlet—displacement activity, speech pattern change, postural shift?

> ### **For Metaphors**
>
> **Ask:** Does this comparison clarify or decorate? Does the vehicle share actual properties with the tenor, or does it just sound good?

> ### **For Transitions**
>
> **Ask:** What happens during this pause? Who breaks first? What's the cost of the waiting?

> ### **For Endings**
>
> **Ask:** What action, decision, or consequence closes this beat? What changes because of what just happened?

> ### **For Vague Interiority**
>
> **Ask:** What is actually happening? What would an observer see? What would the character physically feel or specifically think?

> ### **For Dialogue Tags**
>
> **Ask:** Can the line carry its own tone? If I remove the modifier, does the reader still understand how it's delivered?

## Repair protocols, verbatim

> ### **Instead of Generic Physical Tells**
>
> * Identify each character's specific stress responses
> * Tie physical behavior to established psychology
> * Show displacement activities that reveal coping patterns
> * Let the body do something that advances the scene

> ### **Instead of Dead Metaphors**
>
> * Describe the sensation directly
> * Ground comparison in the character's specific frame of reference
> * Cut the metaphor entirely if direct description works better
> * Test: does this image clarify or just decorate?

> ### **Instead of Stillness Endings**
>
> * End on a micro-action that crystallizes the emotional state
> * Close with dialogue that shifts the dynamic
> * Cut the scene earlier—before the false profundity
> * Let consequence land rather than announcing that it landed

> ### **Instead of Atmospheric Front-Loading**
>
> * Start with character in action or decision
> * Introduce environment through character perception, not camera pan
> * Let setting emerge from what the character notices and why
> * Anchor atmosphere in sensory detail that matters to the scene

> ### **Instead of Echo-Line Poetics**
>
> * If the second line doesn't add information, cut it
> * Combine into single sentence with actual movement
> * Escalate, complicate, or contradict—don't just rephrase
> * Trust single statements to carry weight

## Precedence principles, verbatim

When a repair move collides with another rule, these decide:

> ### **Specificity vs. Brevity**
>
> * Specificity wins. A longer line that does work beats a shorter line that decorates.

> ### **Convention vs. Precision**
>
> * Precision wins. An unfamiliar construction that fits beats a familiar one that doesn't.

> ### **Rhythm vs. Clarity**
>
> * Clarity wins. A clunky sentence that communicates beats a smooth sentence that obscures.

> ### **Character Voice vs. Ban List**
>
> * If a specific character would genuinely use a banned term in dialogue, flag it and use sparingly with clear justification.
> * Narration has no such excuse.

## Harness notes

- Character Voice vs. Ban List is implemented in checks/quality_gate.py: a dialogue-scope hit may be defended by a character voice card that claims the term; narration-scope hits have no such defense.
- These precedence principles operate inside the ban-list layer; the cross-artifact hierarchy (premise > task prompt > protocols > registry tiers > watchlists) is in checks/protocols/precedence.md.
