-----------------
-- MY PROGRAMS --
-----------------
-- Returned to hyprland.lua, which passes this table on to keybindings.lua.
-- Long strings use [[...]] so shell quoting and \n reach the shell verbatim.

return {
    terminal      = "foot",
    fileManager   = "nautilus",
    menu          = [[sh -c "pkill wofi || wofi --show drun --allow-images --prompt Run --width 480 --lines 10 --matching fuzzy --insensitive"]],
    clipboardMenu = [[sh -c "pkill wofi || cliphist list | wofi --dmenu --prompt Clipboard --width 640 --lines 12 --matching fuzzy --insensitive | cliphist decode | wl-copy"]],
    rbwMenu       = [[sh -c "pkill wofi || rbw list | wofi --dmenu --prompt Passwords --width 420 --lines 10 --matching fuzzy --insensitive | xargs -r -d '\n' rbw get | wl-copy --trim-newline"]],
}
