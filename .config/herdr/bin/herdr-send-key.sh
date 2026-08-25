#!/usr/bin/env bash
# Escape hatch: send a key literally to the focused pane, for keys herdr has
# taken over globally (mirrors tmux's `bind C-l send-keys 'C-l'`).
set -euo pipefail
pane=$(herdr api snapshot 2>/dev/null | jq -r '.result.snapshot.focused_pane_id // empty')
[ -n "$pane" ] || exit 0
herdr pane send-keys "$pane" "$@" >/dev/null
