#!/bin/env bash

if [ "$HOSTNAME" = veronica ]; then
  bspc monitor DP-0 -d I II III
  bspc monitor DP-2 -d 1 2 3 4 5 6 7 8 9
  # hsetroot -cover ~/Nextcloud/wallpapers/IMG_20200502_151338.jpg
  hsetroot -cover ~/Downloads/taiki-ishikawa-e3aJ6LyYBHs-unsplash.jpg
elif [ "$HOSTNAME" = lighthouse ]; then
  bspc monitor HDMI-0 -d I II III
  bspc monitor DP-3 -d 1 2 3 4 5 6 7 8 9
else
fi
