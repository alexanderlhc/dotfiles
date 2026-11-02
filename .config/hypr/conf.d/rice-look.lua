-- Text-rice look. Loaded only while ~/.config/rice/flags/look exists: `rice off look`.
hl.config({
    general = {
        gaps_in = 1, gaps_out = 2, border_size = 1,
        col = { active_border = rice_accent, inactive_border = rice_inactive },
    },
    decoration = {
        rounding = 0,
        blur   = { enabled = false },
        shadow = { enabled = false },
    },
    animations = { enabled = false },
    cursor = { hide_on_key_press = true },
    misc = { force_default_wallpaper = 0, background_color = rice_bg },
})
