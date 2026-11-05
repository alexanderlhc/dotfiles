#!/usr/bin/env bash
# Word versions of the glyph-based status modules, for the text bar.
dir=$(dirname "$(readlink -f "$0")")
case $1 in
  bt)   "$dir/bluetooth-status.sh" | sed 's/󰍽/mouse/g; s/󰌌/kbd/g; s/󰋋/head/g; s/󰓃/spk/g; s/󰄜/phone/g; s/󰂱/bt/g; s/"text": "󰂯"/"text": "bt"/; s/"text": "󰂲"/"text": "bt off"/' ;;
  mail) "$dir/aerc-unread.sh" | jq -c '.text |= (gsub("[^0-9]"; "") | if . == "" then "" else "mail " + . end)' ;;
  # Active VPNs by name ("ts" = Tailscale); empty hides the module.
  vpn)  names=$(nmcli -t -f NAME,TYPE con show --active 2>/dev/null | awk -F: '$2=="vpn"||$2=="wireguard"{print $1}')
        command -v tailscale >/dev/null && [ "$(tailscale status --json 2>/dev/null | jq -r .BackendState)" = Running ] && names+=$'\nts'
        names=$(grep . <<<"$names" | paste -sd' ')
        jq -cn --arg n "$names" '{text: (if $n == "" then "" else "vpn " + $n end), class: (if $n == "" then "off" else "on" end)}' ;;
esac
