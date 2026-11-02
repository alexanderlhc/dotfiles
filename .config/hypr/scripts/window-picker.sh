#!/usr/bin/env bash
# Pop a wofi dmenu of open windows, type to find one, focus the picked window.
# Most recently used first; the window you're already on is left out.

set -euo pipefail

# Toggle behavior: if another wofi menu is open, close it instead of stacking.
# (if-form: a failed pkill must not trip set -e)
if pkill wofi; then exit 0; fi

# One "address<TAB>label" line per window. Titles are flattened so one window
# stays one line, keeping wofi's line number valid as an index.
windows=$(hyprctl clients -j | jq -r '
    map(select(.mapped and .focusHistoryID != 0))
    | sort_by(.focusHistoryID)[]
    | "\(.address)\t\(.workspace.name)  \(.class)  \(.title | gsub("[\\t\\n\\r]"; " "))"')

[[ -z "$windows" ]] && exit 0

# dmenu-print_line_num makes wofi print the picked line's 0-based index, so
# windows with identical titles can't be confused. Esc prints nothing.
index=$(cut -f2- <<<"$windows" \
    | wofi --dmenu -D dmenu-print_line_num=true --prompt Window --width 640 --lines 10 \
        --matching fuzzy --insensitive) || exit 0

[[ "$index" =~ ^[0-9]+$ ]] || exit 0

address=$(sed -n "$((index + 1))p" <<<"$windows" | cut -f1)
[[ -n "$address" ]] || exit 0

hyprctl dispatch "hl.dsp.focus({ window = \"address:$address\" })" >/dev/null
