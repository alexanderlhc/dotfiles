-- Enable lazy-loading of Lua modules
vim.loader.enable()

-- Leader
vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode("<space>")

-- Global variables
vim.g.gcolorscheme = "dawnfox"

--
require("config.lazy")

vim.cmd.colorscheme(vim.g.gcolorscheme) -- requires lazy to run first
