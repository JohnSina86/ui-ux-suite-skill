#!/usr/bin/env bash
# Installs the two skills that ui-ux-suite depends on (ui-styles and ux-laws)
# next to it, in the same skills folder. Safe to run again: it updates them.
#
#   cd ~/.claude/skills
#   git clone https://github.com/JohnSina86/ui-ux-suite-skill.git ui-ux-suite
#   ./ui-ux-suite/install.sh            # newest versions (main)
#   ./ui-ux-suite/install.sh --ref v1.2.1   # a tag or branch, for the two companions
#
# This script is for people, not for the agent. The skill never runs it.
set -euo pipefail

REF="main"
if [ "${1:-}" = "--ref" ]; then
  REF="${2:?--ref needs a tag or branch name}"
elif [ -n "${1:-}" ]; then
  echo "Usage: install.sh [--ref <tag-or-branch>]" >&2; exit 2
fi

command -v git >/dev/null 2>&1 || { echo "git is required but was not found." >&2; exit 1; }

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT="$(dirname "$HERE")"
if [ "$(basename "$HERE")" != "ui-ux-suite" ]; then
  echo "Warning: this folder is called '$(basename "$HERE")'. It must be called 'ui-ux-suite' to match the skill name." >&2
fi

install_one() {
  local name="$1" url="$2" target="$PARENT/$1"
  if [ -d "$target/.git" ]; then
    echo "Updating $name to $REF ..."
    git -C "$target" fetch --quiet --tags origin
    git -C "$target" -c advice.detachedHead=false checkout --quiet "$REF"
    if git -C "$target" symbolic-ref --quiet HEAD >/dev/null; then
      git -C "$target" pull --quiet --ff-only origin "$REF"
    fi
  elif [ -e "$target" ]; then
    echo "Error: $target exists but is not a git checkout. Move it away and run this again." >&2; exit 1
  else
    echo "Installing $name ($REF) ..."
    git -c advice.detachedHead=false clone --quiet --branch "$REF" "$url" "$target"
  fi
}

install_one ui-styles https://github.com/JohnSina86/ui-styles-skill.git
install_one ux-laws   https://github.com/JohnSina86/ux-laws-skill.git

echo
echo "Installed in: $PARENT"
ok=1
for name in ui-styles ux-laws ui-ux-suite; do
  if [ -f "$PARENT/$name/SKILL.md" ]; then
    echo "  OK  $name  ($(git -C "$PARENT/$name" describe --tags --always 2>/dev/null || echo unknown))"
  else
    echo "  MISSING  $name/SKILL.md"; ok=0
  fi
done
[ "$ok" = 1 ] || { echo "Something is missing. See the lines above." >&2; exit 1; }
echo "Done. Start a new agent session so it picks the skills up."
