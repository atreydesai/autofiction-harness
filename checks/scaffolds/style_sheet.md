# Scaffold: Style Sheet

artifact: {workspace}/style_sheet.md
purpose: the copyediting style sheet — every spelling, hyphenation, capitalization, number, invented-term, and punctuation decision the book makes, recorded once so it is made the same way everywhere
created: started during drafting (first invented term creates it); becomes a first-class artifact during line/copy editing
updated: during line editing and copyediting, whenever a decision is made; "Keep a master style sheet" — archive with each major stage
updated_by: editor stage (orchestrator during drafting for invented terms)
source_ref: collation:6841-6851 + 6899 [Academic manual: Copyediting and proofreading; working with professional editors] + collation:7298-7314 [Writing ruleset: compound-modifier hyphenation]

## Source spec (verbatim)

> Copyediting focuses on grammar, punctuation, spelling, consistency, formatting, and clarity at the level of publishable correctness. It should also produce or maintain a **style sheet** recording spelling decisions, hyphenation, capitalization, numerals, timeline notes, recurring character facts, and any idiosyncratic stylistic rules your novel uses intentionally. A novel with multiple foreign terms, special calendars, epistolary elements, or fantasy proper nouns especially needs this.

And: "Keep a master style sheet. If you radically revise after copyediting, expect to need another cleanup round. That is not failure; it is workflow reality."

## Template

```
STYLE SHEET — <project>

## Spelling choices
| term | chosen form | rejected variants | first use (ch) |
|---|---|---|---|
| <placeholder> | <placeholder> | <placeholder> | <NN> |

## Hyphenation
| compound | before a noun | after the noun / predicative | notes |
|---|---|---|---|
| <placeholder> | <hyphenated form> | <open form> | <placeholder> |
Rule pointer — compound modifiers (Writing ruleset): "For temporary compounds, hyphenate
before the noun: `a well-known author`, `a high-quality service`, `a long-term plan`.
After the noun, often after a linking verb, usually open the compound: `The author is
well known`, `The service is high quality`, `The plan is long term`." Do not let the
model turn every compound into a hyphenated unit; keep hyphens that prevent ambiguity
or are conventional (`state-of-the-art`, `cost-effective`). The problem is the reflex,
not the mark. (Mechanically watched via checks/patterns/ predicative-over-hyphenation.)

## Capitalization
| term / title / rank / institution | capitalized when | lowercase when |
|---|---|---|
| <placeholder> | <placeholder> | <placeholder> |

## Numbers and numerals
<placeholder — spell out vs numerals threshold; times of day; dates; ages; money;
special calendars or dating systems the book uses>

## Invented terms (coined words, fantasy proper nouns, foreign terms, place names)
| term | spelling | plural / possessive / verb forms | italicized? | gloss |
|---|---|---|---|---|
| <placeholder> | <placeholder> | <placeholder> | <yes/no> | <placeholder> |

## Punctuation conventions
<placeholder — dialogue punctuation and interruption style; em dash vs spaced en dash;
serial comma; ellipsis style; thought-rendering (italics or not); epistolary/document
formatting conventions if the book uses them>

## Timeline notes
<placeholder — cross-reference {workspace}/timeline.md; record date-format decisions here>

## Recurring character facts
<placeholder — cross-reference the continuity log; record the spelling-level facts here
(name forms, nicknames, honorifics, eye/hair only if the book commits to them)>

## Idiosyncratic intentional rules
<placeholder — any rule the novel breaks on purpose, so the copyedit pass does not
"fix" it; each entry needs a defense (which chapter card or voice card licenses it)>
```

## Mini-example rows

```
| grey | grey | gray | 01 |            (spelling)
| tide-locked | tide-locked harbor | the harbor is tide locked | temporary compound |
| the Winter Court | when naming the institution | "a winter court" generic use |
```
