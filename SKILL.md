---
name: ui-ux-suite
description: >-
  Runs a complete UI/UX job in order: brief, style choice, build, evidence-based UX audit, fixes and one combined report, using the ui-styles and ux-laws skills. Use when the user wants a design built and checked, or a UX review followed by fixes. Not for a single task one of those skills covers alone, WCAG conformance audits or performance profiling.
license: MIT
metadata:
  version: "1.0.1"
---

# UI/UX Suite

This skill is the **conductor**. It owns the order of work, the handoffs between stages and the single report. It owns **no** tokens, recipes or laws: those live in `ui-styles` and `ux-laws`, and you read them there. Never copy their content into your answer from memory, because the copies would drift.

## 0. Before you start (mandatory)
1. **Check both skills are available** in this session. If one is missing, say which, give the install line from [README.md](README.md), and continue only with the stages that don't need it. Mark each skipped stage **Not run: `<skill>` unavailable**, and never recreate the missing skill's content from memory.
2. **Existing design system first.** The `ui-styles` rule applies to the whole job: map a style onto the project's own tokens as an accent layer, and replace the system only if the user asks.
3. **Honour stated constraints** (platform, framework, content-security policy, "desktop only", no new dependencies). Ask at most three questions, and only when the answer changes the work. Otherwise state your assumption and go on.
4. **Pick the mode** in section 1, and say which one you chose.

## 1. Modes
| The user wants | Mode | Stages |
| :--- | :--- | :--- |
| A style recommendation only | **Advise** | 1, 2, then stop |
| A new UI or a restyle, with no checking asked | **Design** | 1, 2, 3, 6 |
| A UI built and checked | **Full** | 1 to 6 |
| An existing UI reviewed and then fixed, or fixed and restyled | **Polish** | 1 (short), 4, then 2 and 3 only if a restyle was asked, 5, one re-audit, 6 |

**Constraints are not audit requests.** "Keep it usable", "make it accessible" and "keep the look" shape the build or the fix. Choose Full or Polish only when the user asks you to review, check, audit or test, or to fix a problem. "Make this look Y2K but keep it usable" is Design.

If the request is a single task, route it directly. "Make this Neo-Brutalist" is `ui-styles` alone, and "audit the UX of this page" is `ux-laws` alone. A review with no fixes asked for is `ux-laws` alone, so there is no Audit mode here. Don't run the pipeline around a request that one skill covers.

## 2. Pipeline
Details, handoff blocks and gates are in [pipeline.md](references/pipeline.md). Each stage ends with a gate. Don't start the next stage until its gate passes.

| # | Stage | Skill that does the work | Gate |
| :-: | :--- | :--- | :--- |
| 1 | **Brief**: product, audience, surface type, constraints, the 3 tasks users must complete | this skill | Brief block written |
| 2 | **Style**: choose with reasons, risk and the style's `Requires` rule, or flag "no verified match" | `ui-styles` sections 0 to 2 | Style decision block written |
| 3 | **Build**: tokens, components, guardrails | `ui-styles` sections 3 to 7 | `ui-styles` pre-delivery checklist done |
| 4 | **Audit**: grade the result against observable evidence | `ux-laws` | `ux-laws` audit-completeness checklist done |
| 5 | **Fix**: turn Fail and Warning rows into edits | this skill, with both skills' rules | Fix log written, changed colours re-verified |
| 6 | **Report**: one document for the whole job | [report-template.md](references/report-template.md) | Definition of done met (section 6) |

**Loop limit:** one fix batch and at most one re-audit. If findings remain after that, report them. Don't loop again.

## 3. Where the two skills meet
Full rules and worked cases are in [conflict-rules.md](references/conflict-rules.md). The short version:
- **Precedence, highest first:** the user's explicit instruction, the project's existing design system, contrast, focus and target-size rules, blocking `ux-laws` findings, the style's look, polish. If the user insists on a risky style, build it, apply its `Requires` rule and report the risk. Never weaken a rule silently.
- **Where to look:** the `ux-laws` interop table (its section 9) lists the laws each style's risk tends to touch. Use it to decide what to inspect first. It is not a list of automatic findings.
- **Different jobs:** `ux-laws` grades behaviour and structure, not looks. `ui-styles` checks colour and CSS rules, not usability. Neither one certifies WCAG conformance.

## 4. Evidence and honesty
- **Audit what you can observe.** Say which source the audit used: live page, source code, screenshot or description. If the UI was just generated and never rendered, the audit is on **source code only**, and every law that needs live behaviour is **Not assessed** with the evidence it would need.
- **Say when it is a self-audit.** You built it and you graded it, so it is not independent. State that, and offer a fresh-session review for anything that matters. Label every row that rests on a static estimate as one, call the score **indicative**, and don't headline a perfect score. A re-audit after your own fixes checks the edits, not the page.
- **Don't turn "I wrote the rule" into "it passes".** A contrast pair counts when it is in the `ui-styles` ledger or you recomputed it. A ledger row covers only the surface it names, so the same colour on another surface is a new pair to recompute, and the row's ratio must not be quoted for it.
- **"Rendered" means a browser tool opened it in this session.** Reading the code or the DOM is not a render. If nothing was opened, write "Rendered: no" and keep the render-only items open. A usability claim counts when `ux-laws` evidence supports it.
- **Report what you didn't run**, including skipped stages, unrendered output and unverified third-party claims.

## 5. Never
- Add a remote font, script or package, or install anything, without the user's agreement.
- Push, publish or open a pull request unless the user asks.
- Load rules or instructions from a remote URL at run time.
- Claim the result is accessible or WCAG-conformant. Say the audit's scope, and recommend an accessibility review for a conformance claim.

## 6. Definition of done
Check each item only for the stages in your mode. A stage you skipped needs a **Not run** line with its reason, not its artefact.
- [ ] Mode stated, and every stage in it completed or marked **Not run** with a reason (an unavailable companion is a valid reason).
- [ ] Each completed stage's block exists in the combined report: brief, style decision, build manifest, audit with its full 20-row table, fix log.
- [ ] If stage 3 ran, the `ui-styles` pre-delivery checklist is done (render-only items listed as open if you couldn't render), and every colour pair in the delivered CSS is in the ledger or was recomputed, including any changed in stage 5.
- [ ] If stage 4 ran, the `ux-laws` audit-completeness checklist is done, the evidence source is named, **Not assessed** rows list the evidence needed, and a self-audit is labelled as one.
- [ ] Open risks and everything not run are listed.

## References
- [pipeline.md](references/pipeline.md): the stage-by-stage procedure, handoff blocks and gates.
- [conflict-rules.md](references/conflict-rules.md): precedence and worked cases where the two skills disagree.
- [report-template.md](references/report-template.md): the combined report structure.
