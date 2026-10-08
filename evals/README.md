# Evals

Data files only. Nothing here runs automatically.

- `evals.json` follows the Anthropic skill-creator schema: `skill_name` and `evals[]`, each with `id`, `prompt`, `expected_output`, `files` and `expectations[]`. Evals 2 and 8 carry their markup inline. Eval 7 (site sweep) asks for fixes, so it must **never** run on the canonical fixtures. Copy `ux-laws/evals/fixtures/site-sections.html` and `overflow-unclipped.html` into a new, empty temporary folder. Serve that copy at `http://127.0.0.1:4180/`, for example `python -m http.server 4180 --directory <copy>`, and put the copy's path in place of `[EVAL7_COPY]` in the prompt. Delete the copy afterwards. The `ux-laws` fixtures and their documented probe results must stay unchanged. Before the run, graders can check the copy's probe numbers against `ux-laws/evals/README.md`.
- `trigger-eval.json` is a list of `{query, should_trigger}`: positives and near-miss negatives that belong to a single skill (a style request, a UX audit, a WCAG audit, performance, copywriting, an icon choice, a contrast-only check). The last four (two site-sweep positives, a Lighthouse run and a contrast-only check) were added in v1.2.0.

## Manual run: functional evals
1. Start a fresh session with this skill and `ui-styles` and `ux-laws` available. For eval 3, make sure `ux-laws` is not available. For eval 7, prepare and serve the disposable copy as described above, and give the session a browser tool.
2. Give it each `prompt`. Don't tell it what is expected.
3. Grade every entry in `expectations` as pass or fail, and record a reason for each failure.
4. Optional baseline: repeat with the three skills removed, and compare.

## Manual run: trigger evals
The queries alternate between positives and near-miss negatives. Use the first 14 as the tuning set and the last 10 as held-out (the held-out set includes the four site-sweep-era queries), and look at the held-out results only after you finish editing the description. A query is correct when whether the skill loaded equals `should_trigger`. The near-miss negatives matter most: a request one of the single skills covers should load **that** skill, not this conductor.

## Not run in this repository's release process
The automatic trigger tester (`run_eval.py`, `run_loop.py` in Anthropic's skill-creator) needs the `claude` CLI, which was not available when v1.0.0 was prepared. The trigger set was reviewed by hand and not run through the tester.
