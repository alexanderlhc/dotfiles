local g = vim.g
local opt = vim.opt

g.mapleader = " "

-- opt.clipboard = "unnamedplus"                -- allow neovim to access the system clipboard

-- search
opt.hlsearch = true   -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true  -- smart case

--  tabs
opt.shiftwidth = 0 -- used by ><. 0 means use tabstop
opt.tabstop = 2 -- spaces tab counts for

-- ui
opt.lazyredraw = true -- don"t update the display while executing macros

opt.cmdheight = 0 -- Hide cmd line

opt.mouse = "a"        -- allow the mouse to be used in neovim
opt.number = true      -- set numbered lines
opt.scrolloff = 18     -- minimal number of screen lines to keep above and below the cursor
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time

-- perfomance
-- remember N lines in history
opt.history = 100    -- keep 100 lines of history
opt.redrawtime = 1500
opt.timeoutlen = 250 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.ttimeoutlen = 10
opt.updatetime = 100 -- signify default updatetime 4000ms is not good for async update

-- theme
opt.termguicolors = true -- enable 24-bit RGB colors

-- persistent undo
local undodir = vim.fn.stdpath("data") .. "/undo"
opt.undofile = true -- enable persistent undo
opt.undodir = undodir
opt.undolevels = 1000
opt.undoreload = 10000

-- Disable builtin plugins
local disabled_built_ins = {
    "2html_plugin", "getscript", "getscriptPlugin", "gzip", "logipat", "netrw", "netrwPlugin",
    "netrwSettings", "netrwFileHandlers", "matchit", "tar", "tarPlugin", "rrhelper",
    "spellfile_plugin", "vimball", "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin",
    "synmenu", "optwin", "compiler", "bugreport", "ftplugin"
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end



require("config.keymaps")
require("config.lazy")
