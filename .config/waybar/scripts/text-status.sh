#!/usr/bin/env bash
# Word versions of the glyph-based status modules, for the text bar.
dir=$(dirname "$(readlink -f "$0")")
case $1 in
  bt)   "$dir/bluetooth-status.sh" | sed 's/󰍽/mouse/g; s/󰌌/kbd/g; s/󰋋/head/g; s/󰓃/spk/g; s/󰄜/phone/g; s/󰂱/bt/g; s/"text": "󰂯"/"text": "bt"/; s/"text": "󰂲"/"text": "bt off"/' ;;
  mail) "$dir/aerc-unread.sh" | jq -c '.text |= (gsub("[^0-9]"; "") | if . == "" then "" else "mail " + . end)' ;;
esac
