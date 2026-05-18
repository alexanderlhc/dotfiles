#!/usr/bin/env bash
# Pop a Walker dmenu of emojis, copy the picked one to the clipboard.
# Recently used emojis are shown first.

set -euo pipefail

DATA="$HOME/.local/share/emoji-picker/emojis.txt"
CACHE_DIR="$HOME/.cache/emoji-picker"
RECENT="$CACHE_DIR/recent"
FETCHER="$(dirname "$(readlink -f "$0")")/emoji-fetch.sh"

mkdir -p "$CACHE_DIR"

if [[ ! -s "$DATA" ]]; then
    if ! "$FETCHER"; then
        notify-send "Emoji picker" "Failed to fetch emoji data — check network and rerun $FETCHER" 2>/dev/null || true
        exit 1
    fi
fi

selection=$( { cat "$RECENT" 2>/dev/null; cat "$DATA"; } \
    | awk '!seen[$1]++' \
    | walker -d -p "Emoji" )

[[ -z "$selection" ]] && exit 0

emoji=$(printf '%s' "$selection" | awk '{print $1}')
printf '%s' "$emoji" | wl-copy

{ printf '%s\n' "$selection"; cat "$RECENT" 2>/dev/null; } \
    | awk '!seen[$1]++' \
    | head -n 50 > "$RECENT.tmp" && mv "$RECENT.tmp" "$RECENT"
