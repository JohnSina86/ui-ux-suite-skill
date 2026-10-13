---
name: ui-ux-suite
description: >-
  Runs a complete UI/UX job: brief, style, build, UX audit, fixes and one report, using ui-styles, ux-laws and ui-copy. Use when a design must be built and checked, a UX review needs fixes, or a UI looks generic or AI-made, for a screen or site on desktop and mobile. Plain-language mode for non-developers. Not for a single task one of those skills covers alone, WCAG audits or performance profiling.
license: MIT
metadata:
  version: "1.4.0"
---

# UI/UX Suite

This skill is the **conductor**. It owns the order of work, the handoffs between stages and the single report. It owns **no** tokens, recipes, laws or copy rules: those live in `ui-styles`, `ux-laws` and `ui-copy`, and you read them there. Never copy their content into your answer from memory, because the copies would drift.

## 0. Before you start (mandatory)
1. **Check the three companion skills are available** in this session: `ui-styles`, `ux-laws` and `ui-copy`, and recent enough: each `SKILL.md` `metadata.version` is at least `ui-styles` 1.8.0, `ux-laws` 1.3.0 and `ui-copy` 1.0.0. An older companion counts as missing for the stages that need it. If one is missing, say which and give its install line from [README.md](README.md); if one is too old, say which and give its upgrade line from the same file. Continue only with the stages that don't need it. Mark each skipped stage or pass **Not run: `<skill>` unavailable** (a missing `ui-copy` skips the copy passes in stages 3 and 5, and the report says the strings were not checked), and never recreate the missing skill's content from memory.
2. **Existing design system first.** The `ui-styles` rule applies to the whole job: map a style onto the project's own tokens as an accent layer, and replace the system only if the user asks.
3. **Honour stated constraints** (platform, framework, content-security policy, "desktop only", no new dependencies). Ask at most three questions, and only when the answer changes the work. Otherwise state your assumption and go on.
4. **Plain-language mode.** If the user says they aren't a developer, gives no code or stack, asks in everyday words, or says "you choose", use [guided-start.md](references/guided-start.md) for the intake and [plain-language.md](references/plain-language.md) for the report. It changes how you ask and report. It never skips a stage, relaxes a gate or shortens the audit.
5. **Pick the mode** in section 1, and say which one you chose.

## 1. Modes
| The user wants | Mode | Stages |
| :--- | :--- | :--- |
| A style recommendation only | **Advise** | 1, 2, then stop |
| A new UI or a restyle, with no checking asked | **Design** | 1, 2, 3, 6 |
| A UI built and checked | **Full** | 1 to 6 |
| An existing UI reviewed and then fixed, or fixed and restyled | **Polish** | 1 (short), 4, then 2 and 3 only if a restyle was asked, 5, one re-audit, 6 |

**Constraints are not audit requests.** "Keep it usable", "make it accessible" and "keep the look" shape the build or the fix. Choose Full or Polish only when the user asks you to review, check, audit or test, or to fix a problem. "Make this look Y2K but keep it usable" is Design.

**Site sweep** is a scope, not a mode. **Choose the mode first** with the table above. Only if that mode is Polish or Full, and the request covers a site, several pages, or "desktop and mobile" (for example "iron out the kinks on PC and mobile"), add the site-sweep scope: a coverage plan, every planned page and viewport measured, and a report per template ([pipeline.md](references/pipeline.md) stage 1). Naming a site or "desktop and mobile" never turns a build (Design) or an advice request into an audit.

If the request is a single task, route it directly. "Make this Neo-Brutalist" is `ui-styles` alone, "audit the UX of this page" is `ux-laws` alone, and "rewrite my microcopy" is `ui-copy` alone. A review with no fixes asked for is `ux-laws` alone, so there is no Audit mode here. Don't run the pipeline around a request that one skill covers.

## 2. Pipeline
Details, handoff blocks and gates are in [pipeline.md](references/pipeline.md). Each stage ends with a gate. Don't start the next stage until its gate passes.

| # | Stage | Skill that does the work | Gate |
| :-: | :--- | :--- | :--- |
| 1 | **Brief**: product, audience, surface type, constraints, the 3 tasks users must complete | this skill | Brief block written |
| 2 | **Style**: choose with reasons, risk, the style's `Requires` rule and an imagery direction, or flag "no verified match" | `ui-styles` sections 0 to 2 | Style decision block written |
| 3 | **Build**: tokens, components, guardrails, anti-slop gate, type, imagery, reveal choreography, copy | `ui-styles` sections 3 to 7, and `ui-copy` on every string | `ui-styles` pre-delivery checklist done, gate result and copy pass recorded |
| 4 | **Audit**: grade the result against observable evidence | `ux-laws` | `ux-laws` audit-completeness checklist done |
| 5 | **Fix**: turn Fail and Warning rows into edits | this skill, with all three skills' rules | Fix log written, changed colours re-verified, changed strings re-checked with `ui-copy` |
| 6 | **Report**: one document for the whole job | [report-template.md](references/report-template.md) | Definition of done met (section 6) |

**Loop limit:** one fix batch and at most one re-audit. If findings remain after that, report them. Don't loop again.

## 3. Where the skills meet
Full rules and worked cases are in [conflict-rules.md](references/conflict-rules.md). The short version:
- **Precedence, highest first:** the user's explicit instruction, the project's existing design system, contrast, focus and target-size rules, blocking `ux-laws` findings, the style's look, polish. If the user insists on a risky style, build it, apply its `Requires` rule and report the risk. Never weaken a rule silently.
- **Composition moves** (depth planes, signal colour, scale contrast) live in `ui-styles` `references/composition.md`. Stage 2 picks them and stage 3 builds them. A clash with the style or a contract follows the precedence above.
- **Anti-slop** (`ui-styles` `references/anti-slop.md`): stage 3 runs the gate and records its result (pass, fail or inconclusive, with coverage), the five "Could this be any site?" answers, any retained choices and any unresolved claims. Inconclusive never counts as passing. Tells are craft findings, never `ux-laws` law rows, and the precedence below is unchanged.
- **Type and imagery** (`ui-styles` `references/typography.md` and `references/imagery.md`): stage 2 names the imagery kind and stage 3 records the type scale.
- **Choreography** (`ui-styles` `references/choreography.md`): if the page has a first-screen reveal, stage 3 follows it and records a `choreography:` line, or "none".
- **Copy** (`ui-copy`): stage 3 runs it on every string and stage 5 runs it again on every string a fix created or changed, in Polish mode too. Copy the user supplied is preserved, and a proposed change to it goes through spec fidelity and owner decisions, never applied silently.
- **Where to look:** the `ux-laws` interop table (its section 9) lists the laws each style's risk tends to touch. Use it to decide what to inspect first. It is not a list of automatic findings.
- **Different jobs:** `ux-laws` grades behaviour and structure, not looks. `ui-styles` checks colour and CSS rules, not usability. `ui-copy` checks the words, not the layout. None of them certifies WCAG conformance.

## 4. Evidence and honesty
- **Audit what you can observe.** Say which source the audit used: live page, source code, screenshot or description. If the UI was just generated and never rendered, the audit is on **source code only**, and every law that needs live behaviour is **Not assessed** with the evidence it would need.
- **Measure, then grade.** On a live page, run the `ux-laws` page probe on each covered page and viewport, and apply its false-positive rules before grading anything.
- **Say when it is a self-audit.** You built it and you graded it, so it is not independent. If a fresh context is available, use [independent-audit.md](references/independent-audit.md) for the audit or at least the re-audit. Otherwise state that it is a self-audit and offer a fresh-session review for anything that matters. A code review is never a UX audit. Label every row that rests on a static estimate as one, call the score **indicative**, and don't headline a perfect score. A re-audit after your own fixes checks the edits, not the page.
- **Don't turn "I wrote the rule" into "it passes".** A contrast pair counts when it is in the `ui-styles` ledger or you recomputed it. A ledger row covers only the surface it names, so the same colour on another surface is a new pair to recompute, and the row's ratio must not be quoted for it. When you compute a ratio, write both relative luminances beside it. A ratio with no luminances shown is a claim, not a recomputation.
- **Check before you say "none".** Before writing "no remote fonts" or "dependencies added: none", search every file you deliver, demo pages included, for `http://` and `https://` and list what you find.
- **Re-audits report row changes.** Show before → after with new evidence at every occurrence; the only headline score is the pre-fix one.
- **"Rendered" means a browser tool opened it in this session.** Reading the code is not a render; a number measured in a page the browser tool opened is. If a screenshot times out mid-transition, wait and retry once, then rely on measurements and say so. If nothing was opened, write "Rendered: no" and keep the render-only items open. A usability claim counts when `ux-laws` evidence supports it.
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
- [ ] If stage 3 ran, the anti-slop gate result with its coverage, the five answers, any retained choices and unresolved claims, the type scale, the imagery kind, the `choreography:` line (or "none") and the `ui-copy` pass are in the build manifest, and no inconclusive gate is reported as passing.
- [ ] If stage 4 ran, the `ux-laws` audit-completeness checklist is done (per template in a site sweep), the evidence source is named, **Not assessed** rows list the evidence needed, and a self-audit is labelled as one.
- [ ] In a site sweep, the coverage matrix accounts for every planned page and viewport, with gaps listed and no site-wide score.
- [ ] If stage 5 ran, every string a fix created or changed went through `ui-copy`, and supplied copy was preserved.
- [ ] Spec deviations and owner decisions are in their own report sections, and no owner decision was acted on without the user.
- [ ] Open risks and everything not run are listed, and the report location is stated.
- [ ] In plain-language mode: the "In plain words" block, the level reached and one next step are at the top, and the full technical report still follows.

## References
- [pipeline.md](references/pipeline.md): the stage-by-stage procedure, handoff blocks and gates, including the content pack, the anti-slop gate and the copy passes.
- [conflict-rules.md](references/conflict-rules.md): precedence and worked cases where the skills disagree.
- [report-template.md](references/report-template.md): the combined report structure, including coverage, spec fidelity and owner decisions.
- [independent-audit.md](references/independent-audit.md): the fresh-context audit handoff and prompt, and what does not count as one.
- [guided-start.md](references/guided-start.md): the three-question intake, the four levels and the next-step prompts for non-developers.
- [plain-language.md](references/plain-language.md): the plain-words block and everyday wording.
