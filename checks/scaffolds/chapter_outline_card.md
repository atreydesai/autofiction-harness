# Scaffold: Chapter Outline Card

artifact: {workspace}/outline/chapter_cards.md (one card per chapter or tight cluster)
purpose: per-chapter contract — what the chapter must do, what must change, what the reader must feel, what risks it carries, and which audits its flags route
created: drafter Phase 5 (cards expanded from the chosen architecture), revised after Phase 6 critique
updated: consciously, when a draft discovers something better ("I did not treat the outline as a prison. If a draft discovered something better, I changed the outline. But I changed it consciously."); flags re-set at drafting time
updated_by: orchestrator
source_ref: collation:5541-5561 [Reddit 9 "4. Outline by chapter, but not too rigidly"] + legacy drafter task Phase 5 chapter-card bullets (genericized) + collation:4707-4736 [Novel process scene/sequence/chapter planning: Goal-Conflict-Setback / Reaction-Dilemma-Decision] + checks/audit_manifest.tsv flag routing

## Source baseline (Reddit 9, verbatim)

> Each chapter in my outline had a simple structure:
>
> - POV
> - Goal
> - Conflict
> - Revelation
> - Notes
> - Cliffhanger or resonant close
>
> The key is that every chapter needs something to change. It does not have to be a plot twist. It can be a relationship shift, a new piece of information, a decision, a loss, or a change in how the reader understands something.
> But if there is no goal, no conflict, and no revelation, the chapter usually reads flat.

## Card template

```
CHAPTER CARD — <NN>: <working title>

### Outline core (Reddit 9 fields)
- POV: <placeholder>
- Goal: <placeholder>
- Conflict: <placeholder>
- Revelation: <placeholder>
- Notes: <placeholder>
- Cliffhanger or resonant close: <placeholder>

### Full card (legacy fields, all required)
- working title
- POV/focalizer
- form: <the form vocabulary the reading guide establishes — e.g. close-third /
  documentary / epistolary / narrator-interlude / hybrid>
- chapter function in the architecture
- scene engine and central pressure
- what changes irreversibly by end (pressure, knowledge, relationship, public
  consequence, irreversible state)
- **felt experience the reader leaves with**: single sentence — what does the reader
  FEEL at chapter end (dread / recognition / laugh-with-wince / discomfort /
  hope-against-hope / grief / vindication / etc.). NOT what they know. LLMs default to
  information-transfer chapters when not explicitly pushed against this; the card must
  commit to a felt experience and the chapter must produce it.
- character desire and conflict (what each wants, what each will spend/risk)
- reveal/payoff obligations (what sets up; what pays off) — cross-ref thread ledger
- new load-bearing terms / names / institutions / mechanics introduced here
- reader-load risk (where this chapter could become dense or effortful)
- dialogue risks and what dialogue should accomplish
- prose stance and anti-tics for the chapter
- motif instances this chapter carries (if the reading guide tracks motifs)
- drafting/synthesis lane: <dual-draft / single-seed + opposing critique /
  scene-level competing drafts>

### Scene design (per scene in the chapter)
| scene | type | beats |
|---|---|---|
| <n> | proactive | Goal: <placeholder> / Conflict: <placeholder> / Setback: <placeholder> |
| <n> | reactive | Reaction: <placeholder> / Dilemma: <placeholder> / Decision: <placeholder> |
A scene should be one or the other (proactive Goal–Conflict–Setback or reactive
Reaction–Dilemma–Decision), and the units naturally chain into each other.

### Audit-trigger flags (set every one that applies; these route the harness's risk-tier audits)
[ ] flag:dialogue-scenes          -> dialogue_doctor
[ ] flag:violence                 -> clean_fight_test
[ ] flag:dark-content             -> sanitization_audit
[ ] flag:comic-register           -> comedy_doctor
[ ] flag:figuration-heavy         -> figuration_audit
[ ] flag:multi-character-scene    -> reaction_divergence
[ ] flag:mentor-scene             -> mentor_scene_check
[ ] flag:high-leverage-scene      -> set_piece_intensity
[ ] flag:dense-or-system-heavy    -> clarity_pass
[ ] flag:emotional-peak           -> earned_test
[ ] flag:reflective-chapter       -> thought_development
[ ] flag:worldbuilding-heavy      -> catalog_prose
[ ] flag:protagonist-heavy        -> narrator_publicist
[ ] flag:plan-succeeds-easily     -> fair_world_consequences
[ ] flag:card-names-tension       -> tension_naming
[ ] flag:new-or-returning-character -> snapshot_conformance
[ ] flag:recurring-conversation   -> chat_variety
(see checks/audit_manifest.tsv for the full flag -> audit routing, including
flag:lyric, flag:stylized-prose, and flag:register-drift)
```

## Card discipline

- The goal is not to ban complexity, jargon, lyricism, or mystery. The goal is to decide what kind of difficulty the reader is meant to enjoy here and which competing difficulties should be delayed, translated through action, or recast as atmosphere. [legacy]
- If a card's only function is "advance plot," the card is not done; every chapter needs something to change (relationship shift, new information, a decision, a loss, a change in reader understanding). [Reddit 9]
- A card with no goal, no conflict, and no revelation predicts a flat chapter — fix the card before drafting, not the prose after.

## Mini-example (outline core only)

```
- POV: Sera
- Goal: get the magistrate to unseal the inquest record
- Conflict: he will trade it only for testimony that damns Hale
- Revelation: the record was already unsealed once — someone signed for it
- Notes: first time Sera lies to Yune by omission; carry burned-hand limit
- Cliffhanger or resonant close: the signature on the register is in her brother's hand
- felt experience the reader leaves with: dread — the cost of knowing has just landed on family
```
