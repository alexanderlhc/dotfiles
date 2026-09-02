--------------
-- MONITORS --
--------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Fallback for any monitor not listed below
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

hl.monitor({ output = "DP-5", mode = "2560x1440@144.0", position = "1920x0", scale = 1.0 })
hl.monitor({ output = "DP-1", mode = "1920x1080@144.0", position = "0x208", scale = 1.0 })

hl.monitor({ output = "HDMI-A-1", mode = "1920x1080", position = "1920x0", scale = 1 })
hl.monitor({ output = "DP-2", mode = "1920x1080", position = "0x0", scale = 1 })
