#!/usr/bin/env bash
# Hyprland keybind cheatsheet, generated from `hyprctl binds`.
# To change bindings, edit ~/.config/hypr/conf.d/keybindings.lua and reload.
# (The .conf next to it is a legacy export -- Hyprland does not read it.)

# Toggle behavior: if another wofi menu is open, close it instead of stacking.
pkill wofi && exit 0

hyprctl binds -j | jq -r '
  def modname:
    [
      (if ((. / 64) | floor) % 2 == 1 then "SUPER" else empty end),
      (if ((. /  4) | floor) % 2 == 1 then "CTRL"  else empty end),
      (if ((. /  8) | floor) % 2 == 1 then "ALT"   else empty end),
      (if  (. % 2)            == 1   then "SHIFT" else empty end)
    ] | join("+");

  .[]
  | select(.mouse == false)
  | (.modmask | modname) as $mods
  | (if $mods == "" then "" else $mods + " + " end) as $prefix
  | (if .description != "" then .description
       else (.dispatcher + (if .arg != "" then " " + .arg else "" end))
     end) as $action
  | (if .submap != "" then "[" + .submap + "] " else "" end) as $ctx
  | "\($ctx)\($prefix)\(.key)\t\($action)"
' | column -t -s $'\t' \
  | wofi --dmenu --prompt Keys --width 700 --lines 15 --matching fuzzy --insensitive
