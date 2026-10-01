# Conflict rules

What to do when `ui-styles` and `ux-laws` pull in different directions. These rules decide the order. They don't restate either skill's content.

## Contents
- [Precedence](#precedence)
- [Worked cases](#worked-cases)
- [What neither skill can tell you](#what-neither-skill-can-tell-you)

## Precedence
Highest first. A higher item wins, and you say so in the report when a lower one gives way.
1. **The user's explicit instruction.** If they insist on a style or a layout, do it, and report the risk.
2. **The project's existing design system.** Map onto it. Replace it only if asked.
3. **Contrast, focus and target-size rules** (the `ui-styles` contrast contract and guardrails, and the `ux-laws` target-size rules). These aren't traded away for looks.
4. **Blocking `ux-laws` findings.** A finding that blocks a task outranks the style's look.
5. **The style's look.**
6. **Polish.**

## Worked cases
Each case names the situation, the move and why.

| Situation | Move | Why |
| :--- | :--- | :--- |
| The user wants a style whose index row is high risk (for example `neumorphism`) | Build it, apply its `Requires` rule exactly, and inspect the laws its risk touches. Report the risk and what you did about it. | Rule 1 outranks the risk, but the `Requires` rule exists so the style stays usable. |
| An audit finds an icon-only control in a style that requires visible labels | Add a visible text label. Keep the icon. | The style's own requirement and the usability finding agree, so the fix is the same. |
| An audit finds a Warning on target size in a style with small controls | Enlarge the target or its hit area. Keep the visual size if the style needs it. | Rule 3 outranks the look. A larger hit area doesn't change the look. |
| Fixing a finding means changing a colour | Recompute the pair, update the ledger row or record the new ratio, and re-check the neighbouring states (hover, focus, disabled). | A changed colour is a new pair, and the contrast contract says to recompute it. |
| The audit says a style "looks wrong" for the product | Don't count it as a finding. `ux-laws` grades behaviour and structure, not looks. Offer the product-fit alternative as advice. | Mixing taste into a graded audit makes the score meaningless. |
| The style's polish may be hiding a weak flow (the Aesthetic-Usability law) | Grade the flow on its own evidence. Don't let a good look raise a score or excuse a Fail. | The law exists to catch exactly this. |
| The project already has components, and the style's recipes would duplicate them | Map the roles onto the existing selectors, per `ui-styles`. Don't add parallel components. | Rule 2. |
| A third-party component or icon brings its own colours | Treat them as new colour pairs and verify them. Keep one icon family. | The resources rules in `ui-styles` apply to anything you add. |

## What neither skill can tell you
Say these in the report, because both skills are silent on them:
- **Whether the result is WCAG-conformant.** `ux-laws` states that it isn't a conformance audit, and `ui-styles` only verifies colour pairs. Recommend an accessibility review for any conformance claim.
- **Real user behaviour.** Usage-based laws stay **Not assessed** without analytics or testing.
- **Performance.** Neither measures load or response times. Say so if the brief depends on them.
- **Whether the style suits the brand's audience.** The product-fit table is judgement, not data. Treat it as a starting proposal.
