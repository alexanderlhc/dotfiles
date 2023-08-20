vim.g.mapleader = " "
require("config.autocmds")
require("config.usercmds")
require("config.initialize")
require("config.options")
require("config.keymaps")

vim.cmd([[colorscheme catppuccin]])
vim.cmd([[set background=light]])
--require("config")
--require("impatient")
--require("plugins").setup()
