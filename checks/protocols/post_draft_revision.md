# Protocol: Post-Draft Revision (3.6) — the twelve-phase sweep

purpose: systematic search-and-correct process run over every fresh draft; defines the FIX side for every phase (the mechanical SEARCH side is automated by checks/quality_gate.py and the pattern registry under checks/patterns/)
runs: after each chapter/scene draft, before the quality gate re-run; again on any chapter touched by a revision round
source_ref: collation:7053-7111 [BANNED 3.6 POST-DRAFT REVISION PROTOCOL + Phases 2, 3, 9, 10, 12]; phase entries gathered from collation:1216-1222 [Phase 1], 4883-4889 [Phase 4], 3946-3952 [Phase 5], 2807-2813 [Phase 6], 1844-1850 [Phase 7], 4645-4651 [Phase 8], 2098-2104 [Phase 11]

## How the harness uses this

The guide's protocol header, verbatim:

> ## **3.6 POST-DRAFT REVISION PROTOCOL**
>
> Systematic search-and-correct process:

The twelve phases below are the complete sweep, reassembled in phase order. For each phase the **Search** instruction is implemented mechanically: quality_gate.py scans the draft against the pattern registry and emits located hits, so the reviser does not grep by hand. The **Action** instruction is the part this protocol governs — every gate hit must be fixed per its phase's Action line (not paraphrased around, not allowlisted without a defended justification). After the sweep, re-run the gate; the chapter does not advance with OPEN findings.

## The twelve phases, verbatim

### **Phase 1: Structural Patterns**

**Search:** ", then" / "something \[verb\]" / "silence \[verb\]" / "not X, but Y" / "hangs in the air" **Action:** Rewrite every instance per guidelines

### **Phase 2: Dialogue**

**Search:** "said/asked" \+ adverb / "\[voice\] drops/tightens/breaks" / "isn't quite" **Action:** Remove modifiers; embed tone in content

### **Phase 3: Physical Description**

**Search:** jaw / throat / hand \+ tension / exhale / breath \+ release / "pupils blown" **Action:** Replace with character-specific responses

### **Phase 4: Temporal/Transition**

**Search:** "for a moment/beat" / "finally" / "something shifts/breaks/changes" **Action:** Delete or replace with concrete action

### **Phase 5: Emotion Words**

**Search:** raw / carefully / "weight of" / "the need" **Action:** Name specific emotion or show through behavior

### **Phase 6: Sentence Patterns**

**Search:** Sentences starting with And/But / standalone "Because" / verb triplets **Action:** Vary rhythm; integrate fragments

### **Phase 7: Metaphors**

**Search:** "like a stone" / "like a blow" / pull/draw/orbit / hot/cold / "hangs in" **Action:** Cut or replace with direct description

### **Phase 8: Endings**

**Search:** "doesn't move" / "still in hand" / "doesn't say anything" / "And for now" **Action:** End on action, decision, or consequence

### **Phase 9: Openings/Filler**

**Search:** Scene-opening weather/skyline / domestic activities / sensory lists / "the city hummed" **Action:** Start with character; cut busywork; trim decoration

### **Phase 10: Intensity**

**Search:** "changed everything" / "broke forever" / "the world held its breath" **Action:** Scale to proportion; show specific consequence

### **Phase 11: AI Vocabulary**

**Search:** delve / tapestry / landscape / pivotal / crucial / vibrant / highlighting / underscoring **Action:** Replace with specific, character-grounded language

### **Phase 12: Elegant Variation**

**Search:** "the older man" / "the younger woman" / descriptor cycling **Action:** Use names unless descriptor does specific work

## Executing the fix side

- Fix in phase order: structure (1) before line texture (5-7) before surface vocabulary (11). A Phase 1 rewrite often deletes downstream hits for free.
- Repair moves per phase live in checks/protocols/diagnostic_questions.md (physical tells, dead metaphors, transitions, endings, vague interiority, dialogue tags, atmospheric front-loading, echo-line poetics).
- "Rewrite every instance per guidelines" means: answer the matching diagnostic question, then write what the answer says — not a synonym swap that preserves the banned shape.
- A fix that introduces a new gate hit is not a fix; re-run checks/quality_gate.py after the sweep and repeat until clean or every residual is explicitly defended.
