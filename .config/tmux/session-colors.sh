#!/bin/sh
# Assign a subtle status-bar tint per tmux session based on name hash.
# Usage: session-colors.sh [--all]

PALETTE='#c8d8e8 #e8c8d4 #c8e0d0 #d8c8e8 #e4dcc0 #c0dede #e8d0c8 #d0e4c8 #c8c8e4'
FG='#54433a'

color_session() {
  name="$1"
  hash=$(printf '%s' "$name" | cksum | cut -d' ' -f1)
  set -- $PALETTE
  count=$#
  idx=$(( (hash % count) + 1 ))
  eval "color=\${$idx}"
  tmux set-option -t "$name" status-style "bg=${color},fg=${FG}"
  tmux set-option -t "$name" status-left-style "bg=${color},fg=${FG}"
  tmux set-option -t "$name" status-right-style "bg=${color},fg=${FG}"
}

if [ "$1" = "--all" ]; then
  tmux list-sessions -F '#S' | while IFS= read -r s; do
    color_session "$s"
  done
else
  s=$(tmux display-message -p '#S')
  color_session "$s"
fi
