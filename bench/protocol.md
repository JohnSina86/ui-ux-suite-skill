# Benchmark protocol

How a benchmark run is built, served, measured and stored. The judging roles are in [judge.md](judge.md); the briefs are in [briefs/](briefs/); results go in [results/](results/README.md). The run is **AI-judged** and cross-provider: one provider builds, the other judges, and no provider ever judges its own work.

## Contents
- [1. Conditions](#1-conditions)
- [2. Build matrix](#2-build-matrix)
- [3. Build sessions and isolation](#3-build-sessions-and-isolation)
- [4. The build prompt](#4-the-build-prompt)
- [5. Storing outputs](#5-storing-outputs)
- [6. Serving an output](#6-serving-an-output)
- [7. Evidence per output](#7-evidence-per-output)
- [8. Browser isolation and the permissions override](#8-browser-isolation-and-the-permissions-override)
- [9. State resets](#9-state-resets)
- [10. Run folder](#10-run-folder)
- [11. What a run must not do](#11-what-a-run-must-not-do)

## 1. Conditions
Each brief is built under up to three conditions, each in a **fresh session** that has seen nothing else from the run.

| Condition | Skills available to the builder | Used in |
| :-: | :--- | :--- |
| **A** | none | baseline and every later run |
| **B** | the pinned current companion tags: `ui-styles` v1.4.0, `ux-laws` v1.3.0, `ui-ux-suite` v1.3.0, and nothing else | baseline and every later run |
| **C** | the tags under test, named in the run's summary | W6 onwards |

"Nothing else" is literal. A session that lists any other skill is not condition B, and a session that lists any skill at all is not condition A. Section 3 says how this is checked.

## 2. Build matrix
A **round** is one builder building every available brief in every condition available at that point. The other provider judges every pair from that round, so every pair compares two outputs from the same builder and is judged by the provider that did not build them.

| Run | Builder | Conditions | Builds | Judge |
| :--- | :--- | :--- | :-: | :--- |
| baseline, round 1 | Claude Code | A, B | 8 | Codex |
| baseline, round 2 | Codex | A, B | 8 | Claude Code |
| W6, round 1 | Claude Code | C | 4 | Codex, against round 1's stored A and B |
| W6, round 2 | Codex | C | 4 | Claude Code, against round 2's stored A and B |

A **pair** is one brief, one builder, two conditions. The baseline gives eight pairs per comparison (four briefs, two builders); `briefs/dreammadestudio.md` counts only once the user has supplied it, and a summary says when it has not. Builds in one round may run in any order. A build that fails (no `index.html`, or a page that does not load) is recorded as failed and rebuilt once in a new fresh session; if it fails again the pair is incomplete.

## 3. Build sessions and isolation
The condition is a property of the session, not of the prompt. Before any build in a run, the mechanism that produces each condition is verified and the verification is stored.

**Verification, every session, every build.** The first message to the build session is not the brief. It is:
```text
Before you do anything else, and without using any tool: list every skill name available to you in this session, one per line, exactly as your instructions list them. If there are none, write NO SKILLS AVAILABLE. Then list every tool name you have.
```
The reply is stored verbatim as `isolation/<output id>.txt` in the run folder. A build goes ahead only if the reply matches the condition: no skill names for A; exactly the three pinned companions for B; exactly the tags under test for C. Anything else stops that build, and the run records why.

**Mechanisms, Claude Code as builder.** Two candidates, tried in this order; the run records which one was used and its verification output:
- Condition A: the headless CLI with every skill disabled, `claude -p --disable-slash-commands`, run from an empty temporary folder with no project settings. The bundled CLI has no `--safe-mode` flag; `--disable-slash-commands` is the flag that disables skills.
- Condition B and C: a temporary project folder whose `.claude/skills/` holds git checkouts of the three repos at the pinned tags, run with `claude -p --setting-sources project` from that folder so user-level skills are not loaded. The checkouts are made with `git clone --branch <tag> --depth 1` and `git describe --tags` is stored beside the isolation reply.
- Not a mechanism: a subagent or a desktop side session. Both inherit every user-level skill (verified on 2026-10-13: a subagent listed all 44 user and bundled skills), so they cannot give A or B.
- The headless CLI needs its own login. If it reports "Not logged in", no mechanism is available and the run stops before building, as this section requires.

**Mechanisms, Codex as builder.** `codex exec` in an empty temporary folder, with Codex's own skills directory excluded for A and holding only the pinned checkouts for B. The exact flags are recorded in the run when a Codex round is first attempted; the verification message above applies unchanged, and no Codex build runs on an unverified condition.

**Never** build with an unverified condition. A run with no verified mechanism for a condition stops and says so; it does not fall back to "probably isolated".

## 4. The build prompt
After the verification reply, the session receives the brief file verbatim, followed by this block. It is the same in every condition except for the one line marked.
```text
Build this. Put index.html (and styles.css, app.js if you use them) in the current folder and nothing else. Follow every constraint in the brief. Use the content pack as written. When you are done, write a file called BUILD.md with: the files you made, any constraint you could not meet and why, and the number of input and output tokens this session used if you can see them.
[Conditions B and C only:] Use the ui-ux-suite skill in Full mode for this job.
```
No other guidance is given: no style name, no hint about what will be judged, no mention of the benchmark. A session that asks a question gets "Decide it yourself and record the assumption in BUILD.md" once; a second question ends the build as failed.

Token usage per build comes from the CLI's own usage output (`--output-format json` for Claude Code; the `tokens used` line for Codex) and from BUILD.md when the session can see it. Both are stored; the CLI figure is the one the summary budgets with.

## 5. Storing outputs
Outputs live **outside the checkout** so that nothing from a build is ever committed and so that the W1 rubric can be applied to stored baseline outputs after it is frozen.

- Root: `%LOCALAPPDATA%\ui-bench\` on Windows, `~/.ui-bench/` elsewhere.
- Each output goes in `outputs/<id>/`, where `<id>` is eight random hex characters made before the build (`python -c "import secrets;print(secrets.token_hex(4))"`). The build session's working folder **is** that folder, so the output lands there directly and the session never sees any other output.
- `runs/<date>-<label>/map.json` maps each id to its brief, builder, condition and round. The map is never shown to a preference judge. The ids in the pair table of the committed summary are filled in from the map only after every vote for that round is in.
- Outputs are kept until W6 completes. Nothing in `outputs/` is deleted by a run.

## 6. Serving an output
One output at a time, on one fixed port:
```bash
python -m http.server 4181 --directory "<root>/outputs/<id>"
```
This is a static file server that does not proxy, forward, or rewrite. No dev server, no proxy configuration, no other port. (The suite's eval 7 uses 4180; the benchmark uses 4181 so the two never collide.) The server is stopped before the next output is served, and restarted whenever section 9 asks for a reset. An output that cannot be served this way (for example one that needs a build step despite the brief) is recorded as failed under section 2.

## 7. Evidence per output
Collected by the auditing provider in a browser the benchmark controls (section 8), stored under `runs/<date>-<label>/evidence/<id>/`. Every file below is required; a missing one is a coverage gap in the summary, never a guess.

| Evidence | How | Files |
| :--- | :--- | :--- |
| Probe | the `ux-laws` page probe (`references/page-probe.md`), once per viewport at 375×812, 768×1024 and 1440×900, at rest, after entrances or with reduced motion emulated | `probe-375.json`, `probe-768.json`, `probe-1440.json` |
| Overflow sweep | `overflowX` from the same probe at 320, 360, 390 and 430 px wide (height 812), first at rest, then once per overlay with that overlay open: the menu, each modal or detail view, each banner. Each width × state is one cell of the coverage matrix | `sweep.json`: one row per cell with width, state, `overflowX`, and the `wide` list when it is not 0 |
| Screenshots | 375 and 1440 at rest, scrolled to the top; then 375 with each overlay open | `shot-375.png`, `shot-1440.png`, `shot-375-<overlay>.png` |
| Task evidence | each of the brief's three tasks walked through at 375 by the auditor (section 8), with a screenshot of its end state, or a note that it could not be completed and why | `task-1.png` or `task-1.md`, and so on |
| Requests | every request the page made while the evidence above was collected, with its origin and whether it was blocked | `requests.json` |
| Remote references | a search of the delivered files for `http://` and `https://`, listed | `remote-refs.txt` |

Screenshots are the only thing the preference judge sees, so they are taken at the same device scale for every output in a run, with no browser chrome, and are named by id only. Nothing in a screenshot's file name or pixels may say which condition it came from; if a page prints its own condition (for example a theme class in visible text), the run records it as an unblinded pair and the pair is incomplete.

Overlays are found by reading the page: every control that opens a menu, dialog, drawer, detail view or banner. Each is listed in `sweep.json` by the control that opened it. "No overlays" is written only after that list is checked.

## 8. Browser isolation and the permissions override
The independent audit handoff (`references/independent-audit.md`) forbids submitting forms or changing data. A benchmark walk-through of a task such as placing an order needs exactly that, so the benchmark grants a **scoped override** under three conditions, all of which must hold:

1. The output is a disposable local build served by section 6, with mock data from the brief's content pack, and nothing else.
2. **Isolation is enforced in the browser, not inferred from the source.** The browser the auditor uses is configured, before the page is opened, to allow requests and navigations, including redirects, only to `http://localhost:4181` and to block everything else. Blocked requests are recorded in `requests.json`. "Enforced" means the browser refuses the request before it is sent; a log read afterwards is a diagnostic, not enforcement.
3. The output's walk-throughs trigger no blocked request, and its server runs without a proxy.

When all three hold, the auditor may, for this output only, submit forms, add items, and change the page's temporary state to complete the three tasks. The override is named in the stored audit (`Override: benchmark, isolated origin http://localhost:4181`).

The override is **withheld** when:
- the browser tool in use has no way to enforce an origin allowlist. The run records `allowlist: not enforced by <tool>` in `isolation/browser.md`, the auditor stays read-only, every task walk-through is marked **unavailable**, and criterion 3 is inconclusive for every output of that round;
- a walk-through triggers a blocked request, or the page tries to leave the origin: the walk-throughs for that output are marked unavailable and the reason is stored under its id;
- the auditing provider has no browser at all (section 3 of [judge.md](judge.md)): the audit is source-only and says so.

The mechanical reviewer's `remote-refs.txt` explains blocked requests after the fact. It never grants the override.

The ordinary read-only handoff is unchanged for every audit that is not a benchmark output.

## 9. State resets
Between the walk-through of one task and the next, and between outputs:
1. Stop the server.
2. Clear the browser's storage for the origin (local storage, session storage, cookies, IndexedDB) and close the tab.
3. Start the server again on the same port and open the page in a new tab.

A page whose state survives this (for example because the builder wrote to a file) is recorded, and its later tasks are walked through from the surviving state with that noted in the task evidence.

## 10. Run folder
Outside the checkout, `runs/<date>-<label>/`:
```
map.json                  id to brief, builder, condition, round
isolation/<id>.txt        the skill-listing reply from the build session
isolation/<id>.tags.txt   git describe output for the checkouts (B and C)
isolation/browser.md      which browser, whether the allowlist was enforced, how
builds/<id>.json          the CLI usage output for the build
evidence/<id>/            section 7
judges/<pair>/<perspective>-<n>.md   raw preference votes, with the prompt and usage
mechanical/<id>.md        the mechanical reviewer's counts
audits/<id>.md            the independent audit, with its override line
```
Inside the checkout, `bench/results/<date>-<label>/` gets the summary and copies of `judges/`, `mechanical/` and `audits/`, as [results/README.md](results/README.md) says. Evidence, builds and the map stay outside; the summary quotes from them.

## 11. What a run must not do
- Build any condition whose isolation reply does not match (section 3).
- Show a preference judge anything but screenshots and task evidence ([judge.md](judge.md)).
- Reuse an output across builders, or judge a pair with the provider that built it.
- Fill a missing cell, vote or audit row with a guess. Missing is reported as missing.
- Commit anything from `outputs/`, `evidence/` or `builds/`.
- Tag or release the suite. A benchmark run changes no skill.
