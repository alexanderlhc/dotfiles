#!/bin/sh
# Master hook: runs all custom theme hooks
dir="$(dirname "$0")"
sh "$dir/tmux.sh"
sh "$dir/waybar.sh"
sh "$dir/hyprland.sh"
sh "$dir/sway.sh"
sh "$dir/rofi.sh"
