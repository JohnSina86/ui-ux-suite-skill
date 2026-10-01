# ui-ux-suite

An agent skill that runs a complete UI/UX job in order: **brief, style choice, build, evidence-based UX audit, fixes and one combined report**.

It is a conductor, not a merged copy. It owns the order of work, the handoffs and the report. The style tokens and CSS rules stay in [`ui-styles`](https://github.com/JohnSina86/ui-styles-skill), and the laws and the audit rubric stay in [`ux-laws`](https://github.com/JohnSina86/ux-laws-skill). Keeping one copy of each means the three can't drift apart.

> **Current release: `v1.0.1`.** To confirm an install, run `git -C <install dir> describe --tags`, which should print `v1.0.1`. The install lines below pin the two companion skills to `v1.2.1`.

## What you get
- **Four modes**: Advise (style recommendation only), Design (restyle or build), Full (build and check) and Polish (review, fix, re-check once). A review with no fixes asked for goes straight to `ux-laws`.
- **Gates between stages**, so a style isn't chosen before the brief exists, and nothing is reported before its checklist is done.
- **Conflict rules** for when the two skills disagree, with an order of precedence and worked cases.
- **Honest evidence handling**: source-code-only audits say so, self-audits say so, and anything not run is listed.
- **One report** in a fixed structure.

It deliberately does **not** certify WCAG conformance, measure performance or replace either companion skill for a single task. A request that one skill covers goes straight to that skill.

## Install
This skill needs both companions. Install all three into the same skills folder.

### Claude Code (user level)
```bash
mkdir -p ~/.claude/skills && cd ~/.claude/skills
git clone --branch v1.2.1 https://github.com/JohnSina86/ui-styles-skill.git ui-styles
git clone --branch v1.2.1 https://github.com/JohnSina86/ux-laws-skill.git ux-laws
git clone --branch v1.0.1 https://github.com/JohnSina86/ui-ux-suite-skill.git ui-ux-suite
```
```powershell
New-Item -ItemType Directory -Force "$HOME\.claude\skills" | Out-Null; Set-Location "$HOME\.claude\skills"
git clone --branch v1.2.1 https://github.com/JohnSina86/ui-styles-skill.git ui-styles
git clone --branch v1.2.1 https://github.com/JohnSina86/ux-laws-skill.git ux-laws
git clone --branch v1.0.1 https://github.com/JohnSina86/ui-ux-suite-skill.git ui-ux-suite
```
For a project, run the same commands inside `.claude/skills` at the project root. The folder names must stay `ui-styles`, `ux-laws` and `ui-ux-suite`, because they match each skill's `name`.

If you already have the two companions, install only the third line.

## Layout
```
SKILL.md                      the conductor: modes, pipeline, rules, definition of done
references/pipeline.md        stage procedure, handoff blocks and gates
references/conflict-rules.md  precedence and worked cases
references/report-template.md the combined report
evals/                        4 functional evals and 20 trigger queries (data only)
RELEASING.md                  the release checklist
```

## Changelog
- **v1.0.2 (unreleased)**: a ratio you compute must show its luminances, "dependencies: none" is written only after searching the delivered files for http(s)://, and the install lines will pin the new `ui-styles` once it is released. Found by a third blind comparison.
- **v1.0.1**: a constraint such as "keep it usable" no longer selects an audit, a ledger ratio applies only to its own surface, and "rendered" is claimed only after a browser tool opened the result. Found by a blind comparison against another design skill.
- **v1.0.0**: first version.

## Licence
MIT. See [LICENSE](LICENSE).
