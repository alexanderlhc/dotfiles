#!/usr/bin/env bash
# Pop a wofi dmenu of open windows, type to find one, focus the picked window.
# Most recently used first; the window you're already on is left out.

set -euo pipefail

# Toggle behavior: if another wofi menu is open, close it instead of stacking.
# (if-form: a failed pkill must not trip set -e)
if pkill wofi; then exit 0; fi

# One "address<TAB>pango label" line per window: workspace, class, title in
# aligned columns. Titles are flattened so one window stays one line, keeping
# wofi's line number valid as an index.
windows=$(hyprctl clients -j | jq -r '
    def esc: gsub("&"; "&amp;") | gsub("<"; "&lt;") | gsub(">"; "&gt;");
    def pad($n): . + (" " * ([$n - length, 0] | max));
    def clip($n): if length > $n then .[0:$n - 1] + "…" else . end;
    map(select(.mapped and .focusHistoryID != 0))
    | sort_by(.focusHistoryID)[]
    | "\(.address)\t<span alpha=\"55%\">\(.workspace.name | clip(3) | pad(3))</span> <b>\(.class | clip(14) | pad(14) | esc)</b>  <span alpha=\"75%\">\(.title | gsub("[\\t\\n\\r]"; " ") | clip(56) | esc)</span>"')

[[ -z "$windows" ]] && exit 0

# dmenu-print_line_num makes wofi print the picked line's 0-based index, so
# windows with identical titles can't be confused. Esc prints nothing.
# Not fuzzy: wofi matches against the raw markup, whose letters would hit every row.
count=$(wc -l <<<"$windows")
index=$(cut -f2- <<<"$windows" \
    | wofi --dmenu -D dmenu-print_line_num=true --allow-markup --prompt Window --width 720 \
        --lines $((count < 10 ? count : 10)) --matching multi-contains --insensitive) || exit 0

[[ "$index" =~ ^[0-9]+$ ]] || exit 0

address=$(sed -n "$((index + 1))p" <<<"$windows" | cut -f1)
[[ -n "$address" ]] || exit 0

hyprctl dispatch "hl.dsp.focus({ window = \"address:$address\" })" >/dev/null
