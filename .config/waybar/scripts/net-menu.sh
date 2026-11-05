#!/usr/bin/env bash
# Menu: toggle a VPN, or open nmtui for everything else.
# VPN logins (e.g. OpenConnect) need nm-applet running as the secret agent:
# it shows the login dialog with the saved password from the keyring.

"$HOME/.config/hypr/scripts/menu" --close && exit 0

entries="network settings (nmtui)\n"
while IFS=: read -r name type state; do
  [ "$type" = vpn ] || continue
  if [ "$state" = activated ]; then entries+="vpn off  $name\n"
  else entries+="vpn on   $name\n"; fi
done < <(nmcli -t -f NAME,TYPE,STATE con show 2>/dev/null)

choice=$(printf '%b' "$entries" | "$HOME/.config/hypr/scripts/menu" --dmenu --prompt "Network" \
  --lines "$(printf '%b' "$entries" | grep -c .)" --insensitive) || exit 0

case "$choice" in
  "vpn on   "*)  name=${choice#"vpn on   "}
                 nmcli --wait 180 con up "$name" >/dev/null 2>&1 \
                   && notify-send "VPN" "$name connected" \
                   || notify-send -u critical "VPN" "$name failed to connect" ;;
  "vpn off  "*)  name=${choice#"vpn off  "}
                 nmcli con down "$name" >/dev/null 2>&1 && notify-send "VPN" "$name disconnected" ;;
  "network settings"*) setsid -f foot --app-id=rice-tui-net --window-size-chars=110x32 -- nmtui >/dev/null 2>&1 </dev/null ;;
esac
