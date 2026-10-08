# ui-ux-suite

An agent skill that runs a complete UI/UX job in order: **brief, style choice, build, evidence-based UX audit, fixes and one combined report**.

It is a conductor, not a merged copy. It owns the order of work, the handoffs and the report. The style tokens and CSS rules stay in [`ui-styles`](https://github.com/JohnSina86/ui-styles-skill), and the laws and the audit rubric stay in [`ux-laws`](https://github.com/JohnSina86/ux-laws-skill). Keeping one copy of each means the three can't drift apart.

> **Current release: `v1.2.0`.** To confirm an install, run `git -C <install dir> describe --tags`, which should print `v1.2.0`. The install lines below pin the two companion skills to `v1.3.0`.

## No developer? Start here
You don't need to know any technical words. Install the three skills, then say what you want in your own words, for example: *"I run a bakery and need a page that looks professional so people can order."*

1. The skill asks **at most three** short questions with choices. Say "you choose" to skip them.
2. It builds the page and checks it, and tells you what it could and couldn't check.
3. The report starts with an **"In plain words"** box, tells you which of four levels you've reached, and gives you one next step you can paste back in.

| Level | Name | Meaning |
| :-: | :--- | :--- |
| 1 | Looks right | A style was chosen and built. |
| 2 | Easy to read and use | The build checklist is done. |
| 3 | Checked | A UX audit ran and fixes were re-checked. |
| 4 | Ready for real people | Never awarded by the skill. It lists what a person still needs to do. |

A level is a progress marker, not a certificate. The full technical report always follows the plain box, so a developer can pick the work up from there.

## What you get
- **Four modes**: Advise (style recommendation only), Design (restyle or build), Full (build and check) and Polish (review, fix, re-check once). A review with no fixes asked for goes straight to `ux-laws`.
- **Gates between stages**, so a style isn't chosen before the brief exists, and nothing is reported before its checklist is done.
- **Conflict rules** for when the two skills disagree, with an order of precedence and worked cases.
- **Honest evidence handling**: source-code-only audits say so, self-audits say so, and anything not run is listed.
- **One report** in a fixed structure.

It deliberately does **not** certify WCAG conformance, measure performance or replace either companion skill for a single task. A request that one skill covers goes straight to that skill.

## Install
This skill needs both companions, `ui-styles` and `ux-laws`. Install all three into the same skills folder.

### Quick install (one clone, one script)
Clone this repo into your skills folder as `ui-ux-suite`, then run the script. It installs the other two beside it, and running it again updates them.
```bash
mkdir -p ~/.claude/skills && cd ~/.claude/skills
git clone https://github.com/JohnSina86/ui-ux-suite-skill.git ui-ux-suite
./ui-ux-suite/install.sh                # newest versions (main)
./ui-ux-suite/install.sh --ref v1.3.0   # or pin both companions to one tag that exists in each
```
```powershell
New-Item -ItemType Directory -Force "$HOME\.claude\skills" | Out-Null; Set-Location "$HOME\.claude\skills"
git clone https://github.com/JohnSina86/ui-ux-suite-skill.git ui-ux-suite
.\ui-ux-suite\install.ps1               # newest versions (main)
.\ui-ux-suite\install.ps1 -Ref v1.3.0   # or pin both companions to one tag that exists in each
```
The scripts are for you, not for the agent: the skill never runs them. They only run `git clone` and `git fetch` against the two companion repos and never delete anything. If a folder named `ui-styles` or `ux-laws` already exists and isn't a git checkout, the script stops and tells you. Read them first if you like: `install.sh` and `install.ps1` are each under 70 lines. For a project instead of your user folder, run the same commands inside `.claude/skills` at the project root. The suite folder keeps its current tag, so `git -C ui-ux-suite checkout <tag>` pins it too.

### Manual install
The same thing without the scripts:

### Claude Code (user level)
```bash
mkdir -p ~/.claude/skills && cd ~/.claude/skills
git clone --branch v1.3.0 https://github.com/JohnSina86/ui-styles-skill.git ui-styles
git clone --branch v1.3.0 https://github.com/JohnSina86/ux-laws-skill.git ux-laws
git clone --branch v1.2.0 https://github.com/JohnSina86/ui-ux-suite-skill.git ui-ux-suite
```
```powershell
New-Item -ItemType Directory -Force "$HOME\.claude\skills" | Out-Null; Set-Location "$HOME\.claude\skills"
git clone --branch v1.3.0 https://github.com/JohnSina86/ui-styles-skill.git ui-styles
git clone --branch v1.3.0 https://github.com/JohnSina86/ux-laws-skill.git ux-laws
git clone --branch v1.2.0 https://github.com/JohnSina86/ui-ux-suite-skill.git ui-ux-suite
```
For a project, run the same commands inside `.claude/skills` at the project root. The folder names must stay `ui-styles`, `ux-laws` and `ui-ux-suite`, because they match each skill's `name`.

If you already have the two companions, install only the third line.

## Layout
```
install.sh, install.ps1       one-step install of the two companion skills (for people; the agent never runs them)
SKILL.md                      the conductor: modes, pipeline, rules, definition of done
references/pipeline.md        stage procedure, handoff blocks and gates
references/conflict-rules.md  precedence and worked cases
references/report-template.md the combined report, with coverage, spec fidelity and owner decisions
references/independent-audit.md the fresh-context audit handoff and prompt
references/guided-start.md    plain-language intake, the four levels, next-step prompts
references/plain-language.md  the plain-words block and everyday wording
evals/                        8 functional evals and 24 trigger queries (data only)
RELEASING.md                  the release checklist
```

## Changelog
- **v1.2.0**: lessons from two live audits of a static marketing site.
  - **Site sweep** scope (coverage plan, templates with their own surface type, a coverage matrix, one audit per template, no site-wide score). **Measure, then grade** with the `ux-laws` page probe.
  - **Independent audit**: `references/independent-audit.md` hands a fresh context the verbatim Brief and specs, never the builder's findings, with the `ux-laws` output contract. A code review never counts.
  - **Re-audits report row changes** per occurrence; the only headline score is the pre-fix one. The report gains coverage, spec fidelity, owner decisions and a stated location. Measured DOM numbers count as render evidence. Evals 7 and 8, and four trigger queries.
  - **Needs** `ux-laws` ≥ 1.3.0 and `ui-styles` ≥ 1.3.0; the install lines pin both to `v1.3.0`.
- **v1.1.1**: `install.sh` and `install.ps1` install the two companion skills beside the suite in one step, and update them on a re-run. Tested on bash and Windows PowerShell 5.1: fresh install, re-run, pinned tag, a blocking folder and a bad ref.
- **v1.1.0**: plain-language mode for non-developers: a three-question guided start, a four-level progress ladder that never awards the top level, an "In plain words" report block with everyday wording, and ready-to-paste next-step prompts. The full technical report is unchanged and still follows. The trigger set has not been re-run with plain-language phrasings.
- **v1.0.2**: a ratio you compute must show its luminances, "dependencies: none" is written only after searching the delivered files for http(s)://, and the install lines will pin the new `ui-styles` once it is released. Found by a third blind comparison.
- **v1.0.1**: a constraint such as "keep it usable" no longer selects an audit, a ledger ratio applies only to its own surface, and "rendered" is claimed only after a browser tool opened the result. Found by a blind comparison against another design skill.
- **v1.0.0**: first version.

## Licence
MIT. See [LICENSE](LICENSE).
