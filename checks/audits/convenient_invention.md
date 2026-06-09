# Audit: Convenient-Invention Fact-Check (post-edit diff vs canon)

id: convenient_invention | owner: codex | tier: core
trigger: every-revised-chapter
output: {audit_root}/codex/chapter_{NN}.convenient_invention.md   ({audit_root} = output/critiques for the drafter stage, output_edit/audits for the editor stage)
source: collation:3263-3271 [field guide 17: THE CONVENIENT INVENTION] + collation:5250-5254 [field guide: fact-checking after AI editing]

## Critique stance (mandatory)
Act as a skeptical professional editor, not an encouraging coach. No praise, no generic affirmations, no softening preambles. Find what is wrong and prove it with quoted evidence. LLMs have a documented bias toward agreement and performed-literary approval — counteract it. If a criterion genuinely passes, show your work anyway: name what you checked and quote the strongest counter-candidate you considered. A bare pass without per-criterion evidence is a FAILED audit. Findings must convert into revision orders, not commentary.

## What this audit checks

Source, verbatim (field guide 17):

> 17. THE CONVENIENT INVENTION
> This one is the most dangerous because it doesn't look like a style problem. It looks like good writing.
> The AI adds a detail that wasn't in your story because it makes the scene tidier. In a draft, goblins were observed crossing the mountains from west to east two chapters earlier. The AI, editing a later scene where the protagonist watches goblins after a skirmish, decided they were "heading north. Same as her."
> They weren't heading north. You never said they were heading north. Two chapters ago you explicitly established they were moving west to east. But the AI needed a dramatic closing beat — protagonist and threat on the same path, collision implied — so it invented one. And it sounds great. "And they were heading north. Same as her." Clean. Ominous. Wrong.
> This is AI editing at its most insidious: it doesn't just smooth your prose, it quietly rewrites your plot to be more conventionally dramatic. It will add motivations characters don't have, create connections between events that aren't related, and manufacture dramatic irony because dramatic irony feels satisfying. It will never tell you it did this. You'll only catch it if you remember your own story better than the AI does.

The fix, verbatim (field guide, fact-checking after AI editing):

> The fix: after any AI editing pass, check every concrete factual detail — directions, distances, character motivations, timeline, who knows what — against what you actually established. The prose-level changes are easy to evaluate. The invented facts will slip past you because they sound like things you might have written.

In this harness, "remembering your own story better than the AI does" is implemented as canon_sheet.md + story_bible.md. Hunt list (anything NEW in the post-edit text):
- **Details:** directions, distances, counts, colors, times, names, physical facts
- **Motivations:** any stated reason or desire a character did not previously have
- **Connections:** causal or thematic links between events that were unrelated pre-edit
- **Dramatic irony / convergence:** new knowing-glances, same-path beats, collision implications, foreshadowing
- **Knowledge transfers:** who-knows-what changes the edit smuggled in

Warning: inventions sound good — "Clean. Ominous. Wrong." Dramatic improvement is evidence FOR suspicion, not against it.

## Required verdict format

Open with: `DIFF SCOPE: {pre_edit_file} vs {post_edit_file} — N changed regions, N new factual assertions extracted`

Then one block per new fact/motivation/connection introduced by the edit:

```
INVENTION CANDIDATE #k
post-edit text: "<quote>"
pre-edit text at that point: "<quote or [absent]>"
class: detail | motivation | connection | dramatic-irony | knowledge
canon check: canon_sheet.md/story_bible.md says: "<quote or NO ENTRY>"
verdict: CANON-COMPATIBLE (consistent with or derivable from established canon — cite the entry)
       | INVENTED-FLAG (not established anywhere, or contradicts canon — cite the contradiction)
```

Every new assertion gets a block — including the ones that pass. A CANON-COMPATIBLE verdict must cite the specific canon entry that licenses it; "plausible" is not a license. If zero new assertions exist, prove it: state the diff size and quote the two most fact-like changed lines you examined and rejected as pure style.

Close with:
1. **Verdict:** NO-INVENTIONS / INVENTIONS (N flagged).
2. **Revision orders:** per INVENTED-FLAG, either (a) revert to the pre-edit fact (default — quote the restoration text), or (b) if the human/orchestrator elects to adopt the invention, the exact canon_sheet.md amendment required so it stops being an invention. No third option; an unadjudicated invention may not ship.

## Procedure (owner=codex)
1. Diff {pre_edit_file} against {post_edit_file} mechanically; work from the diff hunks, not from a re-read of the whole chapter.
2. From each hunk, extract every NEW concrete factual assertion per the hunt list — directions, distances, motivations, timeline, who-knows-what.
3. Verify each against canon_sheet.md + story_bible.md (and continuity.md for chapter-level facts); quote the canon line or its absence.
4. Emit one block per candidate, the verdict, and the revision orders; write the report to the output path. INVENTIONS marks the report ACTIONABLE-IMMEDIATE — adjudicate before the next pipeline stage consumes the edited chapter.
