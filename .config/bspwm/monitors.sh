#!/bin/env sh

/home/alexander/.screenlayout/raskrask.sh & # Monitor layout
# if [[ "$HOST" -eq "potentilla" ]]
# then
#   bspc monitor DVI-I-1 -d 1 2 3 4 5 6 7 8 9
#   bspc monitor DVI-D-0 -d I II III
# else
  notify-send "Home sweet home"
  bspc monitor DP-0 -d 1 2 3 4 5 6 7 8 9
  bspc monitor DP-2 -d I II III
# fi

hsetroot -cover ~/Nextcloud/wallpapers/IMG_20200502_151338.jpg
