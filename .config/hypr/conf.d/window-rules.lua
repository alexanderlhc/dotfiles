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
    -- WoW gets workspace 10 on the main monitor, always real fullscreen
    name       = "wow-ws10",
    match      = { class = "^wow\\.exe$", title = "^World of Warcraft$" },
    workspace  = "10",
    -- fullscreen = true, -- off 2026-10-30: suspected of crashing Hyprland 0.57
})

hl.workspace_rule({ workspace = "10", monitor = "DP-5", default_name = "gaming" })

-- Keep gaming to WoW: anything else that lands there goes to workspace 1,
-- without pulling focus off the game. Blank-class windows are XWayland helpers.
local function evict_from_gaming(window)
    if not window or not window.workspace or window.workspace.id ~= 10 then return end
    if window.class == "wow.exe" or window.class == "" then return end
    -- Menus and TUIs (hypr/scripts/menu, rice open …) are foot windows now, not
    -- wofi layer surfaces: let them open over the game instead of vanishing to ws 1.
    if window.class:match("^rice%-") then return end
    hl.dispatch(hl.dsp.window.move({ workspace = 1, follow = false, window = "address:" .. window.address }))
end

hl.on("window.open", evict_from_gaming)
hl.on("window.move_to_workspace", evict_from_gaming)
hl.on("window.class", evict_from_gaming) -- XWayland apps can set their class after opening

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
