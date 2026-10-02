# Guided start (for people who aren't developers)

Use this when the user says they aren't a developer, gives no code or stack, asks in everyday words ("make my shop page look professional"), or says "you choose". It changes how you ask and how you report. It never skips a stage, relaxes a gate or shortens the audit.

## Contents
- [Asking: at most three questions](#asking-at-most-three-questions)
- [Where you are: the four levels](#where-you-are-the-four-levels)
- [Next-step prompts](#next-step-prompts)

## Asking: at most three questions
Ask them in **one message**, as choices, each with a default. Never ask about frameworks, hosting, CSS or file formats. If the user answers "you choose", go on and write your assumptions in the Brief.

1. **What are you making?** (a) a web page that presents something, (b) a form or sign-up, (c) a screen with tables or numbers, (d) not sure. Map the answer to the Brief's surface type: (a) Marketing & Landing, (b) Form & Wizard, (c) SaaS & Dashboard, (d) assume Marketing & Landing and say so.
2. **Who will use it, and what must they be able to do?** One sentence is enough. Turn it into the three tasks in the Brief.
3. **How should it feel?** Pick up to three words, for example calm, bold, playful, serious, friendly, technical, luxurious, retro. Pass the words to `ui-styles` sections 1 and 2, which choose the style. Don't map feelings to styles here.

**Mode.** "Make it good" or "make it look professional" is a build request, so run **Design** and offer the audit as the next step. Run Full or Polish only when the user asks you to review, check, test or fix something. The levels below are how the user climbs, one prompt at a time.

Also check, without asking a question, whether the user pasted code or a file path. If they did, the existing design system rule applies. If not, say the result will be files they can open by double-clicking `index.html`.

## Where you are: the four levels
State the level the work **reached in this run** and the next one. A level is a plain-language progress marker. It is not a score or a certification.

| Level | Name | Reached when |
| :-: | :--- | :--- |
| 1 | **Looks right** | A style was chosen with reasons and built from its tokens. |
| 2 | **Easy to read and use** | The `ui-styles` pre-delivery checklist is done, and what needs a render is listed as open. |
| 3 | **Checked** | A `ux-laws` audit ran, its evidence source is named, and any fixes were made and re-checked once. An audit of your own work from source code still counts, and the plain block says it was a self-check. |
| 4 | **Ready for real people** | **Never awarded by this skill.** List what is still missing: a render in a real browser, a person reviewing it, an accessibility review, and a try-out with real users. |

If a stage was skipped or a companion skill was missing, the level stops below it.

## Next-step prompts
End the report with the next rung and at most three prompts the user can paste as they are. Pick from these, adjusted to the project:
- To go from 1 to 2: "Check this page for readability and keyboard use and fix anything you find, but keep the look."
- To go from 2 to 3: "Now review the user experience of this page and fix what you find, once."
- To go toward 4: "Open the page in a browser, tell me what looks wrong, and list what a person should still check."
- Always available: "Explain that last report to me again in simpler words."
