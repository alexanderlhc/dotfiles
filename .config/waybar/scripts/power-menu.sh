#!/bin/sh

options="Logout
Suspend
Reboot
Power off"

choice=$(printf '%s' "$options" | wofi --dmenu --prompt "Power" --width 240 --lines 4 --matching fuzzy --insensitive)

case "$choice" in
  Logout)
    hyprctl dispatch exit
    ;;
  Suspend)
    systemctl suspend
    ;;
  Reboot)
    systemctl reboot
    ;;
  "Power off")
    systemctl poweroff
    ;;
esac
