#!/usr/bin/env bash
# Download and parse the Unicode emoji list into a flat <emoji>  <name> file.
# Skin-tone variants (codepoints U+1F3FB..U+1F3FF) are filtered out.
# Re-run this script to refresh the cache (e.g. after a new Unicode release).

set -euo pipefail

OUT_DIR="$HOME/.local/share/emoji-picker"
OUT="$OUT_DIR/emojis.txt"
URL="${EMOJI_URL:-https://unicode.org/Public/emoji/16.0/emoji-test.txt}"

mkdir -p "$OUT_DIR"

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

if ! curl -fsSL "$URL" -o "$tmp"; then
    echo "Failed to download $URL" >&2
    exit 1
fi

awk '
/; fully-qualified/ {
    codepoints = $0
    sub(/;.*/, "", codepoints)
    if (codepoints ~ /1F3F[B-F]/) next

    n = index($0, "#")
    if (n == 0) next
    rest = substr($0, n + 2)

    split(rest, a, " ")
    emoji = a[1]
    name = a[3]
    for (i = 4; a[i] != ""; i++) name = name " " a[i]

    if (emoji != "" && name != "") print emoji "  " name
}
' "$tmp" > "$OUT"

count=$(wc -l < "$OUT")
echo "Wrote $count emojis to $OUT" >&2
