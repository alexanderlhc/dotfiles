local g = vim.g
local o = vim.opt

o.number = true -- line numbers
o.signcolumn = "yes" -- diagnostics in number column
o.numberwidth = 5 -- min width for number column (default: 4)
o.ignorecase = true -- ignore case
o.smartcase = true -- ignore case unless contain mixed
o.lazyredraw = true -- disable redraw during macro and cmds (speed)
o.tabstop = 2 -- tab takes 2 spaces
o.shiftwidth = 2 -- spaces used for (auto)indent
o.expandtab = true -- tabs to spaces
o.autoindent = true -- use current line indent
o.splitright = true -- splits go right
o.mouse = "nvi" -- mouse in: normal, visual, insert
o.syntax = "on"
o.shell = "/bin/bash"

vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
