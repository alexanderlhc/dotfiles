#!/usr/bin/env bash
# Wofi menu: toggle bluetooth power, connect/disconnect paired devices.

entries=""
if bluetoothctl show | grep -q "Powered: yes"; then
  entries+="󰂲  Turn Bluetooth off\n"
  while read -r _ mac rest; do
    if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
      entries+="󰂱  Disconnect $rest\t$mac\n"
    else
      entries+="󰂯  Connect $rest\t$mac\n"
    fi
  done < <(bluetoothctl devices)
else
  entries+="󰂯  Turn Bluetooth on\n"
fi

choice=$(printf '%b' "$entries" | wofi --dmenu --prompt "Bluetooth" --insensitive) || exit 0
mac=$(awk -F'\t' '{print $2}' <<<"$choice")

case "$choice" in
  *"Turn Bluetooth off"*) bluetoothctl power off ;;
  *"Turn Bluetooth on"*) bluetoothctl power on ;;
  "󰂱"*) bluetoothctl disconnect "$mac" ;;
  "󰂯"*) bluetoothctl connect "$mac" ;;
esac

pkill -RTMIN+8 waybar
