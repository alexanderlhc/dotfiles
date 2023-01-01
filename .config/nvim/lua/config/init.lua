require("config.styles")
local g = vim.g

vim.opt.numberwidth = 5 -- min width for number column (default: 4)
vim.opt.ignorecase = true -- ignore case
vim.opt.smartcase = true -- ignore case unless contain mixed
vim.opt.lazyredraw = true -- disable redraw during macro and cmds (speed)
vim.opt.tabstop = 2 -- tab takes 2 spaces
vim.opt.shiftwidth = 2 -- spaces used for (auto)indent
vim.opt.expandtab = true -- tabs to spaces
vim.opt.autoindent = true -- use current line indent
vim.opt.splitright = true -- splits go right
vim.opt.mouse = "nvi" -- mouse in: normal, visual, insert
vim.opt.syntax = "on"
vim.opt.shell = "/bin/bash"

vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "

-- folding
vim.opt.foldlevel = 1
vim.opt.foldmethod = "expr" -- TreeSitter folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- TreeSitter folding

-- commands
-- use :bwipeout
-- vim.api.nvim_create_user_command("BuffClear", ':%bdelete|edit #|normal `"', { desc = "Deletes all but current buffer" })
