# Audit: Catalog-Prose / System-Tour Audit

id: catalog_prose | owner: codex | tier: risk
trigger: watch:fieldguide-shopping-list + flag:worldbuilding-heavy
output: {audit_root}/codex/chapter_{NN}.catalog_prose.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:2703+ [Writing ruleset rule 13] + field guide 10

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
Writing ruleset rule 13, "Do not turn a piece into catalog prose or system-tour prose":

> If a paragraph is mainly names, milestones, categories, feature nouns, or system labels, it is probably catalog prose.
> If each paragraph can be summarized with a single label such as `background`, `mechanism`, `impact`, `response`, `ending`, the piece is probably system-tour prose.
> Do not give one paragraph to each milestone or one paragraph to each topic bucket unless that mapping is the actual point. Pick one change and trace its consequence. Cross-wire the piece so paragraphs depend on each other instead of sitting like labeled boxes.

Field guide item 10, THE SHOPPING LIST:

> Your character goes to a market. AI narrates every purchase.
> Hardtack. Five copper. Comment about the taste. Cheese. Four copper. Comment about shelf life. Smoked meat. Six copper. Comment about emergencies. Dried fruit. Three copper. Comment about variety. Oats. Four copper. Comment about porridge. Salt. Two copper. Comment about flavoring.
> Then the arithmetic: "One and a half silver gone, just like that."
> This also applies to gear checks ("Bow strung. Quiver full. Knife secure. Pack ready."), base tours ("They passed the gym. Then the laundromat. Then the formation area."), and ship descriptions ("Hull paragraph. Armor paragraph. Weapons paragraph. Engines paragraph. Bridge paragraph. Interior paragraph.").
> The fix: pick one or two items that reveal character or world. Summarize the rest. Nobody needs the receipt.

Criteria:

1. **Shopping-list passages.** Item-by-item narration of purchases, supplies, or inventory, with or without the closing arithmetic.
2. **Gear checks, base tours, ship/location descriptions.** The source's named variants:
   - sequential equipment confirmation ("Bow strung. Quiver full. Knife secure. Pack ready.");
   - then-they-passed location tours;
   - one-paragraph-per-subsystem descriptions of ships, buildings, or magic/tech systems.
3. **Catalog paragraphs.** Paragraphs that are mainly names, milestones, categories, feature nouns, or system labels (worldbuilding rosters, faction lists, history recitations).
4. **System-tour structure.** Chapter or scene structure where each paragraph reduces to a single label (`background`, `mechanism`, `impact`, `response`, `ending`) —
   - one paragraph per topic bucket, sitting like labeled boxes instead of depending on each other.
5. **Allowable mapping.** Rule 13's exception: one-paragraph-per-item is permitted only when that mapping is the actual point
   - (e.g., a list the character is ritually performing, a document quoted in-world).
   - The exception must be argued from the page, not assumed.

## Required verdict format
One verdict line per criterion (1-5):
- `TRACED` — passes; quote the strongest counter-candidate considered and why it survives.
- `CATALOG (instances)` — every flagged passage, quoted (long passages may be quoted by first and last line plus item count), with location.

Then `REVISION ORDERS`:
- One numbered order per finding applying the source fixes: pick the one or two items that reveal character or world and name them; summarize the rest.
- For system-tour structure: name the one change to trace and how the paragraphs get cross-wired.
- Nobody needs the receipt.
- End with `OVERALL: TRACED` or `OVERALL: CATALOG (count)`.

## Procedure (owner=codex)
1. Read {chapter_file} in full. Mark every passage that enumerates: purchases, gear, rooms, ranks, factions, subsystems, dishes, historical milestones.
2. Cross-check {watch_counts} for shopping-list watch hits, and scan for the telltale shapes:
   - noun-price-comment loops and closing arithmetic;
   - `Then they passed`, consecutive sentences of bare noun phrases;
   - paragraphs opening with a new system label.
3. For the chapter-level structural read (criterion 4): write a one-label summary of every paragraph in worldbuilding-heavy sections.
   - If the labels read like a tour itinerary, quote the label sequence as evidence.
4. Adjudicate each candidate against criterion 5's exception using {reading_guide_excerpts} and {voice_cards}:
   - Is the cataloging the actual point (in-voice ritual, in-world document), and does the page show it?
   - Default to fail when the only defense is "worldbuilding."
5. For each finding, identify the one or two items in the list that actually reveal character or world (use {prior_chapters_context} to judge what is load-bearing later) and write the revision order around keeping those and compressing the rest.
6. Write the completed audit, in the Required verdict format, to {audit_root}/codex/chapter_{NN}.catalog_prose.md.
