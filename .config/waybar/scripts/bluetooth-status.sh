#!/usr/bin/env bash
# Waybar custom module: one segment per connected BT device, with battery
# when BlueZ exposes it (requires Experimental = true in main.conf).

icon_for() {
  # $1 = BlueZ Icon property, $2 = device alias.
  # Alias overrides first: some devices misreport their class.
  case "$2" in
    *"Stage Air"*) echo "󰓃"; return ;;
  esac
  case "$1" in
    input-mouse) echo "󰍽" ;;
    input-keyboard) echo "󰌌" ;;
    audio-headset|audio-headphones) echo "󰋋" ;;
    audio-card|audio-speakers) echo "󰓃" ;;
    phone) echo "󰄜" ;;
    *) echo "󰂱" ;;
  esac
}

segments=()
tooltip_lines=()
min_batt=100

bt_on=true
if ! bluetoothctl show | grep -q "Powered: yes"; then
  bt_on=false
  tooltip_lines+=("Bluetooth: off")
fi

$bt_on && while read -r _ mac _; do
  info=$(bluetoothctl info "$mac")
  grep -q "Connected: yes" <<<"$info" || continue

  name=$(sed -n 's/^\s*Alias: //p' <<<"$info")
  icon=$(icon_for "$(sed -n 's/^\s*Icon: //p' <<<"$info")" "$name")
  batt=$(sed -n 's/.*Battery Percentage.*(\([0-9]\+\)).*/\1/p' <<<"$info")

  if [ -n "$batt" ]; then
    segments+=("$icon ${batt}%")
    tooltip_lines+=("$name: ${batt}%")
    [ "$batt" -lt "$min_batt" ] && min_batt=$batt
  else
    segments+=("$icon")
    tooltip_lines+=("$name: connected (no battery info)")
  fi
done < <(bluetoothctl devices)

# Corsair devices via OpenLinkHub (Slipstream receiver, not Bluetooth)
olh=$(curl -sf --max-time 1 http://127.0.0.1:27003/api/devices/ 2>/dev/null)
if [ -n "$olh" ]; then
  while IFS=$'\t' read -r serial product; do
    detail=$(curl -sf --max-time 1 "http://127.0.0.1:27003/api/devices/$serial" 2>/dev/null)
    connected=$(jq -r '.device.Connected' <<<"$detail")
    batt=$(jq -r '.device.BatteryLevel // empty' <<<"$detail")
    [ "$connected" = "true" ] || continue
    if [ -n "$batt" ] && [ "$batt" != "0" ]; then
      segments+=("󰍽 ${batt}%")
      tooltip_lines+=("$product: ${batt}%")
      [ "$batt" -lt "$min_batt" ] && min_batt=$batt
    else
      segments+=("󰍽")
      tooltip_lines+=("$product: connected (no battery info)")
    fi
  done < <(jq -r '.devices | to_entries[] | select(.value.Hidden == false) | [.key, .value.Product] | @tsv' <<<"$olh")
fi

if [ ${#segments[@]} -eq 0 ]; then
  if $bt_on; then
    printf '{"text": "󰂯", "tooltip": "Bluetooth on — nothing connected", "class": "disconnected"}\n'
  else
    printf '{"text": "󰂲", "tooltip": "Bluetooth off", "class": "off"}\n'
  fi
else
  text=$(IFS='  '; echo "${segments[*]}")
  tooltip=$(printf '%s\\n' "${tooltip_lines[@]}")
  class="connected"
  [ "$min_batt" -lt 20 ] && class="low"
  printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$text" "${tooltip%\\n}" "$class"
fi
