#!/bin/sh
# Tinty hook: generate fuzzel config from base24 palette

hex() {
  eval "printf '%s%s%s' \"\$TINTY_SCHEME_PALETTE_BASE${1}_HEX_R\" \"\$TINTY_SCHEME_PALETTE_BASE${1}_HEX_G\" \"\$TINTY_SCHEME_PALETTE_BASE${1}_HEX_B\""
}

BG=$(hex 00)
FG=$(hex 05)
BLUE=$(hex 0D)
SEL=$(hex 02)
UI=$(hex 03)
COM=$(hex 04)

OUT="$HOME/.config/fuzzel/fuzzel.ini"

cat > "$OUT" << FUZZEL
[main]
font=MonoLisa:size=13
prompt="❯ "
layer=overlay
lines=12
width=45
horizontal-pad=12
vertical-pad=8
inner-pad=4

[colors]
background=${BG}ff
text=${FG}ff
match=${BLUE}ff
selection=${SEL}ff
selection-text=${FG}ff
selection-match=${BLUE}ff
border=${UI}ff
counter=${COM}ff

[border]
width=2
radius=8
FUZZEL
