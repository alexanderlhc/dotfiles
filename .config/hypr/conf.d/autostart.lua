---------------
-- AUTOSTART --
---------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- The old `exec-once` keyword is now the "hyprland.start" event, which fires
-- once at startup and (unlike plain exec) not again on every config reload.

hl.on("hyprland.start", function()
    hl.exec_cmd("nm-applet")

    -- Bring up xdg-desktop-portal (needed by flameshot/screenshare).
    -- graphical-session.target never activates when Hyprland is launched directly,
    -- so import the env and start the portal ignoring that dead dependency.
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd(
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE && " ..
        "systemctl --user start --job-mode=ignore-dependencies xdg-desktop-portal.service"
    )

    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("mako")
    hl.exec_cmd("waybar")

    -- Bridge XEmbed tray icons (Wine/Battle.net) to StatusNotifierItem so waybar's
    -- tray can host them. Without it Wine draws its own floating systray window.
    hl.exec_cmd("xembedsniproxy")

    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- input-remapper's daemon starts at boot as root, before any session exists,
    -- so its autoload fails ("before a user told the service about their session
    -- using set_config_dir") and no preset is ever injected. Re-trigger it here.
    hl.exec_cmd("input-remapper-control --command autoload")
end)
