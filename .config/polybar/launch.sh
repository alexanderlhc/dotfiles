#!/usr/bin/env bash

# Terminate already running bar instances
# killall -q polybar

# # Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# (sleep 2; polybar topleft) &
# (sleep 2; polybar topcenter) &
# (sleep 2; polybar topright) &
#(sleep 2; polybar tray) &

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch bar1 and bar2
# logdir=~/.cache/polybar
# echo "---" | tee -a $logdir/polybar-topleft.log $logdir/polybar-topright.log $logdir/polybar-topcenter.log
# polybar topleft 2>&1 | tee -a /tmp/polybar-topleft.log & disown
# polybar topcenter 2>&1 | tee -a /tmp/polybar-topcenter.log & disown
# polybar topright 2>&1 | tee -a /tmp/polybar-topright.log & disown

# echo "Bars launched..."

screens=$(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f6)
monitorCount=$(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f4 | cut -d"+" -f2- | uniq | wc -l)

if [[ $monitorCount == 1 ]]; then
  MONITOR=$(polybar --list-monitors | cut -d":" -f1) TRAY_POS=right polybar main &
else
  primary=$(xrandr --listactivemonitors | grep "\*" | cut -d" " -f6)

  for m in $screens; do
    if [[ "$primary" == "$m" ]]; then
      MONITOR=$m polybar topcenter 2>&1 | tee -a /tmp/polybar-topcenter.log &
      disown
      MONITOR=$m polybar topright 2>&1 | tee -a /tmp/polybar-topright.log &
      disown
      MONITOR=$m polybar topleft 2>&1 | tee -a /tmp/polybar-topleft.log &
      disown
    else
      MONITOR=$m polybar topleft-mon2 2>&1 | tee -a /tmp/polybar-topleft.log &
      disown
    fi
  done
fi
