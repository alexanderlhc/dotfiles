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
logdir=~/.cache/polybar
echo "---" | tee -a $logdir/polybar-topleft.log $logdir/polybar-topright.log $logdir/polybar-topcenter.log
polybar topleft 2>&1 | tee -a /tmp/polybar-topleft.log & disown
polybar topcenter 2>&1 | tee -a /tmp/polybar-topcenter.log & disown
polybar topright 2>&1 | tee -a /tmp/polybar-topright.log & disown

echo "Bars launched..."
