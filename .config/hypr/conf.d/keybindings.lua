-----------------
-- KEYBINDINGS --
-----------------
-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- `programs` is the table returned by conf.d/programs.lua, passed in by hyprland.lua.
local programs = ...

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Toggle between current and previous workspace with mainMod + Tab
hl.config({
    binds = {
        allow_workspace_cycles = true,
    },
})

-- Show keybind cheatsheet (auto-generated from these binds via `hyprctl binds`)
hl.bind(mainMod .. " + F1",     hl.dsp.exec_cmd("~/.config/hypr/scripts/cheatsheet.sh"),   { description = "Show keybind cheatsheet" })
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("~/.config/hypr/scripts/emoji-picker.sh"), { description = "Open emoji picker" })

hl.bind(mainMod .. " + Q",      hl.dsp.window.close(),                       { description = "Kill active window" })
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(programs.terminal),          { description = "Open terminal" })
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd(programs.clipboardMenu),     { description = "Open clipboard menu" })
hl.bind(mainMod .. " + M",      hl.dsp.exec_cmd([[command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()']]),
                                                                             { description = "Logout / exit Hyprland" })
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(programs.fileManager),       { description = "Open file manager" })
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }),  { description = "Toggle floating window" })
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(programs.menu),              { description = "Open app launcher" })
hl.bind(mainMod .. " + P",      hl.dsp.exec_cmd(programs.rbwMenu),           { description = "Open password menu" })
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen(),                  { description = "Toggle fullscreen" })

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

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Switch to next workspace" })
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { description = "Switch to previous workspace" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
local el = { locked = true, repeating = true } -- was bindel
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), el)
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      el)
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     el)
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   el)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  el)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  el)

-- Requires playerctl
local l = { locked = true } -- was bindl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       l)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), l)
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), l)
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   l)

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
