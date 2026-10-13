# Combined report template

One report for the whole job. Keep each section short, link to files, and skip a section only when its stage wasn't in the mode. Say so when you skip one.

```markdown
# UI/UX package: [project or screen]

## In plain words  (plain-language mode only; see plain-language.md)
[at most 120 words: what you have and how to open it, what is in good shape, what I couldn't check, where you are (level), your next step]

## Summary
- **Mode**: [Advise | Design | Full | Polish] [+ site sweep]
- **Outcome**: [two sentences: what exists now, and the main open risk]
- **Not run**: [stages skipped and why, or "none"]
- **Report location**: [path, and that it is git-ignored, or "inline"]

## 1. Brief
[the Brief block, with the coverage plan in a site sweep]

## 2. Style decision
[the Style decision block, including match status and the style's Requires rule]

## 3. What was built
[the Build manifest]
- **Colour pairs**: [ledger row ids, plus recomputed pairs printed with both luminances]
- **Rendered in a browser**: [yes | no]
- **Anti-slop**: [gate result (pass | fail | inconclusive) per page with its assessed coverage and rubric version; the five "Could this be any site?" answers; retained choices with their record; unresolved claims. Inconclusive is never written as a pass. Tells are craft findings and sit under unscored findings in section 4, never as law rows.]
- **Type, imagery and reveal**: [type scale and floors, imagery kind, the `choreography:` line or "none"]

### Copy (`ui-copy`)
- **Voice brief**: [the block, marked assumed if the suite wrote it]
- **Strings checked**: [count and where; detector tells before and after; or "Not run: `ui-copy` unavailable"]
- **Preserved copy**: [strings kept unchanged, with any unresolved violation listed as a proposal, not as passing]
- **Needs a fact**: [`[needs a fact: what]` items, or "none"]

## 4. UX audit
- **Evidence source**: [live | source code | screenshot | description]
- **Coverage**: [the matrix below in a site sweep, or "one surface"]
- **Self-audit**: [yes | no, independent: route used, per independent-audit.md]
- **Score line**: [from the ux-laws report, per template in a sweep; never a site-wide score]
- **Fail and Warning rows**: [law, evidence, page and viewport]
- **Unscored findings**: [probe results that need action but no law grades, such as horizontal overflow: what, page and viewport; remaining anti-slop tells, marked retained or unresolved; or "none"]
- **Not assessed**: [law, evidence needed]
- **Scope note**: Usability heuristics only. This is not a WCAG conformance result.

### Coverage  (site sweep only)
| Page (template) | 375 | 768 | 1440 |
| :--- | :--- | :--- | :--- |
| [route (template)] | [measured / screenshot / source / not measured: reason] | … | … |

### Full audit (the complete ux-laws report: all 20 rows, counts, band, conformance notes, completeness checklist; one per template in a sweep)
[paste it here, in the ux-laws structure]

## 5. Fixes made
[the Fix log: row changes and unscored findings, before → after, per occurrence; each fixed with evidence or deferred with a reason]
- **Copy re-check**: [every string the fixes created or changed, checked with `ui-copy`, with the detector count; also in Polish mode]
- **Re-audit**: [rows changed, with evidence; any post-fix score labelled "indicative, edits only"]

## 6. Spec and content fidelity
[where the UI departs from a source the user supplied (a copy document, a ticket, acceptance criteria, supplied copy): what the source says, what the UI does, the location. Preserved copy that fails a `ui-copy` rule appears here as a proposed change, with the rule it failed. "None found", or "no source supplied". Not graded as law rows.]

## 7. Decisions for the owner
[choices the work surfaced but must not make alone (positioning, which action is primary, copy), each with a recommendation and its trade-off. "None" if empty.]

## 8. Open risks and next steps
- [remaining Fail or Warning rows and unscored findings, with the reason each stayed open]
- [coverage gaps]
- [what would change the audit: a rendered page, analytics, a conformance review]
- [dependencies added, and whether the user agreed to them]
```

## Checks before sending
- Every section either filled or marked skipped, and the **Not run** line complete.
- If an audit ran, the full 20-row table is in the report (one per template in a sweep) and the summary numbers match it.
- The numbers in the summary match the rows beneath them. There is no site-wide score.
- The only headline score is the pre-fix score; a re-audit shows row changes.
- Every unscored finding appears in the audit and in the fix log, as fixed with evidence or deferred with a reason, and none changed the score.
- In a site sweep, the coverage matrix accounts for every planned cell, and gaps are listed under open risks.
- Spec deviations sit in section 6 and owner decisions in section 7, not inside law rows, and nothing in section 7 was acted on without the user.
- The anti-slop result states its coverage, no inconclusive result is written as a pass, and no tell appears as a law row or in the score.
- The copy section shows the strings checked and the detector counts, and no preserved string was changed.
- No claim of accessibility or WCAG conformance anywhere in the report.
- In plain-language mode: the plain block comes first, uses everyday wording, names the level and one next step, and the full report below it is unchanged.
