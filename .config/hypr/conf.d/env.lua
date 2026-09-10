---------------------------
-- ENVIRONMENT VARIABLES --
---------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Electron apps: use native Wayland instead of XWayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- GTK on Wayland delegates dead-key/compose to zwp_text_input_v3, which needs a
-- running IME (ibus/fcitx). We have none, so dead keys were silently swallowed
-- in Firefox and other GTK apps. Force GTK's built-in compose engine instead.
hl.env("GTK_IM_MODULE", "simple")
