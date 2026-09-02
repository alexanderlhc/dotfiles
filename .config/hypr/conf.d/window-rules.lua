------------------------------
-- WINDOWS AND WORKSPACES --
------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name      = "battlenet-ws8",
    match     = { class = "steam_proton", title = "Battle.net" },
    workspace = "8",
})

hl.window_rule({
    name      = "wow-ws9",
    match     = { class = "steam_proton", title = "World of Warcraft" },
    workspace = "9",
})

hl.window_rule({
    name      = "bottles-ws8",
    match     = { class = "com.usebottles.bottles" },
    workspace = "8",
})
