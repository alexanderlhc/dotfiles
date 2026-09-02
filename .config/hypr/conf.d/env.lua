---------------------------
-- ENVIRONMENT VARIABLES --
---------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Electron apps: use native Wayland instead of XWayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
