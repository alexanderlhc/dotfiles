---------------
-- AUTOSTART --
---------------
-- See https://wiki.hypr.land/configuring/core/autostart/
-- The old `exec-once` keyword is now the "hyprland.start" event, which fires
-- once at startup and (unlike plain exec) not again on every config reload.

hl.on("hyprland.start", function()
    -- Password prompts for admin actions. hyprpolkitagent where installed, else the KDE agent.
    hl.exec_cmd("systemctl --user start hyprpolkitagent || /usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("~/.local/bin/rice autostart") -- waybar, cursor shake

    -- veronica only: the next two need tools other machines don't have, so they check first.
    -- Bridge XEmbed tray icons (Wine/Battle.net) to StatusNotifierItem so waybar's
    -- tray can host them. Without it Wine draws its own floating systray window.
    hl.exec_cmd("command -v xembedsniproxy >/dev/null && xembedsniproxy")

    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- input-remapper's daemon starts at boot as root, before any session exists,
    -- so its autoload fails ("before a user told the service about their session
    -- using set_config_dir") and no preset is ever injected. Re-trigger it here.
    hl.exec_cmd("command -v input-remapper-control >/dev/null && input-remapper-control --command autoload")
end)
