#!/usr/bin/env bash
# Menu: toggle a VPN (NM VPNs, WireGuard, Tailscale), or open nmtui for everything else.
# Tailscale runs without sudo because this user is its operator (`sudo tailscale set --operator=$USER`).
# OpenConnect VPNs log in here, headless: username/group from the NM connection,
# password from the keyring (saved there by the old auth dialog), then the
# session cookie is handed to NetworkManager so it still owns routes and DNS.

"$HOME/.config/hypr/scripts/menu" --close && exit 0

notify() { notify-send "$@" VPN "$name ${msg}"; }

oc_up() {
  local uuid user group gw proto pass out f
  sec() { nmcli --show-secrets -g vpn.secrets con show "$name" | sed 's/\\:/:/g' | tr ',' '\n' | sed -n "s/^ *$1 = //p"; }
  dat() { nmcli -g vpn.data con show "$name" | tr ',' '\n' | sed -n "s/^ *$1 = //p"; }
  uuid=$(nmcli -g connection.uuid con show "$name")
  user=$(sec form:main:username); group=$(sec form:main:group_list)
  gw=$(dat gateway); proto=$(dat protocol)
  pass=$(secret-tool lookup vpn_uuid "$uuid" auth_id main label password) || return 1
  # Prints COOKIE, HOST, CONNECT_URL, FINGERPRINT, RESOLVE as shell assignments.
  out=$(printf '%s\n' "$pass" | openconnect --authenticate --non-inter --protocol="$proto" \
        --user="$user" ${group:+--authgroup="$group"} --passwd-on-stdin "$gw" 2>/dev/null) || return 1
  eval "$out"
  f=$(mktemp "$XDG_RUNTIME_DIR/vpn.XXXXXX"); chmod 600 "$f"
  printf 'vpn.secrets.cookie:%s\nvpn.secrets.gateway:%s\nvpn.secrets.gwcert:%s\nvpn.secrets.resolve:%s\n' \
    "$COOKIE" "$HOST" "$FINGERPRINT" "${RESOLVE:-}" >"$f"
  nmcli --wait 60 con up "$name" passwd-file "$f" >/dev/null 2>&1; local rc=$?
  rm -f "$f"; return $rc
}

vpn_up() {
  if [ "$name" = tailscale ]; then
    tailscale up >/dev/null 2>&1
  elif [ "$(nmcli -g vpn.service-type con show "$name")" = org.freedesktop.NetworkManager.openconnect ]; then
    oc_up
  else
    nmcli --wait 60 con up "$name" >/dev/null 2>&1
  fi
}

entries="network settings (nmtui)\n"
while IFS=: read -r cname type state; do
  case $type in vpn|wireguard) ;; *) continue ;; esac
pkill -RTMIN+9 waybar
  if [ "$state" = activated ]; then entries+="vpn $cname: on\n"
  else entries+="vpn $cname: off\n"; fi
done < <(nmcli -t -f NAME,TYPE,STATE con show 2>/dev/null)
if command -v tailscale >/dev/null; then
  if [ "$(tailscale status --json 2>/dev/null | jq -r .BackendState)" = Running ]
  then entries+="vpn tailscale: on\n"; else entries+="vpn tailscale: off\n"; fi
fi

choice=$(printf '%b' "$entries" | "$HOME/.config/hypr/scripts/menu" --dmenu --prompt "Network" \
  --lines "$(printf '%b' "$entries" | grep -c .)" --insensitive) || exit 0

case "$choice" in
  # Picking a VPN row toggles it.
  "vpn "*": off") name=${choice#vpn }; name=${name%: off}
                 if vpn_up; then msg=connected notify; else msg="failed to connect" notify -u critical; fi ;;
  "vpn "*": on")  name=${choice#vpn }; name=${name%: on}
                 if [ "$name" = tailscale ]; then tailscale down >/dev/null 2>&1
                 else nmcli con down "$name" >/dev/null 2>&1; fi && msg=disconnected notify ;;
  "network settings"*) setsid -f foot --app-id=rice-tui-net --window-size-chars=110x32 -- nmtui >/dev/null 2>&1 </dev/null ;;
esac
pkill -RTMIN+9 waybar
