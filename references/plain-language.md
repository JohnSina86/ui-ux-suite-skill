# Plain-language reporting

When guided start is on, the report begins with a short block for a non-developer. **The full technical report still follows, unchanged.** The plain block adds to it and never replaces the audit table, the fix log or the open risks.

## Contents
- [The "In plain words" block](#the-in-plain-words-block)
- [Everyday wording](#everyday-wording)
- [Rules](#rules)

## The "In plain words" block
At most 120 words, no law names and no ratios. Include, in order:
1. **What you now have**: which files, and how to open the main one (double-click `index.html`).
2. **What is in good shape**: one or two things you actually checked.
3. **What I couldn't check**: say it plainly, for example "I couldn't look at it in a browser, so how it looks on a phone is unconfirmed."
4. **Where you are**: the level from [guided-start.md](guided-start.md), and the next one.
5. **Your next step**: up to three prompts the user can paste.

## Everyday wording
Use the right-hand wording in the plain block. Keep the technical term in the full report.

| Technical term | Say |
| :--- | :--- |
| contrast ratio | how easy the text is to read against its background |
| focus ring, focus-visible | the outline that shows where the keyboard is |
| target size | how big the buttons are to tap or click |
| forced colours | a setting some people use to make pages easier to see |
| reduced motion | a setting for people who get dizzy from animation |
| scoped CSS | styling that stays inside the part I added, so it won't change the rest of your site |
| remote font or CDN | a font or tool loaded from another company's server |
| self-audit | I checked my own work, so it isn't an independent review |
| not assessed | I couldn't judge this from what I could see |
| render | opening the page in a browser to see how it really looks |
| design tokens | one shared list of colours and sizes |
| WCAG | the web's accessibility guidelines |

## Rules
- **Short sentences, one idea each.** Explain a word once, the first time it appears. Don't talk down.
- **Be honest about limits.** Say what you checked and what you could not. Never say the result is "accessible", "compliant", "safe" or "production-ready".
- **Give one next step first.** Don't hand over a list of ten fixes. The full list stays in the technical report.
- **If the user asks "what does that mean?"**, answer in one or two plain sentences using the table above, then offer the next step.
- **Don't change the work to make the story simpler.** Stages, gates and the audit table stay as they are.
