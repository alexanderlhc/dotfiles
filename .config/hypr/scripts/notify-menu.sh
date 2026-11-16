#!/usr/bin/env bash
# Notification menu (Super+I): dismiss, do not disturb, or bring back an old one.
# Direct keys for the same: Super+Shift+I dismisses all.

"$HOME/.config/hypr/scripts/menu" --close && exit 0

shown=$(makoctl list -j | jq length)
grep -qx do-not-disturb <<<"$(makoctl mode)" && dnd=on || dnd=off

entries=""
entries+="dismiss all ($shown on screen)    Super+Shift+I\n"
# Actions (e.g. jump to the chat) only work for notifications still on screen.
[ "$shown" -gt 0 ] && entries+="open the one on screen (run its action)\n"
entries+="do not disturb: $dnd\n"
# mako can only bring back the most recently dismissed notification, so the
# history entry names that one rather than listing them all.
last=$(makoctl history -j | jq -r 'first // empty | "\(.app_name)  \(.summary | gsub("[\\t\\n]"; " "))"')
[ -n "$last" ] && entries+="show again: $last\n"

menu=$(printf '%b' "$entries")
count=$(grep -c . <<<"$menu")
index=$(printf '%s\n' "$menu" | "$HOME/.config/hypr/scripts/menu" --dmenu -D dmenu-print_line_num=true \
  --prompt Notifications --width 720 --lines "$count" --insensitive) || exit 0
[[ "$index" =~ ^[0-9]+$ ]] || exit 0

case "$(sed -n "$((index + 1))p" <<<"$menu")" in
  "open the one"*)    makoctl invoke ;;
  "dismiss all"*)     makoctl dismiss --all ;;
  "do not disturb"*)  makoctl mode -t do-not-disturb ;;
  "show again"*)      makoctl restore ;;
esac
