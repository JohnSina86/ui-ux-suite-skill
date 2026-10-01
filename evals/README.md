# Evals

Data files only. Nothing here runs automatically.

- `evals.json` follows the Anthropic skill-creator schema: `skill_name` and `evals[]`, each with `id`, `prompt`, `expected_output`, `files` and `expectations[]`. No fixtures are needed: eval 2 carries its markup inline.
- `trigger-eval.json` is a list of `{query, should_trigger}`: ten positives and ten near-miss negatives that belong to a single skill (a style request, a UX audit, a WCAG audit, performance, copywriting, an icon choice).

## Manual run: functional evals
1. Start a fresh session with this skill and `ui-styles` and `ux-laws` available. For eval 3, make sure `ux-laws` is not available.
2. Give it each `prompt`. Don't tell it what is expected.
3. Grade every entry in `expectations` as pass or fail, and record a reason for each failure.
4. Optional baseline: repeat with the three skills removed, and compare.

## Manual run: trigger evals
The queries alternate between positives and near-miss negatives. Use the first 12 as the tuning set and the last 8 as held-out, and look at the held-out results only after you finish editing the description. A query is correct when whether the skill loaded equals `should_trigger`. The near-miss negatives matter most: a request one of the single skills covers should load **that** skill, not this conductor.

## Not run in this repository's release process
The automatic trigger tester (`run_eval.py`, `run_loop.py` in Anthropic's skill-creator) needs the `claude` CLI, which was not available when v1.0.0 was prepared. The trigger set was reviewed by hand and not run through the tester.
