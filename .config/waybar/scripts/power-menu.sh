#!/bin/sh

# Toggle behavior: if another menu is open, close it instead of stacking.
"$HOME/.config/hypr/scripts/menu" --close && exit 0

options="󰌾  Lock
󰍃  Logout
󰤄  Suspend
󰜉  Reboot
󰐥  Power off"

choice=$(printf '%s' "$options" | "$HOME/.config/hypr/scripts/menu" --dmenu --prompt "Power" --width 240 --lines 5 --matching fuzzy --insensitive)

case "$choice" in
  *"Lock")
    hyprlock
    ;;
  *"Logout")
    hyprctl dispatch 'hl.dsp.exit()'
    ;;
  *"Suspend")
    systemctl suspend
    ;;
  *"Reboot")
    systemctl reboot
    ;;
  *"Power off")
    systemctl poweroff
    ;;
esac
