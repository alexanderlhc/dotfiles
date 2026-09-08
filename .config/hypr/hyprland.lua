-- Hyprland config — split into conf.d/, see https://wiki.hypr.land/Configuring/
--
-- Migrated from the legacy hyprlang (.conf) format, which Hyprland is dropping.
-- The old .conf files are kept alongside these as a frozen escape hatch, not a
-- maintained mirror: Hyprland only reads hyprland.lua if it exists, so renaming
-- this file away falls straight back to the snapshot in hyprland.conf.
-- Edit the .lua files; the .conf ones deliberately drift and can be deleted
-- once this config has proven itself (see the header in hyprland.conf).
--
-- Fragments are pulled in with loadfile() rather than require() on purpose:
--   * require() would choke on the dot in the "conf.d" directory name
--   * require() caches modules, which would stop tinty theme switches from
--     taking effect on `hyprctl reload`
-- Each fragment can take arguments and return a value, like a normal function.

local dir = debug.getinfo(1, "S").source:match("@(.*/)")

local function load(name, ...)
    local chunk, err = loadfile(dir .. name)
    if not chunk then
        error("hyprland.lua: could not load " .. name .. ": " .. tostring(err), 0)
    end
    return chunk(...)
end

load("conf.d/monitors.lua")
local programs = load("conf.d/programs.lua")
load("conf.d/autostart.lua")
load("conf.d/env.lua")
load("conf.d/look-and-feel.lua")
load("themes/current.lua") -- after look-and-feel: tinty's colors win
load("conf.d/input.lua")
load("conf.d/keybindings.lua", programs)
load("conf.d/window-rules.lua")
