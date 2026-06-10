# Audit: Weasel-Attribution Audit

id: weasel_attribution | owner: codex | tier: risk
trigger: watch:wp-aiweasel-vague-attribution
output: {audit_root}/codex/chapter_{NN}.weasel_attribution.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: wikipedia:WP:AIWEASEL

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks
WP:AIWEASEL, "Vague attributions and overgeneralization of opinions": AI chatbots tend to attribute opinions or claims to some vague authority — a practice called weasel wording.
- Its actual Words to watch: **Industry reports, Observers have cited, Experts argue, Some critics argue, several sources/publications (when only few sources are cited), such as (before exhaustive word lists)**.
- The section also documents the companion failure: AI chatbots commonly exaggerate the quantity of sources opinions are attributed to —
  - presenting views from one or two sources as widely held (often combined with the vague attributions above);
  - mentioning the existence or opinion of multiple "reviewers" or "scholars" while only citing one person;
  - implying that lists of examples are non-exhaustive when there is no indication other examples exist.

Fiction adaptation — the weasel move in narration is the unattributed consensus claim used as fake authority:

1. **Unattributed consensus in narration.** "Everyone knew", "people said", "it was said that", "word was", "they all agreed", "no one doubted", "it was common knowledge", "the whole town/village/crew believed".
   - Narration borrowing the authority of a crowd it never shows.
   - Each instance must answer: who, specifically, knows/says this, and how does the focalizer know they do?

2. **Vague expert classes.** The fiction cousins of "Experts argue":
   - "the elders said", "scholars claimed", "soldiers knew", "those who understood such things", "anyone who had fought in the marshes" —
   - opinion assigned to an off-page class no member of which ever appears.

3. **Crowd inflation.** The exaggerated-quantity failure in scene form:
   - one character's stated opinion silently scaled up to a faction or public ("the men were starting to talk" when one man talked; "rumors swirled" sourced to a single overheard remark).
   - Cross-check each crowd claim against what the page actually dramatized.

4. **Non-exhaustive gesturing.** "Such as" / "among other things" / "and more besides" used to imply unshown breadth —
   - lists of grievances, rumors, or exploits presented as samples of a larger set the book never establishes.

5. **Allowable forms.** Do not flag:
   - a focalizer characterized as trafficking in hearsay, where the vagueness is the characterization and the book costs it;
   - an established communal/village-voice narrator licensed by {reading_guide_excerpts};
   - consensus claims the narrative has actually earned on-page (the reader has met the crowd);
   - dialogue — characters may weasel freely, that is speech.
   - The target is narration claiming authority it has not dramatized.

## Required verdict format
One verdict line per criterion (1-5; criterion 5 reports allowances exercised, with the license cited):
- `GROUNDED` — passes; quote the strongest counter-candidate considered and why it survives.
- `WEASEL (instances)` — every flagged span, quoted, with location and the unanswered question (who? how known? how many really?).

Then `REVISION ORDERS`:
- One numbered order per finding — attach the claim to a named character, scene, or dramatized source; scale the crowd back to what the page supports; or cut the authority gesture and let the fact stand alone.
- End with `OVERALL: GROUNDED` or `OVERALL: WEASEL (count)`.

## Procedure (owner=codex)
1. Read {chapter_file} in full, marking every narration sentence that asserts what some collective or unnamed authority knows, says, believes, or feels.
2. Cross-check {watch_counts} for wp-aiweasel watch hits and grep for the fiction shapes:
   - `everyone knew`, `people said`, `it was said`, `word was`, `rumors`, `no one doubted`, `common knowledge`, `they say`, `the elders`, `those who`, `such as`, `among other`.
   - Adjudicate every hit in context; discard dialogue hits under criterion 5 but log them as checked.
3. For each candidate, write down the unanswered question it raises (who specifically? how does the focalizer know? how many actually?) and search the chapter and {prior_chapters_context} for an on-page answer.
   - An answered question is a pass — quote the answering scene.
   - An unanswered one is a finding.
4. For criterion 3, list each crowd-scale claim against the dramatized headcount.
   For criterion 4, check whether the implied larger set exists anywhere in the book's established material.
5. Apply criterion 5's allowances using {reading_guide_excerpts} and {voice_cards}; every exercised allowance must cite its license line.
6. Write the completed audit, in the Required verdict format, to {audit_root}/codex/chapter_{NN}.weasel_attribution.md.
