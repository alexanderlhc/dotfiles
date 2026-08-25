#!/usr/bin/env bash
# vim-tmux-navigator, for herdr.
# ctrl+h/j/k/l moves between herdr panes, EXCEPT when the focused pane is
# running vim/nvim/fzf — then the keystroke is passed through so the editor
# can move between its own splits. The nvim side (lua/plugins/tmux_navigator.lua)
# calls `herdr pane focus` back when a split move hits the edge.
set -euo pipefail

dir="${1:?usage: herdr-nav.sh <left|down|up|right>}"
case "$dir" in
  left)  key=ctrl+h ;;
  down)  key=ctrl+j ;;
  up)    key=ctrl+k ;;
  right) key=ctrl+l ;;
  *) exit 2 ;;
esac

# HERDR_NAV_PANE overrides the focused pane (used for testing).
pane="${HERDR_NAV_PANE:-$(herdr api snapshot 2>/dev/null | jq -r '.result.snapshot.focused_pane_id // empty')}"
[ -n "$pane" ] || exit 0

# Same process set vim-tmux-navigator matches on.
procs=$(herdr pane process-info --pane "$pane" 2>/dev/null \
  | jq -r '[.result.process_info.foreground_processes[].name] | join("\n")' || true)

if grep -qxE '(\S+/)?g?(view|l?n?vim?x?|fzf)(diff)?' <<<"$procs"; then
  herdr pane send-keys "$pane" "$key" >/dev/null
else
  herdr pane focus --pane "$pane" --direction "$dir" >/dev/null
fi
