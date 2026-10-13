# ui-ux-suite

An agent skill that runs a complete UI/UX job in order: **brief, style choice, build, evidence-based UX audit, fixes and one combined report**.

It is a conductor, not a merged copy. It owns the order of work, the handoffs and the report. The style tokens and CSS rules stay in [`ui-styles`](https://github.com/JohnSina86/ui-styles-skill), the laws and the audit rubric stay in [`ux-laws`](https://github.com/JohnSina86/ux-laws-skill), and the rules for the words on the screen stay in [`ui-copy`](https://github.com/JohnSina86/ui-copy-skill). Keeping one copy of each means they can't drift apart.

> **Current release: `v1.4.0`.** To confirm an install, run `git -C <install dir> describe --tags`, which should print `v1.4.0`. The install lines below pin the three companion skills: `ui-styles` `v1.8.0`, `ux-laws` `v1.3.0` and `ui-copy` `v1.0.0`.

## No developer? Start here
You don't need to know any technical words. Install the four skills, then say what you want in your own words, for example: *"I run a bakery and need a page that looks professional so people can order."*

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
- **Generic-looking output caught early**: the build runs the `ui-styles` anti-slop gate and a `ui-copy` pass on every string, and records the results, including coverage and anything it could not assess.
- **Honest evidence handling**: source-code-only audits say so, self-audits say so, and anything not run is listed.
- **One report** in a fixed structure.

It deliberately does **not** certify WCAG conformance, measure performance or replace either companion skill for a single task. A request that one skill covers goes straight to that skill.

## Install
This skill needs three companions, `ui-styles`, `ux-laws` and `ui-copy`. Install all four into the same skills folder.

### Quick install (one clone, one script)
Clone this repo into your skills folder as `ui-ux-suite`, then run the script. It installs the other three beside it, and running it again updates them.
```bash
mkdir -p ~/.claude/skills && cd ~/.claude/skills
git clone https://github.com/JohnSina86/ui-ux-suite-skill.git ui-ux-suite
./ui-ux-suite/install.sh                # newest versions (main)
./ui-ux-suite/install.sh --ref main     # the companions have different tags; pin them with the manual lines
```
```powershell
New-Item -ItemType Directory -Force "$HOME\.claude\skills" | Out-Null; Set-Location "$HOME\.claude\skills"
git clone https://github.com/JohnSina86/ui-ux-suite-skill.git ui-ux-suite
.\ui-ux-suite\install.ps1               # newest versions (main)
.\ui-ux-suite\install.ps1 -Ref main     # the companions have different tags; pin them with the manual lines
```
The scripts are for you, not for the agent: the skill never runs them. They only run `git clone` and `git fetch` against the three companion repos and never delete anything. If a folder named `ui-styles`, `ux-laws` or `ui-copy` already exists and isn't a git checkout, the script stops and tells you. Read them first if you like: `install.sh` and `install.ps1` are each under 75 lines. For a project instead of your user folder, run the same commands inside `.claude/skills` at the project root. The suite folder keeps its current tag, so `git -C ui-ux-suite checkout <tag>` pins it too.

### Manual install
The same thing without the scripts:

### Claude Code (user level)
```bash
mkdir -p ~/.claude/skills && cd ~/.claude/skills
git clone --branch v1.8.0 https://github.com/JohnSina86/ui-styles-skill.git ui-styles
git clone --branch v1.3.0 https://github.com/JohnSina86/ux-laws-skill.git ux-laws
git clone --branch v1.0.0 https://github.com/JohnSina86/ui-copy-skill.git ui-copy
git clone --branch v1.4.0 https://github.com/JohnSina86/ui-ux-suite-skill.git ui-ux-suite
```
```powershell
New-Item -ItemType Directory -Force "$HOME\.claude\skills" | Out-Null; Set-Location "$HOME\.claude\skills"
git clone --branch v1.8.0 https://github.com/JohnSina86/ui-styles-skill.git ui-styles
git clone --branch v1.3.0 https://github.com/JohnSina86/ux-laws-skill.git ux-laws
git clone --branch v1.0.0 https://github.com/JohnSina86/ui-copy-skill.git ui-copy
git clone --branch v1.4.0 https://github.com/JohnSina86/ui-ux-suite-skill.git ui-ux-suite
```
For a project, run the same commands inside `.claude/skills` at the project root. The folder names must stay `ui-styles`, `ux-laws`, `ui-copy` and `ui-ux-suite`, because they match each skill's `name`.

If you already have the three companions, install only the last line.

## Layout
```
install.sh, install.ps1       one-step install of the three companion skills (for people; the agent never runs them)
SKILL.md                      the conductor: modes, pipeline, rules, definition of done
references/pipeline.md        stage procedure, handoff blocks and gates (content pack, anti-slop gate, copy passes)
references/conflict-rules.md  precedence and worked cases
references/report-template.md the combined report, with coverage, spec fidelity and owner decisions
references/independent-audit.md the fresh-context audit handoff and prompt
references/guided-start.md    plain-language intake, the four levels, next-step prompts
references/plain-language.md  the plain-words block and everyday wording
evals/                        10 functional evals and 26 trigger queries (data only)
bench/                        the cross-provider blind benchmark: briefs, protocol, judge roles, committed results (start at bench/protocol.md)
RELEASING.md                  the release checklist
```

## Changelog
- **v1.4.0**: the benchmark and the companion wiring.
  - **Wiring.** Section 0 checks three companions, and the missing-companion rule covers the new `ui-copy`. The Brief gains a content-pack line and a voice-brief line. The Style decision gains an Imagery line and the type scale. Stage 3 follows the `ui-styles` workflow past the build: the anti-slop gate (result with coverage, the five answers, retained choices and unresolved claims; inconclusive never counts as passing), type and imagery, a `choreography:` line or "none", and a `ui-copy` pass on every string, all recorded in the build manifest. Stage 4 lists remaining tells under unscored findings, never as law rows. Stage 5's gate re-runs `ui-copy` on every string the fixes created or changed, in Polish mode too, and supplied copy is preserved and routed through spec fidelity and owner decisions.
  - The report template gains the anti-slop result and a copy section. Two conflict cases: a retained existing-system choice the rubric would count, and supplied copy that fails the specificity test. The description now also covers a UI that looks generic or AI-made.
  - The benchmark's mechanical reviewer now also records each page's gate result and assessed coverage.
  - `install.sh` and `install.ps1` install `ui-copy` too. Pins: `ui-styles` v1.8.0, `ux-laws` v1.3.0, `ui-copy` v1.0.0. Eval 10 (a Design-mode landing page) and two trigger queries added; the trigger set is now 14 tuning and 12 held-out queries.
  - **Needs** `ui-styles` 1.8.0 or later (anti-slop rubric v1.5), `ui-copy` 1.0.0 or later and `ux-laws` 1.3.0 or later.
  - **The benchmark** (`bench/`):
    - Four briefs with fixed content packs (`briefs/`; `dreammadestudio.md` is a stub until the user supplies the page), the build and evidence protocol (`protocol.md`: conditions A, B and C, the cross-provider build matrix, outputs stored outside the checkout, a static non-proxying server, the browser-enforced origin allowlist and the scoped permissions override), the three judge roles (`judge.md`: blinded preference judges in four perspectives with the echo rule, the unblinded mechanical reviewer producing counts only, and the independent audit pass through `references/independent-audit.md`), and the results layout with a summary template (`results/`).
    - Results are AI-judged and cross-provider. The first run is a one-brief smoke test; it satisfies no criterion. The benchmark changes no skill rule.
- **v1.3.0**: composition moves.
  - Stage 2 picks `ui-styles` composition moves (depth planes, signal colour, scale contrast) when the UI feels flat, looks default, or users can't tell what to tap. Signal colour is the default in a new build. Stage 3 builds them, the build manifest records them, and stage 4 lists the laws they touch as places to look, never as findings.
  - Three conflict cases: a decorative accent under signal colour, a plane overlapping a control, and scale contrast against the reading floors.
  - Borrowed from Textura's public-domain [`next16-claude-starter`](https://github.com/textura-agency/next16-claude-starter), rewritten framework-free: stage 3 builds loading, empty and error states for data-driven components and lists them in the manifest. Stage 4 measures at rest (after entrances, or with reduced motion emulated), opens overlays at phone width, and repeats in the dark scheme when the project follows it.
  - **Needs** `ui-styles` ≥ 1.4.0 (it adds `references/composition.md`) and `ux-laws` ≥ 1.3.0. The two now have different tags, so pin them with the manual lines; a single `--ref` tag no longer exists in both.
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
