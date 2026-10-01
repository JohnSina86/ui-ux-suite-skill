# Releasing

Run this checklist before tagging. Each step is a manual check.

1. **Frontmatter:** `name` is `ui-ux-suite` (the install folder name), the description is at most 400 characters, third person, with a "Use when" and a "Not for" clause, and contains no hard-coded counts. `metadata.version` matches the tag.
2. **Size:** `SKILL.md` is at most 200 lines. Every file in `references/` is linked from `SKILL.md`. Every file over 100 lines starts with a table of contents.
3. **No copied content:** the repository contains no style tokens, no CSS recipes and no law definitions. Search for `--ui-` and for the 20 law names. Anything beyond a pointer belongs in a companion skill.
4. **Pointers:** every section number the files cite from `ui-styles` or `ux-laws` exists in the **tagged companion versions** named in the README. After a companion release, re-check them.
5. **Companion pins:** the README install lines name tags that exist. When a companion releases, update the pins and the changelog.
6. **Modes and gates:** each mode in `SKILL.md` section 1 appears in `references/pipeline.md` (the stage table or the short modes), and each stage has a gate.
7. **Evals:** run the four functional evals by hand (`evals/README.md`), including the missing-companion case, and record the results in the release notes.
8. **Tag:** update the README status line and the changelog **first**, and commit them. Then run `git tag -a vX.Y.Z -m vX.Y.Z`, and check the tagged tree with `git show vX.Y.Z:README.md`.
