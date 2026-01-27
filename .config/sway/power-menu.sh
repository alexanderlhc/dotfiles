#!/bin/sh

options="Lock
Logout
Suspend
Reboot
Power off"
choice=$(printf '%b' "$options" | wofi --dmenu --prompt "Power" --width 240 --lines 5 --matching fuzzy --insensitive)

case "$choice" in
  Lock)
    swaylock
    ;;
  Logout)
    swaymsg exit
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
