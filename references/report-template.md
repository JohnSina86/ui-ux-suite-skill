# Combined report template

One report for the whole job. Keep each section short, link to files, and skip a section only when its stage wasn't in the mode. Say so when you skip one.

```markdown
# UI/UX package: [project or screen]

## In plain words  (plain-language mode only; see plain-language.md)
[at most 120 words: what you have and how to open it, what is in good shape, what I couldn't check, where you are (level), your next step]

## Summary
- **Mode**: [Advise | Design | Full | Polish]
- **Outcome**: [two sentences: what exists now, and the main open risk]
- **Not run**: [stages skipped and why, or "none"]

## 1. Brief
[the Brief block]

## 2. Style decision
[the Style decision block, including match status and the style's Requires rule]

## 3. What was built
[the Build manifest]
- **Colour pairs**: [ledger row ids, plus recomputed pairs with their ratios]
- **Rendered in a browser**: [yes | no]

## 4. UX audit
- **Evidence source**: [live | source code | screenshot | description]
- **Self-audit**: [yes | no, and whether a fresh-session review is advised]
- **Score line**: [from the ux-laws report]
- **Fail and Warning rows**: [law, evidence, location]
- **Not assessed**: [law, evidence needed]
- **Scope note**: Usability heuristics only. This is not a WCAG conformance result.

### Full audit (the complete ux-laws report: all 20 rows, counts, band, conformance notes, completeness checklist)
[paste it here, in the ux-laws structure]

## 5. Fixes made
[the Fix log, with the result of the one re-audit]

## 6. Open risks and next steps
- [remaining Fail or Warning rows, with the reason each stayed open]
- [what would change the audit: a rendered page, analytics, a conformance review]
- [dependencies added, and whether the user agreed to them]
```

## Checks before sending
- Every section either filled or marked skipped, and the **Not run** line complete.
- If an audit ran, the full 20-row table is in the report and the summary numbers match it.
- The numbers in the summary match the rows beneath them.
- No claim of accessibility or WCAG conformance anywhere in the report.
- In plain-language mode: the plain block comes first, uses everyday wording, names the level and one next step, and the full report below it is unchanged.
