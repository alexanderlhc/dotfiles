#!/usr/bin/env bash
# Notification menu (Super+I): dismiss, do not disturb, or bring back an old one.
# Direct keys for the same: Super+Shift+I dismisses all.

"$HOME/.config/hypr/scripts/menu" --close && exit 0

shown=$(dunstctl count displayed)
paused=$(dunstctl is-paused)

entries=""
# Actions (e.g. jump to the chat) only work for notifications still on screen;
# dunst's history keeps no actions, so old ones can only be shown again.
[ "$shown" -gt 0 ] && entries+="open the one on screen (run its action)\ndismiss all on screen ($shown)\n"
if [ "$paused" = true ]; then entries+="do not disturb: on\n"; else entries+="do not disturb: off\n"; fi
entries+="clear history\n"
# History, newest first: "id<TAB>show again  HH:MM  app  summary". Timestamps are µs since boot.
boot=$(( $(date +%s) - $(cut -d. -f1 /proc/uptime) ))
hist=$(dunstctl history | jq -r --argjson boot "$boot" '
  .data[0][] | "\(.id.data)\t\(($boot + (.timestamp.data / 1000000 | floor)) | strflocaltime("show again  %H:%M"))  \(.appname.data)  \(.summary.data | gsub("[\\t\\n]"; " "))"')

menu=$(printf '%b' "$entries"; [ -n "$hist" ] && cut -f2- <<<"$hist")
count=$(grep -c . <<<"$menu")
index=$(printf '%s\n' "$menu" | "$HOME/.config/hypr/scripts/menu" --dmenu -D dmenu-print_line_num=true \
  --prompt Notifications --width 720 --lines $((count < 12 ? count : 12)) --insensitive) || exit 0
[[ "$index" =~ ^[0-9]+$ ]] || exit 0

choice=$(sed -n "$((index + 1))p" <<<"$menu")
fixed=$(printf '%b' "$entries" | grep -c .)
case "$choice" in
  "open the one"*)     dunstctl action ;;
  "dismiss all"*)     dunstctl close-all ;;
  "do not disturb"*)  dunstctl set-paused toggle ;;
  "clear history")    dunstctl history-clear ;;
  *) [ "$index" -ge "$fixed" ] && dunstctl history-pop "$(sed -n "$((index - fixed + 1))p" <<<"$hist" | cut -f1)" ;;
esac
