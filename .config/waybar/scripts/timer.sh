#!/usr/bin/env bash
# Waybar custom module: a plain countdown, used as pomodoro / stand-up nudge.
# Usage: timer.sh <name> <minutes> <icon> <auto|manual> [click]
#   auto    starts itself, click restarts — a reminder that always runs
#   manual  idle until clicked; click pauses/resumes, so state must be visible
#   click   handle a left click — bind this to on-click
#   reset   back to idle (auto mode then starts a fresh cycle) — on-click-right
# Text stays narrow: whole minutes until the final minute, then mm:ss.
set -euo pipefail

name=$1
minutes=$2
icon=$3
mode=$4
action=${5:-status}

dir="${XDG_RUNTIME_DIR:-/tmp}/waybar-timers"
mkdir -p "$dir"
state="$dir/$name"

# State file, one line, three shapes:
#   (absent)               idle
#   <end epoch> <rang 0|1> running (or, past the end, rang)
#   paused <seconds left>  paused
# "rang" keeps the alert to once instead of every tick.
start() { printf '%s 0\n' "$(( $(date +%s) + minutes * 60 ))" >"$state"; }
resume() { printf '%s 0\n' "$(( $(date +%s) + $1 ))" >"$state"; }
pause() { printf 'paused %s\n' "$1" >"$state"; }
stop() { rm -f "$state"; }

# Echoes: idle | paused <left> | <left>   (left may be <= 0 = rang)
read_state() {
  [ -s "$state" ] || { echo idle; return; }
  read -r a b <"$state"
  if [ "$a" = paused ]; then
    echo "paused $b"
  else
    echo $(( a - $(date +%s) ))
  fi
}

fmt() { # seconds -> compact countdown
  if [ "$1" -ge 60 ]; then printf '%dm' $(( ($1 + 59) / 60 ))
  else printf '0:%02d' "$1"; fi
}

[ "$action" = reset ] && { stop; exit 0; }

if [ "$action" = click ]; then
  set -- $(read_state)
  case "$1" in
    idle) start ;;
    paused) resume "$2" ;;
    -*|0) start ;;                                       # rang -> fresh cycle
    *) [ "$mode" = manual ] && pause "$1" || start ;;     # running -> pause / restart
  esac
  exit 0
fi

[ -s "$state" ] || [ "$mode" = manual ] || start
set -- $(read_state)

case "$1" in
  idle)
    printf '{"text":"%s ▶","tooltip":"%s — click to start %s min","class":"idle"}\n' \
      "$icon" "$name" "$minutes"
    ;;
  paused)
    printf '{"text":"%s ⏸ %s","tooltip":"%s — paused · click resume · right-click reset","class":"paused"}\n' \
      "$icon" "$(fmt "$2")" "$name"
    ;;
  -*|0)
    read -r end rang <"$state"
    if [ "${rang:-0}" = 0 ]; then
      notify-send -u critical "$name" "Time's up"
      printf '%s 1\n' "$end" >"$state"
    fi
    printf '{"text":"%s 0:00","tooltip":"%s — rang · click restart · right-click reset","class":"expired"}\n' \
      "$icon" "$name"
    ;;
  *)
    read -r end _ <"$state"
    printf '{"text":"%s %s","tooltip":"%s — done %s · click pause · right-click reset","class":"running"}\n' \
      "$icon" "$(fmt "$1")" "$name" "$(date -d "@$end" +%H:%M)"
    ;;
esac
