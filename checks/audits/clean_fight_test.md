# Audit: Clean-Fight Test (violence realism)

id: clean_fight_test | owner: claude | tier: risk
trigger: flag:violence
output: {audit_root}/claude/chapter_{NN}.clean_fight.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:2236-2245 [field guide 12]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
Field guide item 12, THE CLEAN FIGHT:

> AI writes combat like a film editor — clean hits, clear cause and effect, bodies that fall cinematically.
> "The first swing took a goblin's head clean off." "He dropped like a sack of grain."
> Real violence (and good fictional violence) is clumsy, ugly, and full of things that don't work on the first try. Blades get stuck. People fall down and try to get up and can't. Wounds don't kill instantly — they bleed and hurt and the person keeps trying to fight while their body fails them. If every kill in your scene is one clean motion, your combat reads like choreography.

Criteria:

1. **One-clean-motion kills.** Every kill or decisive blow audited individually:
   - Does it complete in a single clean motion with cinematic cause and effect ("took a goblin's head clean off," "dropped like a sack of grain")?
   - A scene where every kill is one clean motion fails categorically.

2. **Friction inventory.** Does the violence contain things that don't work on the first try —
   - blades that get stuck, grips that slip, people who fall down and try to get up and can't, blows that land wrong?
   - Absence of any friction across a whole fight is a finding even if no single beat is flagrant.

3. **Wound realism.** Wounds that kill instantly and tidily fail.
   - The source's standard: wounds bleed and hurt and the person keeps trying to fight while their body fails them.
   - Audit every wound for continued cost — to the wounded and to the fighter who must deal with a body that is failing rather than a body that is gone.

4. **Adrenaline misreports.** Fighters under adrenaline perceiving the fight with editorial clarity —
   - clean spatial awareness, accurate damage assessment, composed tactical interiority — read as choreography from the inside.
   - Perception in a fight should misreport: injuries unnoticed until later, time distortion, tunnel vision, wrong guesses about what just happened.

5. **Calibration, not gore inflation.** The standard is clumsy/ugly/unreliable, not maximally graphic.
   - A brief or stylized fight can pass if its violence carries friction and cost within the book's register ({reading_guide_excerpts}).
   - An extended gore sequence can still fail if every motion works the first time.

## Required verdict format
One verdict line per criterion (1-5):
- `UGLY` — passes (the violence is appropriately clumsy/costly); quote the strongest counter-candidate considered — the cleanest beat in the scene — and why it survives.
- `CHOREOGRAPHED (instances)` — every flagged beat, quoted, with location.

Then `REVISION ORDERS`:
- One numbered order per finding stating which beat must acquire friction and what kind (stuck blade, failed rise, wound that costs ongoing, misreported perception).
- Friction must be built from the scene's own props, terrain, and bodies — not generic injects.
- End with `OVERALL: UGLY` or `OVERALL: CHOREOGRAPHED (count)`.

## Prompt template (owner=claude)
You are auditing the violence in chapter {NN} against the clean-fight test. Begin from the Critique stance above.

Inputs:
- Chapter text: {chapter_file}
- Reading-guide register and violence commitments: {reading_guide_excerpts}
- Voice cards (combat experience and perception styles of those present): {voice_cards}
- Watch counts: {watch_counts}
- Prior-chapter context (existing injuries, established fighting skill): {prior_chapters_context}

Procedure:
- Isolate every violent beat — each strike, kill, wound, fall, and struggle — and tabulate it: motion attempted, did it work on the first try, what it cost, how the focalizer perceived it.
- Apply criteria 1-5 with quoted evidence.
- Respect established competence: a master fighter may be efficient, but efficiency is not frictionlessness — even expert violence meets resistant bodies, bad footing, and weapons that behave like objects.
- Cross-check wounds against {prior_chapters_context}: injuries carried into this chapter must still be failing the body here.
- Injuries inflicted here must be costed forward in your revision orders if the chapter forgets them.

Write the completed audit, in the Required verdict format, to {audit_root}/claude/chapter_{NN}.clean_fight.md.
