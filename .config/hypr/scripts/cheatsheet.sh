#!/usr/bin/env bash
# Hyprland keybind cheatsheet, generated from `hyprctl binds`. Enter runs the selected bind.
# To change bindings, edit ~/.config/hypr/conf.d/keybindings.lua and reload.

# Toggle behavior: if another menu is open, close it instead of stacking.
"$HOME/.config/hypr/scripts/menu" --close && exit 0

# One row per submap+mods+key: a key can hold several binds (run action + leave submap).
rows=$(hyprctl binds -j | jq -r '
  def modname:
    [
      (if ((. / 64) | floor) % 2 == 1 then "SUPER" else empty end),
      (if ((. /  4) | floor) % 2 == 1 then "CTRL"  else empty end),
      (if ((. /  8) | floor) % 2 == 1 then "ALT"   else empty end),
      (if  (. % 2)            == 1   then "SHIFT" else empty end)
    ] | join("+");

  to_entries
  | group_by([.value.submap, .value.modmask, .value.key])
  | map({
      order: (map(.key) | min),
      bind: .[0].value,
      description: (map(.value.description | select(. != "")) | first // "⚠ no description -- add one in keybindings.lua")
    })
  | sort_by(.order)
  | .[]
  | (.bind.modmask | modname) as $mods
  | (if $mods == "" then "" else $mods + " + " end) as $prefix
  | (if .bind.submap != "" then "[" + .bind.submap + "] " else "" end) as $ctx
  | "\(.bind.submap)|\(.bind.modmask)|\(.bind.key)\t\($ctx)\($prefix)\(.bind.key)\t\(.description)"
')

mapfile -t ids < <(cut -f1 <<<"$rows")
menu=$(cut -f2- <<<"$rows" | column -t -s $'\t')

choice=$("$HOME/.config/hypr/scripts/menu" --dmenu --prompt Keys --width 700 --lines 15 --matching fuzzy --insensitive <<<"$menu") || exit 0
line=$(grep -nFx -- "$choice" <<<"$menu" | head -n1 | cut -d: -f1)
[[ -n $line ]] || exit 0

# Let the menu window go and focus return, so the bind acts on the window behind it
# and a screenshot doesn't catch the menu.
sleep 0.25
hyprctl dispatch "cheatsheet_run([==[${ids[line - 1]}]==])"
