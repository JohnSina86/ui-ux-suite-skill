# Run summary: <date> <label>

AI-judged. Builder: <provider, model id>. Judge: <provider, model id>. Rubric version: <none | ui-styles anti-slop vX.Y>. Run folder (outside the checkout): `<path>`.

Copy this file to `<date>-<label>/summary.md` and fill every section. Keep a section that does not apply and say why. Replace every `<...>`.

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
- Briefs: <list; say "dreammadestudio: not supplied" when it is>
- Conditions: <A, B | A, B, C>. Condition manifest (`conditions.json`): B = <the three repos and pinned tags>; C = <every repo of the set under test with its tag, including ui-copy from W5 onwards | "none">
- Rounds: <which builder built which conditions>
- Builder configuration, frozen per provider (`conditions.json`): Claude Code = <model id, effort, sampling: none exposed>; Codex = <model id, reasoning effort, sampling: none exposed>. Resolved values per output are in `builds/<id>.json`; mismatched pairs are listed in section 4.
- Kind of run: <baseline | W6 re-measure | smoke test (proves the protocol only; satisfies no criterion)>

## 2. Isolation
| Condition | Mechanism | Verified by | Result |
| :-: | :--- | :--- | :--- |
| A | <flags or method> | `isolation/<id>.txt` | <matches: no skills | did not match: ... | not run: ...> |
| B | <method> | `isolation/<id>.txt`, `isolation/<id>.tags.txt` | <...> |
| C | <method> | <...> | <...> |

Browser: <tool>. Origin allowlist: <enforced by ... | not enforced by ...>. Override: <granted for ids ... | withheld: reason>. From `isolation/browser.md`.

## 3. Pair table
One row per pair. Votes are `1` or `2` as the judge saw them, with the condition the number mapped to in brackets, from `map.json` after judging.

| Brief | Builder | Pair | Art director | First-time visitor | Copy editor | Usability reviewer | Result |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| <brief> | <builder> | <B vs A> | <pick (cond), attempt n | discarded ×2> | ... | ... | ... | <B | A | tie | incomplete> |

Discarded votes and re-runs are listed under the table with the reason (no detail, detail not in render).

## 4. Decided-pair rates
| Comparison | Pairs | Complete | Ties | Incomplete (of which configuration mismatch) | Decided | Won by <X> | Rate | Status |
| :--- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :--- |
| <C vs A> | 8 | <n> | <n> | <n (m)> | <n> | <n> | <won/decided or n/a> | <conclusive | inconclusive: reason> |
| <C vs B> | 8 | ... | ... | ... | ... | ... | ... | ... |
| <B vs A> (baseline) | 8 | ... | ... | ... | ... | ... | ... | ... |

Gates from the plan: C wins at least 80% of decided pairs against A and at least 65% against B. A comparison with zero decided pairs or fewer than six complete pairs is inconclusive. Eight pairs is a gate, not a statistic.

## 5. Mechanical counts
Rubric version: <none | version>. Counting unit: <per the rubric | n/a>.

| Output id | Brief | Cond. | High tells | Medium tells | Contrast pairs (total = ledger-only + recomputed + unverified; below threshold) | Overflow cells (expected / measured / zero / overflow) | Blocked requests | Remote refs |
| :--- | :--- | :-: | :-: | :-: | :--- | :--- | :-: | :-: |
| <id> | ... | ... | <n | not counted> | ... | <t = a + b + c; d> | <e / a / b / c> | <n> | <n> |

Contrast buckets are disjoint (`judge.md` section 3): a pair is ledger-only, recomputed or unverified, never two of these, and the three must add up to the total; a row whose sum does not match is reported as a counting error, not corrected. Expected overflow cells are four widths at rest plus four per overlay. Both feed criterion 3.

Rubric exceptions applied, each with its evidence record of a type the recorded rubric version accepts (`mechanical/<id>.md`): <list | none>. Retained tells, each with its user constraint record: <list | none>. Rubric rows unassessable (brief, content pack or delivery-note records missing from the handoff): <rows | none>. An output with unassessable rows cannot meet criterion 2.

Criterion 2: C has zero high and at most two medium tells per page. <met | not met | not applicable: no rubric>.

## 6. Independent audits
One block per output, from `audits/<id>.md`.

| Output id | Brief | Cond. | Evidence source | Override | Task 1 | Task 2 | Task 3 | Task-critical Fail | Score (indicative) |
| :--- | :--- | :-: | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| <id> | ... | ... | <live page | source only> | <granted | withheld: reason> | <completed | not completed: where | unavailable> | ... | ... | <none | law row n> | <n%> |

### Per-law comparison, B to C, per brief and builder
One table per brief and builder. Rows are the 20 law rows as the `ux-laws` report numbers them; names and definitions stay in `ux-laws`.

| Law row | B status | C status | Change | Evidence source (B / C) | Note |
| :-: | :--- | :--- | :--- | :--- | :--- |
| 1 | <Pass | Warning | Fail | N/A | Not assessed> | <...> | <same | better | Pass to Warning | Pass to Fail | Warning to Fail | assessed to Not assessed | became N/A (evidenced) | became N/A (unevidenced)> | <...> | <for N/A: the audit's evidence that the trigger is absent without required functionality removed> |

Criterion 3 per brief and builder, by the rules in `judge.md` section 4, combining this section with sections 5 and 7 for the same output:
- Tasks: <all three evidenced | task n unknown: inconclusive>
- Task-critical Fail in C: <none | law row n: not met>
- Pass or Warning regressions (Pass to Warning, Pass to Fail, Warning to Fail): <none | rows ...: not met>
- Assessed in B, Not assessed in C: <none | rows ...: not met>
- N/A transitions: <none | rows ... evidenced | rows ... unevidenced: not met>
- Overflow cells (section 7): <all expected cells measured at 0 | cells ... overflow: not met | cells ... missing: inconclusive>
- Contrast pairs (section 5): <all verified, none below threshold | pairs ... below: not met | pairs ... unverified: inconclusive>
- Result: <met | not met | inconclusive>

## 7. Coverage matrix
One table per output. Cells are `measured`, `screenshot only`, `source only` or `no evidence (reason)`.

| Output id | 375×812 | 768×1024 | 1440×900 | 320 rest | 360 rest | 390 rest | 430 rest | 320 to 430 with each overlay open |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| <id> | <cell> | ... | ... | <overflowX n> | ... | ... | ... | <overlay: widths and overflowX, or "no overlays"> |

## 8. Cost
| Call | Provider, model | Input tokens | Output tokens | Cached | Source |
| :--- | :--- | :-: | :-: | :-: | :--- |
| build <id> (<brief>, <cond.>) | ... | ... | ... | ... | `builds/<id>.json` |
| judge <pair> <perspective> attempt n | ... | ... | ... | ... | `judges/<pair>/...` (the usability vote records the ux-laws tag pasted) |
| mechanical <id> | ... | ... | ... | ... | ... |
| audit <id> | ... | ... | ... | ... | ... |
| **Total** | | | | | |

Projected cost of the next run at this rate: <builds × ... + judge calls × ...>.

## 9. Not run
List every build, vote, count, audit or cell that is missing, with its reason. "None" only after checking every table above.

## 10. Reading the criteria
- Criterion 1 (pair-majority win rate): <met | not met | inconclusive>, from section 4.
- Criterion 2 (mechanical tells): <met | not met | not applicable>, from section 5.
- Criterion 3 (usability non-regression): <met | not met | inconclusive>, from the per-brief results in section 6, which read the law rows (Pass and Warning regressions, assessed-to-Not-assessed, unevidenced N/A transitions, task-critical Fails), the three tasks, section 7 (every expected sweep cell measured with `overflowX` 0) and section 5 (every contrast pair verified). Any unknown task, missing cell or unverified pair: inconclusive. Any regression, overflow or failing pair: not met.
- Human calibration: <n of 5 agree | not run>.
