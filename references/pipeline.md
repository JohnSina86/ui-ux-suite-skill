# Pipeline

The stage-by-stage procedure. Each stage has an input, the action, an output (a short block you carry into the report) and a gate.

## Contents
- [Stage 1: Brief](#stage-1-brief)
- [Stage 2: Style](#stage-2-style)
- [Stage 3: Build](#stage-3-build)
- [Stage 4: Audit](#stage-4-audit)
- [Stage 5: Fix](#stage-5-fix)
- [Stage 6: Report](#stage-6-report)
- [Short modes](#short-modes)

## Stage 1: Brief
**Input:** the user's request and any project files you can see.

**Action:** fill the block below. Infer what you can from the project (framework, Tailwind, existing tokens, a content-security policy). Ask at most three questions, and only for facts that would change the outcome.

```markdown
### Brief
- Product and audience: [one line each]
- Surface type: [Marketing & Landing | SaaS & Dashboard | Form & Wizard | Content & Docs]
- The 3 tasks a user must complete: [verbs, in order of importance]
- Existing design system: [none | tokens file path | component library]
- Stack and constraints: [framework, Tailwind version, CSP or font policy, platform, "no new dependencies"]
- Assumptions made: [list, or "none"]
```

In plain-language mode, collect the Brief with the three questions in [guided-start.md](guided-start.md) instead.

**Site sweep (a scope, not a mode).** Decide the mode first (`SKILL.md` section 1). Only when it is Polish or Full, and the user names a site, several pages, or "desktop and mobile", add a coverage plan to the Brief, following `ux-laws` `references/multi-surface.md`. In Design or Advise mode, "desktop and mobile" is a build constraint, not an audit request.
```markdown
- Coverage plan: [routes grouped by template; pages chosen per template (at least one, plus every page the user named); viewports (default: the ux-laws page-probe set); surface type per template]
```
The plan becomes the coverage matrix in the report. Each cell is later marked measured, screenshot only, source only, or not measured with a reason.

**Gate:** every field is filled or marked as an assumption. The surface type matters, because `ux-laws` applies a different set of laws to each type. In a site sweep, each template has its own surface type.

## Stage 2: Style
**Input:** the Brief block.

**Action:** follow `ui-styles` sections 0 to 2. If the user named a style, use it. If they named a product, use the product-fit table and propose two styles with one reason each. If nothing fits, say there is **no verified match**, and label any fallback as unverified. If the request is only advice, stop here and answer.

```markdown
### Style decision
- Style: [id] (primary) / [id] (secondary, or "none")
- Why: [one reason per style, tied to the brief]
- Risk and its `Requires` rule: [from the style index]
- Existing system handling: [accent layer on <tokens> | new base]
- Match status: [indexed | no product row, indexed style fits | no verified match, unverified fallback]
```

**Gate:** the block is written. A style you *recommend* is never one listed under Avoid for this product. A style the user *named* stands: apply its `Requires` rule, and disclose any product-fit Avoid or risk note in the block.

## Stage 3: Build
**Input:** the Style decision block.

**Action:** follow `ui-styles` sections 3 to 7: paste the style's token block, build components from the roles, and apply the guardrails. Read its resources reference only if the user asked for ready-made components, icons, fonts or charts, and follow its rules.

```markdown
### Build manifest
- Files created or changed: [paths]
- Tokens: [file and class, or the existing tokens the style was mapped onto]. Say "unchanged" only if the pasted block is identical to the source, and list every edit otherwise (font stacks count).
- Colour pairs used: [ledger row ids, plus any pair you recomputed, with its two luminances and its ratio]
- Dependencies added: [none, or name and the user's agreement]. Write "none" only after searching every delivered file, demo pages included, for `http://` and `https://`.
- Rendered and checked in a browser: [yes, with the tool named | no]. Never "yes" for a code or DOM read.
```

**Gate:** the `ui-styles` pre-delivery checklist is done, except for items that need a render (narrow width, 200% zoom, observed focus, reduced motion). If you couldn't render the result, keep those items **open**, list them in the manifest as "Not verified: needs a render", and go on to stage 4 with source code as its evidence. Don't call the whole checklist done.

## Stage 4: Audit
**Input:** the built result and the Brief block's three tasks.

**Action:** follow `ux-laws` and produce its report structure. Choose the evidence source honestly:
- A live page you can open: use it, and use the hit-testing method for any target-size or overlap claim.
- Source code only: grade what the code shows, and mark every law that needs live behaviour or usage data **Not assessed**, naming the evidence needed.
- Screenshot or description only: say so, and grade only what that can show.

Use the `ux-laws` interop table as a starting point for what to inspect, never as a finding. State plainly if this is a **self-audit** of something you just built.

On a live page, **measure before grading**: run `ux-laws` `references/page-probe.md` on every covered page and viewport, and apply its false-positive rules. In a site sweep, classify, combine and close findings per `ux-laws` `references/multi-surface.md`: one 20-row table per template, every Fail or Warning citing its page and viewport, gaps listed, and no site-wide score.

**Independence.** If the UI was built or edited in this session, prefer a fresh-context audit: follow [independent-audit.md](independent-audit.md). A code review or inspection is not a UX audit and never passes this gate.

```markdown
### Audit summary
- Evidence source: [live | source code | screenshot | description]
- Coverage: [pages × viewports measured, and gaps; or "one surface"]
- Self-audit: [yes | no, independent fresh context per independent-audit.md]
- Score line: [as defined by `ux-laws`, per template in a sweep, or "no score, insufficient evidence"]
- Fail and Warning rows: [law, one-line evidence, page and viewport]
- Unscored findings: [probe diagnostics that need action whether or not a law grades them, such as horizontal overflow: what, page and viewport; or "none"]
- Not assessed: [law, evidence needed]
```

**Unscored findings** are probe results the `ux-laws` false-positive rules call findings, such as document overflow, but which no law row grades on its own. They stay unscored and never change the score, but they go through stage 5 and the report like rows do.

**Gate:** the `ux-laws` audit-completeness checklist is done (for each template in a sweep), the coverage matrix accounts for every planned cell, and every unscored finding is listed.

## Stage 5: Fix
**Input:** the Fail and Warning rows, and the unscored findings.

**Action:** turn each into a concrete edit. Order them by severity, and fix in one batch. For each edit, apply [conflict-rules.md](conflict-rules.md) if it touches colour, size or the style's look. Recompute any changed colour pair with `ui-styles` `references/contrast-check.md` and update its ledger row or note. Then re-audit the changed rows **once**, with fresh evidence at every occurrence the finding cited, of a kind that can show it (`ux-laws` `references/multi-surface.md` §4). Geometry and overflow need a new live measurement, or a labelled static estimate when no page can be opened. A defect the source proves, such as an untyped Cancel button, can close on the corrected source.

```markdown
### Fix log
| Row | Change | Files | Re-checked (before → after, per occurrence) |
| :--- | :--- | :--- | :--- |
| [law and finding] | [what changed] | [paths] | [Warning → Pass: 66×19 → 66×49 @375 on /a/, /b/ | still open, why] |
| [Unscored: overflow on /c/ @375] | [what changed] | [paths] | [overflowX 188 → 0 @375 on /c/ (fixed) | deferred, why] |
```

**Re-audit output is row changes, not a new score.** The report's only headline score is the stage-4 score. A post-fix score may appear only labelled "indicative, edits only", never as a headline. A finding closes only with new evidence, of a kind that can show it, at every occurrence it cited; an occurrence that wasn't checked again stays open.

**Gate:** every Fail and Warning, and every unscored finding, is fixed with re-check evidence or deferred with a reason. If any remain after the one re-audit, they go into the report as open risks. Don't loop again.

## Stage 6: Report
Assemble [report-template.md](report-template.md). Keep each section short and link to the files, but include the **full `ux-laws` audit** (all 20 rows, the counts, the conformance notes, per template in a sweep) inside the report so the score can be checked from the document alone.

**Where it goes.** Write the report to a git-ignored scratch folder in the project if one exists: check `.gitignore` for `output/`, `tmp/` or similar. Otherwise ask once, or deliver it inline. Never write it into tracked source, and say where it went.

## Short modes
- **Advise:** stages 1 and 2, then answer with the recommendation, reasons and risk. No CSS or files unless asked.
- **Design:** stages 1, 2, 3 and 6. Note in the report that no audit was run, and offer one.
- **Polish:** a short brief, stage 4, stage 5, one re-audit and the report. If the user also asked for a restyle, run stages 2 and 3 for the parts they named after the audit and before the fixes, so the audit comes first. Otherwise don't restyle anything the findings don't touch.
- **Review only:** not a mode here. A review with no fixes asked for goes to `ux-laws` alone.
