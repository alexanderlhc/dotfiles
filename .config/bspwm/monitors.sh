#!/bin/env bash

if [ "$HOSTNAME" = veronica ]; then
	bspc monitor DP-0 -d I II III
	bspc monitor DP-2 -d 1 2 3 4 5 6 7 8 9
	# hsetroot -cover ~/Nextcloud/wallpapers/IMG_20200502_151338.jpg
	hsetroot -cover ~/Downloads/taiki-ishikawa-e3aJ6LyYBHs-unsplash.jpg
elif [ "$HOSTNAME" = lighthouse ]; then
	#!/bin/sh
	xrandr --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --mode 1920x1080 --pos 1920x0 --rotate normal --output DVI-I-1-0 --off --output DVI-I-1-1 --off --output HDMI-1-0 --off --output DP-1-0 --off --output DP-1-1 --off --output DP-1-2 --off --output DP-1-3 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1-4 --off --output DP-1-5 --off
	bspc monitor DP-1-3 -d 1 2 3 4 5 6 7 8 9
	bspc monitor HDMI-2 -d I II III
	hsetroot -cover Downloads/967678.jpg
elif [ "$HOSTNAME" = fatfrogironscrap ]; then
	notify-send "fatfrogironscrap"
	bspc monitor eDP -d 1 2 3 4 5 6 7 8 9
	randomwallpaper
fi
