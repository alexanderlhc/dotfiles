#!/bin/sh

# Toggle behavior: if another menu is open, close it instead of stacking.
"$HOME/.config/hypr/scripts/menu" --close && exit 0

options="󰌾  Lock
󰍃  Logout
󰤄  Suspend
󰜉  Reboot
󰐥  Power off"

choice=$(printf '%s' "$options" | "$HOME/.config/hypr/scripts/menu" --dmenu --prompt "Power" --width 240 --lines 5 --matching fuzzy --insensitive)

# Close apps gracefully first (hyprshutdown), then run the action; plain fallback without it.
leave() {
  if command -v hyprshutdown >/dev/null; then
    if [ -n "$1" ]; then hyprshutdown -t "$2" -p "$1"; else hyprshutdown -t "$2"; fi
  else
    ${1:-hyprctl dispatch 'hl.dsp.exit()'}
  fi
}

case "$choice" in
  *"Lock")
    hyprlock
    ;;
  *"Logout")
    leave "" "Logging out..."
    ;;
  *"Suspend")
    systemctl suspend
    ;;
  *"Reboot")
    leave "systemctl reboot" "Rebooting..."
    ;;
  *"Power off")
    leave "systemctl poweroff" "Shutting down..."
    ;;
esac
