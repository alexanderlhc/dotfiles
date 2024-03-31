#!/usr/bin/env bash

CONFIG="$HOME/.config/wofi/config"
STYLE="$HOME/.config/wofi/catppuccin.latte.css"

# optionally takes in args

if [[ ! $(pidof wofi) ]]; then
	wofi --conf "${CONFIG}" --style "${STYLE}" "$@"
else
	pkill wofi
fi
