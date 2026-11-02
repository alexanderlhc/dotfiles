#!/bin/sh
# Tinty hook: herdr status colours. The ANSI red and orange in the foot palette are
# too close at dot size, so use the strong red and the yellow from base24.
hex() {
  eval "printf '#%s%s%s' \"\$TINTY_SCHEME_PALETTE_BASE${1}_HEX_R\" \"\$TINTY_SCHEME_PALETTE_BASE${1}_HEX_G\" \"\$TINTY_SCHEME_PALETTE_BASE${1}_HEX_B\""
}
CFG="$HOME/.config/herdr/config.toml"
sed -i '/^# tinty-begin$/,/^# tinty-end$/d' "$CFG"
{
  echo '# tinty-begin'
  echo '[theme.custom]'
  echo "red = \"$(hex 08)\""
  echo "yellow = \"$(hex 0A)\""
  echo '# tinty-end'
} >> "$CFG"
command -v herdr >/dev/null && herdr server reload-config >/dev/null 2>&1
exit 0
