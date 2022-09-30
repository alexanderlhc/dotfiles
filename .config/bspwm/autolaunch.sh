#!/bin/env sh

notify-send "Autolaunching applications"

pgrep -x sxhkd > /dev/null || sxhkd &
pgrep -x nm-applet > /dev/null || nm-applet &
pgrep -x picom > /dev/null || picom &
pgrep -x greenclip > /dev/null || greenclip daemon &
pgrep -x nextcloud > /dev/null || nextcloud &
pgrep -x redshift > /dev/null || redshift -l "$(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | jq '.location.lat, .location.lng' | tr '\n' ':' | sed 's/:$//')" &
~/.config/polybat/launch.sh &
