#!/usr/bin/env bash
# prefix+shift+g — new worktree that accepts spaces.
# Herdr's built-in prompt lets you type spaces, then rejects them as a branch
# name. Here the typed text becomes the workspace label as-is, and a slug of it
# (spaces -> '-', git-illegal chars dropped) becomes the branch.
set -euo pipefail

# Repo = cwd of the pane that was focused when the popup opened.
cwd=$(herdr api snapshot 2>/dev/null | jq -r '
  .result.snapshot as $s
  | ($s.panes[] | select(.pane_id == $s.focused_pane_id)
     | .foreground_cwd // .cwd) // empty')
cwd=${cwd:-$PWD}

if ! git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  echo "Not a git repo: $cwd"; read -rn1 -p "Press a key"; exit 1
fi

slugify() {
  sed -E 's/[[:space:]]+/-/g; s/[~^:?*\\[[:cntrl:]]//g; s/\.\.+/./g; s/-+/-/g; s/^[-./]+//; s/[-./]+$//; s/\.lock$//' <<<"$1"
}

echo "New worktree in $(basename "$(git -C "$cwd" rev-parse --show-toplevel)")"
read -erp "Name: " name
[ -n "${name// /}" ] || exit 0

branch=$(slugify "$name")
if ! git check-ref-format --branch "$branch" >/dev/null 2>&1; then
  echo "Can't make a valid branch from: $name"; read -rn1 -p "Press a key"; exit 1
fi

herdr worktree create --cwd "$cwd" --branch "$branch" --label "$name" --focus >/dev/null
