# Scaffold: Character Snapshot + Voice Card

artifact: {workspace}/characters/<character>.md (one file per character with speaking lines in more than one scene)
purpose: describe how a character thinks, talks, and moves through the world — operation over trait lists — so the drafter writes a specific human being instead of a polite, articulate placeholder
created: drafter Phase 3 (voice cards), before chapter drafting; minor characters may get partial snapshots on first appearance
updated: when a chapter commits a new durable behavior, tell, or relationship shift; when the snapshot_conformance audit finds drift
updated_by: orchestrator (drafter consults verbatim in every drafting prompt)
source_ref: collation:3330-3381 + 3634-3651 + 3671-3687 [Reddit 3 character snapshots] + collation:3555-3572 [Reddit 4 "Putting It Together"] + legacy drafter task Phase 3 voice-card template (genericized)

## Why (Reddit 3, verbatim)

> That's a character sheet. It tells AI what your character *is*. But AI doesn't need to know what your character is — it needs to know how your character *operates*.

> The issue is that adjectives aren't behavior. And behavior is what makes a character feel real on the page.

> Instead of a trait list, I give AI what I call a character snapshot — a short document that describes how the character *thinks, talks, and moves through the world*. It takes maybe 10 minutes to write and the difference in output is night and day.

## Unified template

Field provenance is marked: [R3] = Reddit 3 snapshot, [R4] = Reddit 4 "Putting It Together", [legacy] = legacy voice-card template.

```
CHARACTER SNAPSHOT + VOICE CARD — <character name>

### Snapshot (operation, not traits)
- how they show emotion (not what emotions they have): <placeholder>            [R3 field 1]
- how they speak: <placeholder — sentence length, deflection, humor-as-armor,
  swearing, trailing off, one quirk is enough>                                  [R3 field 2]
- what their body does under stress: <placeholder — specific physical tells,
  not "she felt nervous">                                                       [R3 field 3]
- central wound and how it distorts their behavior: <placeholder — the engine
  that drives decisions, not backstory for the page>                            [R3 field 4]
- their contradiction: <placeholder — the two conflicting things they want>     [R3 field 5]

### Quick-start questions (answer all five for leads)                           [R3 quick-start]
1. How do they show care? (through action, words, gifts, silence?)
2. How do they speak? (one quirk is enough)
3. What does their body do when they're stressed or scared?
4. What's the wound, and how does it distort their behavior today?
5. What two things do they want that conflict with each other?

### Dialogue spec                                                               [R4]
- three to five lines of example dialogue: <placeholder>
- two speech quirks (sentence length, filler words, formality): <placeholder>
- words they use / words they never use: <placeholder>
- how they react to stress or conflict: <placeholder>
- what they get wrong: <placeholder>

### Voice card                                                                  [legacy]
- register: <formal | casual | raw; any world/period constraints>
- contractions policy: <default-contract | formal-only-under-pressure | never-contracts>
- modal dialogue mass: <typical line shape and weight>
- default at rest: <ordinary low-pressure speech>
- under pressure: <how syntax, pace, profanity, evasions change>
- interiority rhythm: <what their mind does under pressure>
- narration transparency: <how this focalizer keeps scene state legible>
- allowed plainness: <lines this character may say that need not land>
- tics: <recurring verbal habits used sparingly>
- never says: <words, registers, constructions out of character>
- relationship-specific: <how speech shifts per major interlocutor>
- premise-specific behavior: <register shifts, care moves, motifs this character owns>
```

If a character has unusual structure (a narrator with multiple registers, a non-speaking but documented presence, a mode-switching narrator), extend the template and document the extension so drafting prompts can copy-paste reliably under context pressure. Do not build the card as a wall of negative constraints — its job is to make the character easy to write in positive motion; move pile-ups of warnings to the chapter card's risks. [legacy]

## Worked mini-example (Reddit 3's own, verbatim)

> **Maren** leads with competence. She shows care through practical action — fixing a fence, showing up early, solving a problem no one asked her to solve. She avoids direct emotional statements and deflects vulnerability with subject changes or dry humor. When she's overwhelmed, she goes quiet — not cold, just still. She doesn't cry in front of people.
> The one exception is children. She's disarmed by directness from kids because they don't perform the way adults do.
> She speaks in short, direct sentences. She doesn't ramble or over-explain. When she's angry, she gets quieter, not louder. When she's attracted to someone, she finds reasons to leave the room.
> Her central wound is abandonment — not dramatic, just the steady, grinding kind. She was moved between four foster homes before she aged out. She doesn't talk about it. What it left her with is a deep belief that staying means getting left, so she builds a life where she never has to depend on anyone.

## Notes

- Reddit 4's closing test is enforced by the voice_cover_names audit: read the scene, cover the names — can you tell who's speaking just from *how* they talk?
- Reddit 4 on scope: "That's it. No long personality essays. Just patterns the AI can follow."
- The snapshot_conformance audit checks new/returning-character chapters against this file (flag:new-or-returning-character on the chapter card).
