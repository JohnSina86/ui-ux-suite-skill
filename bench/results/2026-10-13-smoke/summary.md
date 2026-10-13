# Run summary: 2026-10-13 smoke

AI-judged. Builder: Claude Code (planned, not run: see section 2). Judge: Codex CLI 0.154.0, model `gpt-6-astra`. Rubric version: none. Run folder (outside the checkout): `C:\Users\sina8\AppData\Local\ui-bench\runs\2026-10-13-smoke`.

This is a smoke test of the protocol on one brief. It satisfies no criterion. It proved the judge plumbing and the screenshot method, and it found that neither build condition could be isolated and that the browser pane does not enforce the origin allowlist. No page was built.

## Contents
- [1. Scope](#1-scope)
- [2. Isolation](#2-isolation)
- [3. Pair table](#3-pair-table)
- [4. Decided-pair rates](#4-decided-pair-rates)
- [5. Mechanical counts](#5-mechanical-counts)
- [6. Independent audits](#6-independent-audits)
- [7. Coverage matrix](#7-coverage-matrix)
- [8. Cost](#8-cost)
- [9. Not run](#9-not-run)
- [10. Reading the criteria](#10-reading-the-criteria)

## 1. Scope
- Briefs: saas-landing only. dreammadestudio: not supplied.
- Conditions: A, B planned. B tags: ui-styles v1.4.0, ux-laws v1.3.0, ui-ux-suite v1.3.0. C: none.
- Rounds: round 1 only (Claude Code builds, Codex judges). Not built.
- Kind of run: smoke test (proves the protocol only; satisfies no criterion).

## 2. Isolation
| Condition | Mechanism | Verified by | Result |
| :-: | :--- | :--- | :--- |
| A | headless CLI `claude -p --disable-slash-commands` (the bundled binary at `%APPDATA%\Claude\claude-code\2.1.295\...\claude.exe`; it has no `--safe-mode` flag, `--disable-slash-commands` is the "disable all skills" flag) | `isolation/claude-cli.md` | not run: the CLI reports `loggedIn: false`, and `--bare` with an API key also failed (no key set). Login is the user's action. |
| B | temporary project with `.claude/skills/` checkouts at the pinned tags, `claude -p --setting-sources project` | same | not run: same login block. Whether `--setting-sources project` excludes user-level skills is unverified. |
| subagent or desktop side session (rejected) | `Agent` tool, general-purpose, no tools used | `isolation/subagent-probe.md` | does not match: the subagent listed all 44 user and bundled skills, including ui-styles, ux-laws and ui-ux-suite. Not a mechanism for A or B. |

Browser: Claude Code built-in browser pane. Origin allowlist: **not enforced**. A test page served from `http://localhost:4181` (the only origin the user had allowed) loaded a stylesheet and an image from example.com, a script from example.org and a fetch from example.net; the fetch failed on a CORS error, which means the response arrived. The pane's request log listed only the document request, so it is not a diagnostic either; `performance.getEntriesByType('resource')` inside the page listed all four. Override: **withheld** for every output of any round that uses this browser. Details in `isolation/browser.md`.

## 3. Pair table
No pair. No build ran, so no vote was cast.

| Brief | Builder | Pair | Art director | First-time visitor | Copy editor | Usability reviewer | Result |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| saas-landing | Claude Code | B vs A | not run | not run | not run | not run | incomplete: not built |

Plumbing check instead of a vote: one headless screenshot of the allowlist test page at 375×812 was sent to Codex with `codex exec -i` and the echo rule. It named "the heading 'Allowlist test page' is dark red near the top", which is in the image (the heading is `#9b2c2c`). Stored as `judges/plumbing/echo-test.md`. This proves image input and the echo rule can be applied; it is not a preference vote.

## 4. Decided-pair rates
| Comparison | Pairs | Complete | Ties | Incomplete (of which configuration mismatch) | Decided | Won by B | Rate | Status |
| :--- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :--- |
| B vs A (baseline) | 1 | 0 | 0 | 1 (0) | 0 | 0 | n/a | inconclusive: zero decided pairs |

## 5. Mechanical counts
Rubric version: none. Counting unit: n/a. No output to count.

| Output id | Brief | Cond. | High tells | Medium tells | Contrast pairs (total = ledger-only + recomputed + unverified; below threshold) | Overflow cells (expected / measured / zero / overflow) | Blocked requests | Remote refs |
| :--- | :--- | :-: | :-: | :-: | :--- | :--- | :-: | :-: |
| none | saas-landing | A, B | not counted | not counted | missing: not built | missing: not built | missing | missing |

Criterion 2: not applicable, no rubric and no output.

## 6. Independent audits
None. Had an output existed, the Codex audit would have been source-only: `codex exec` lists a `cua_repl` browser tool (`isolation/codex-tools.md`) but could not confirm it can screenshot a page from a non-interactive run, and it was not tested on a page. Criterion 3 would have been inconclusive for this round on that ground alone, and also because the override was withheld.

| Output id | Brief | Cond. | Evidence source | Override | Task 1 | Task 2 | Task 3 | Task-critical Fail | Score (indicative) |
| :--- | :--- | :-: | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| none | saas-landing | A, B | missing | withheld: allowlist not enforced | unavailable | unavailable | unavailable | missing | missing |

### Per-law comparison, B to C, per brief and builder
Not applicable: no C, no audits.

## 7. Coverage matrix
No output. A separate headless Chrome 154 produced a 375×812 PNG and a 1440×900 PNG of the test page (`evidence/plumbing/shot-375.png`, `shot-1440.png`); headless Edge wrote its file asynchronously. Neither is a protocol method: a second browser process runs outside the isolated context with no allowlist and cannot show in-memory state, so the protocol requires screenshots exported from the auditor's isolated tab, which the browser pane cannot do. These two files only show that the Codex judge call could be fed a real PNG.

| Output id | 375×812 | 768×1024 | 1440×900 | 320 rest | 360 rest | 390 rest | 430 rest | 320 to 430 with each overlay open |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| none | no evidence (not built) | no evidence | no evidence | no evidence | no evidence | no evidence | no evidence | no evidence |

## 8. Cost
| Call | Provider, model | Input tokens | Output tokens | Cached | Source |
| :--- | :--- | :-: | :-: | :-: | :--- |
| build (saas-landing, A) | Claude Code | not run | not run | | |
| build (saas-landing, B) | Claude Code | not run | not run | | |
| codex tool listing (no image) | Codex, gpt-6-astra | 6,610 total | | | `isolation/codex-tools.md` |
| judge plumbing, 1 image, echo rule | Codex, gpt-6-astra | 6,833 total | | | `judges/plumbing/echo-test.md` |
| subagent probe (no tools) | Claude, haiku | 55,494 total | | | `isolation/subagent-probe.md` |
| **Total** | | **68,937** | | | |

Codex `exec` reports one `tokens used` figure, not input and output separately; the table records it as given. Projected cost of the next run cannot be made from this: no build and no multi-image judge call ran. For a budget, note that one Codex call with one 375×812 screenshot and a short prompt cost about 6,800 tokens; a preference vote attaches up to a dozen images per output, so expect each vote to be several times that, and sixteen pairs × four perspectives × two attempts at most.

## 9. Not run
- Builds A and B of saas-landing: no verified isolation mechanism (CLI not logged in).
- Probe, overflow sweep, overlay screenshots, task evidence: no output.
- The four preference perspectives: no pair.
- Mechanical pass: no output; no rubric exists yet in any case.
- Independent audit: no output; would be source-only and override-withheld.
- Verification that `--setting-sources project` excludes user-level skills: needs the CLI login.
- Whether Codex's `cua_repl` tool can drive a page from `codex exec`: not tested.
- Human calibration: not run.

## 10. Reading the criteria
- Criterion 1 (pair-majority win rate): inconclusive, from section 4.
- Criterion 2 (mechanical tells): not applicable, from section 5.
- Criterion 3 (usability non-regression): inconclusive, from sections 5, 6 and 7 (no audit, no sweep cells, no contrast pairs; Codex source-only; override withheld).
- Human calibration: not run.
