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

**Gate:** every field is filled or marked as an assumption. The surface type matters, because `ux-laws` applies a different set of laws to each type.

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
- Colour pairs used: [ledger row ids, plus any pair you recomputed and its ratio]
- Dependencies added: [none, or name and the user's agreement]
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

```markdown
### Audit summary
- Evidence source: [live | source code | screenshot | description]
- Self-audit: [yes | no]
- Score line: [as defined by `ux-laws`, or "no score, insufficient evidence"]
- Fail and Warning rows: [law, one-line evidence, location]
- Not assessed: [law, evidence needed]
```

**Gate:** the `ux-laws` audit-completeness checklist is done.

## Stage 5: Fix
**Input:** the Fail and Warning rows.

**Action:** turn each into a concrete edit. Order them by severity, and fix in one batch. For each edit, apply [conflict-rules.md](conflict-rules.md) if it touches colour, size or the style's look. Recompute any changed colour pair and update its ledger row or note. Then re-audit the changed rows **once**.

```markdown
### Fix log
| Row | Change | Files | Re-checked |
| :--- | :--- | :--- | :--- |
| [law and finding] | [what changed] | [paths] | [pass | still open, why] |
```

**Gate:** every Fail and Warning is fixed, or deferred with a reason. If rows remain after the one re-audit, they go into the report as open risks. Don't loop again.

## Stage 6: Report
Assemble [report-template.md](report-template.md). Keep each section short and link to the files, but include the **full `ux-laws` audit** (all 20 rows, the counts, the conformance notes) inside the report so the score can be checked from the document alone.

## Short modes
- **Advise:** stages 1 and 2, then answer with the recommendation, reasons and risk. No CSS or files unless asked.
- **Design:** stages 1, 2, 3 and 6. Note in the report that no audit was run, and offer one.
- **Polish:** a short brief, stage 4, stage 5, one re-audit and the report. If the user also asked for a restyle, run stages 2 and 3 for the parts they named after the audit and before the fixes, so the audit comes first. Otherwise don't restyle anything the findings don't touch.
- **Review only:** not a mode here. A review with no fixes asked for goes to `ux-laws` alone.
