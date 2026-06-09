# Protocol: Mid-Draft Flagging (3.5)

purpose: in-flight self-redirect table — when the drafter catches itself producing a banned element, it stops and answers the diagnostic question before continuing
runs: embedded in every drafting prompt; applies continuously while text is being generated, not as an after-the-fact pass
source_ref: collation:1530-1556 [BANNED 3.5 MID-DRAFT FLAGGING PROTOCOL]

## How the harness uses this

This table ships inside every drafting prompt. The drafter does not write the banned element and fix it later; the trigger fires at the moment of composition. Answering the diagnostic question produces the replacement line — if the question cannot be answered concretely (what emotion, which character, what cost), the beat itself is underspecified and the drafter should consult the chapter card before continuing. The mechanical forms of these triggers are also enforced post hoc by checks/quality_gate.py; this protocol exists so they never reach the gate.

## The protocol, verbatim

> ## **3.5 MID-DRAFT FLAGGING PROTOCOL**
>
> When you catch yourself writing a banned element, stop immediately and redirect:
>
> | If You Write... | Stop and Ask... |
> | ----- | ----- |
> | ", then" | Does this sequence reveal psychology, or am I just choreographing? |
> | "something" | What exactly is happening? |
> | "silence stretches/hangs" | What is the effect on who? |
> | "not X, but Y" | What is this actually? Can I commit? |
> | adverb after "said" | Can the line carry its own tone? |
> | "voice drops/tightens" | Can I show this through rhythm or action? |
> | jaw/throat/hand tension | How does THIS character show restraint? |
> | "finally" | Who yields first? What breaks the stalemate? |
> | "raw" | What is the actual emotion? |
> | "carefully" | Why? What would happen if they weren't careful? |
> | "like a blow" | What does this actually feel like in the body? |
> | "need" without object | Need for what? From whom? Why? |
> | weather/skyline opening | Where is the character? What are they doing? |
> | domestic activity | Does this create friction, or am I padding? |
> | "changed everything" | Is this moment actually that big? |

## Notes for the drafter

- The diagnostic answers map to the repair moves in checks/protocols/diagnostic_questions.md (character-specific tells, direct sensation, named emotion, action endings).
- "How does THIS character show restraint?" must be answered from that character's voice card, not invented fresh mid-scene.
- If a character would genuinely use a banned term in dialogue, the Character Voice vs. Ban List rule applies (see checks/protocols/diagnostic_questions.md): flag it, use sparingly with clear justification. Narration has no such excuse.
