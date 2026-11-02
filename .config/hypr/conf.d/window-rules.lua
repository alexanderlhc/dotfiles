------------------------------
-- WINDOWS AND WORKSPACES --
------------------------------
-- See https://wiki.hypr.land/configuring/core/rules/window-rules/
-- and https://wiki.hypr.land/configuring/core/rules/workspace-rules/

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

-- foot + fzf menus (hypr/scripts/menu): float, size comes from foot's --window-size-chars.
hl.window_rule({
    name   = "rice-menu",
    match  = { class = "^rice-(menu|tui-.*)$" },
    float  = true,
    center = true,
})

-- Calculator lives on its own scratchpad so Super+X hides it without ending the session.
hl.window_rule({
    name      = "rice-calc",
    match     = { class = "^rice-tui-calc$" },
    workspace = "special:calc",
})
