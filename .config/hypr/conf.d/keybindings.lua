-----------------
-- KEYBINDINGS --
-----------------
-- See https://wiki.hypr.land/configuring/core/binds/
-- `programs` is the table returned by conf.d/programs.lua, passed in by hyprland.lua.
local programs = ...

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Shadow hl.bind so every bind is also recorded for the cheatsheet (mainMod + F1),
-- which runs the selected row through cheatsheet_run(id). No key injection needed.
-- `replay = false` keeps a bind out of it: listed, but Enter won't fire it.
local real = hl
local MODMASK = { SHIFT = 1, CTRL = 4, ALT = 8, SUPER = 64 } -- same bits as `hyprctl binds`
local actions, currentSubmap = {}, ""

local function bind_id(keys)
    local parts = {}
    for part in keys:gmatch("[^+%s]+") do table.insert(parts, part) end
    local mask = 0
    for i = 1, #parts - 1 do mask = mask + (MODMASK[parts[i]] or 0) end
    return currentSubmap .. "|" .. mask .. "|" .. parts[#parts]
end

local hl = setmetatable({
    bind = function(keys, action, opts)
        local passthrough = {}
        for k, v in pairs(opts or {}) do
            if k ~= "replay" then passthrough[k] = v end
        end
        if not passthrough.mouse and not (opts and opts.replay == false) then
            local id = bind_id(keys)
            actions[id] = actions[id] or {}
            table.insert(actions[id], action)
        end
        return real.bind(keys, action, passthrough)
    end,
    define_submap = function(name, fn)
        currentSubmap = name
        real.define_submap(name, fn)
        currentSubmap = ""
    end,
}, { __index = real })

function _G.cheatsheet_run(id)
    return function()
        if not actions[id] then
            real.dispatch(real.dsp.exec_cmd("notify-send 'Cheatsheet' 'That bind can only be pressed, not run from here'"))
            return
        end
        for _, action in ipairs(actions[id]) do real.dispatch(action) end
    end
end

-- Toggle between current and previous workspace with mainMod + Tab
hl.config({
    binds = {
        allow_workspace_cycles = true,
    },
})

-- Show keybind cheatsheet (auto-generated from these binds via `hyprctl binds`)
hl.bind(mainMod .. " + F1",     hl.dsp.exec_cmd("~/.config/hypr/scripts/cheatsheet.sh"),   { description = "Show keybind cheatsheet" })
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("~/.config/hypr/scripts/emoji-picker.sh"), { description = "Open emoji picker" })

-- Plain Alt+Tab fallback. hyprshell replaces these binds whenever its service runs.
-- Cycles every workspace: the built-in cycle_next only covers the current one.
local function cycle_window(next)
    return function()
        local windows = {}
        for _, w in ipairs(hl.get_windows()) do
            if w.mapped and not w.workspace.special then table.insert(windows, w) end
        end
        if #windows < 2 then return end
        table.sort(windows, function(a, b)
            if a.workspace.id ~= b.workspace.id then return a.workspace.id < b.workspace.id end
            return a.address < b.address
        end)

        local active, current = hl.get_active_window(), 0
        for i, w in ipairs(windows) do
            if active and w.address == active.address then current = i end
        end
        local target = next and current % #windows + 1 or (current - 2) % #windows + 1
        hl.dispatch(hl.dsp.focus({ window = "address:" .. windows[target].address }))
        hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
    end
end
hl.bind("ALT + Tab",         cycle_window(true),  { description = "Next window" })
hl.bind("ALT + SHIFT + Tab", cycle_window(false), { description = "Previous window" })

hl.bind(mainMod .. " + G",      hl.dsp.exec_cmd("~/.config/hypr/scripts/window-picker.sh"), { description = "Find and focus an open window" })
hl.bind(mainMod .. " + Q",      hl.dsp.window.close(),                       { description = "Kill active window" })
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(programs.terminal),          { description = "Open terminal" })
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd(programs.clipboardMenu),     { description = "Open clipboard menu" })
hl.bind(mainMod .. " + M",      hl.dsp.exec_cmd("~/.config/waybar/scripts/power-menu.sh"),
                                                                             { description = "Power menu (logout, reboot, power off)", replay = false })
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(programs.fileManager),       { description = "Open file manager" })
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }),  { description = "Toggle floating window" })
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.pin({ action = "toggle" }), { description = "Pin floating window (sticky on all workspaces)" })
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(programs.menu),              { description = "Open app launcher" })
hl.bind(mainMod .. " + P",      hl.dsp.exec_cmd(programs.rbwMenu),           { description = "Open password menu" })
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen(),                  { description = "Toggle fullscreen" })

hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("~/.local/bin/rice open net"),   { description = "Network" })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("~/.local/bin/rice open bt"),    { description = "Bluetooth" })
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("~/.local/bin/rice open audio"), { description = "Audio" })
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("~/.local/bin/rice open calc"),  { description = "Calculator" })
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exec_cmd("~/.config/waybar/scripts/power-menu.sh"), { description = "Power menu", replay = false })

-- Move focus with mainMod + arrow keys, and with vim keys
local directions = {
    { key = "left",  vim = "h", dir = "l", label = "left"  },
    { key = "down",  vim = "j", dir = "d", label = "down"  },
    { key = "up",    vim = "k", dir = "u", label = "up"    },
    { key = "right", vim = "l", dir = "r", label = "right" },
}

for _, d in ipairs(directions) do
    hl.bind(mainMod .. " + " .. d.key, hl.dsp.focus({ direction = d.dir }),
        { description = "Focus window " .. d.label })
    hl.bind(mainMod .. " + " .. d.vim, hl.dsp.focus({ direction = d.dir }),
        { description = "Focus window " .. d.label })
    -- Move active window with mainMod + SHIFT + vim keys
    hl.bind(mainMod .. " + SHIFT + " .. d.vim, hl.dsp.window.move({ direction = d.dir }),
        { description = "Move window " .. d.label })
end

-- Scrolling layout (general.layout = "scrolling" in look-and-feel.lua)
hl.bind(mainMod .. " + CTRL + h",     hl.dsp.layout("swapcol l"),             { description = "Swap column left" })
hl.bind(mainMod .. " + CTRL + l",     hl.dsp.layout("swapcol r"),             { description = "Swap column right" })
hl.bind(mainMod .. " + bracketleft",  hl.dsp.layout("consume_or_expel prev"), { description = "Stack window into left column / pop it out" })
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("consume_or_expel next"), { description = "Stack window into right column / pop it out" })
hl.bind(mainMod .. " + minus",        hl.dsp.layout("colresize -conf"),       { description = "Narrower column (preset widths)" })
hl.bind(mainMod .. " + equal",        hl.dsp.layout("colresize +conf"),       { description = "Wider column (preset widths)" })
hl.bind(mainMod .. " + W",            hl.dsp.layout("fit visible"),           { description = "Share screen evenly between visible columns" })
hl.bind(mainMod .. " + SHIFT + W",    hl.dsp.layout("center"),                { description = "Center focused column" })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }),
        { description = "Switch to workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }),
        { description = "Move window to workspace " .. i })
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"),                 { description = "Toggle scratchpad" })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }),      { description = "Move window to scratchpad" })

hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "previous" }), { description = "Toggle previous workspace" })

-- Scroll sideways along the scrolling-layout tape with mainMod + scroll
-- (tilt/horizontal wheel does the same)
hl.bind(mainMod .. " + mouse_down",  hl.dsp.focus({ direction = "r" }), { description = "Focus window right" })
hl.bind(mainMod .. " + mouse_up",    hl.dsp.focus({ direction = "l" }), { description = "Focus window left" })
hl.bind(mainMod .. " + mouse_right", hl.dsp.focus({ direction = "r" }), { description = "Focus window right" })
hl.bind(mainMod .. " + mouse_left",  hl.dsp.focus({ direction = "l" }), { description = "Focus window left" })

-- Scroll through existing workspaces with mainMod + SHIFT + scroll
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Switch to next workspace" })
hl.bind(mainMod .. " + SHIFT + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { description = "Switch to previous workspace" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true, description = "Drag to move window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Drag to resize window" })

-- Laptop multimedia keys for volume and LCD brightness
local function el(description) return { locked = true, repeating = true, description = description } end -- was bindel
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), el("Raise volume"))
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      el("Lower volume"))
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     el("Mute speakers"))
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   el("Mute microphone"))
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  el("Raise brightness"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  el("Lower brightness"))

-- Requires playerctl
local function l(description) return { locked = true, description = description } end -- was bindl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       l("Next track"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), l("Play / pause"))
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), l("Play / pause"))
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   l("Previous track"))

-- Screenshots (PrintScreen submap) — grim | satty: annotate, copy, save
local satty = [[satty -f - --output-filename ~/Pictures/Screenshots/$(date +%F-%T).png --early-exit --copy-command wl-copy]]

hl.bind("Print", hl.dsp.submap("screenshot"), { description = "Enter screenshot mode (A=all P=region)" })

hl.define_submap("screenshot", function()
    hl.bind("A", hl.dsp.exec_cmd("grim - | " .. satty), { description = "Screenshot full screen" })
    hl.bind("A", hl.dsp.submap("reset"))
    hl.bind("P", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | ]] .. satty), { description = "Screenshot a region" })
    hl.bind("P", hl.dsp.submap("reset"))
    hl.bind("Escape", hl.dsp.submap("reset"), { description = "Exit screenshot mode" })
    hl.bind("Return", hl.dsp.submap("reset"), { description = "Exit screenshot mode" })
end)

-- Lock screen
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("hyprlock"), { description = "Lock screen" })

-- Dictation — tap to record, tap again to transcribe & type.
-- Deliberately a press-only toggle: a `release = true` bind never fires when
-- the modifier is lifted before the key, which made hold-to-talk unreliable.
hl.bind(mainMod .. " + D",         hl.dsp.exec_cmd("~/.local/bin/whisper-ptt toggle"),
                                                 { description = "Dictate / whisper speech-to-text (tap to start, tap to stop)" })
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("~/.local/bin/whisper-ptt cancel"),
                                                 { description = "Cancel dictation / whisper speech-to-text" })
hl.bind(mainMod .. " + CTRL + D",  hl.dsp.exec_cmd("~/.local/bin/whisper-ptt lang"),
                                                 { description = "Switch dictation language (English / Danish)" })

-- Read aloud — the mirror of dictation: speaks the clipboard, tap again to stop.
hl.bind(mainMod .. " + A",         hl.dsp.exec_cmd("~/.local/bin/speak-clip toggle"),
                                                 { description = "Read clipboard aloud / piper text-to-speech (tap to start, tap to stop)" })
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("~/.local/bin/speak-clip stop"),
                                                 { description = "Stop reading aloud" })
