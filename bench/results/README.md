# Results

One folder per run, named `<date>-<label>/` (for example `2026-10-13-smoke/`, `2026-11-02-baseline/`). Everything in here is committed; everything a run built is not.

## What goes in a run folder
```
summary.md          filled from summary-template.md; the only file the criteria read
judges/<pair>/      raw preference votes: prompt, image list, reply, usage, per perspective and attempt
mechanical/<id>.md  the mechanical reviewer's counts per output
audits/<id>.md      the independent audit per output, first line naming the override
```
Outputs, screenshots, probe JSON, build usage and the id map live outside the checkout in the run folder [protocol.md](../protocol.md) section 10 describes. The summary quotes what it needs from them and names the run folder's path.

## Rules
- The summary follows [summary-template.md](summary-template.md) section for section. A section that does not apply says so; it is not deleted.
- Every table cell is filled from a stored file or marked **missing** with the reason. Nothing is filled in from memory or rounded up.
- Each comparison is labelled **conclusive** or **inconclusive** by the rules in [judge.md](../judge.md) section 5, and each criterion by the plan's acceptance criteria.
- The rubric version used by the mechanical pass is stated even when it is `none`.
- Every summary says "AI-judged" in its first line, names both providers and their model ids, and states which isolation mechanism each condition used.
- Token usage is reported per build and per judge call, so the next run can be budgeted from the last.
- A smoke run (one brief) proves the protocol runs end to end; it never satisfies a criterion, and its summary says so.
