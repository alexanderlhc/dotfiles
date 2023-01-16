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
-- Handled by ufo
-- vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.opt.foldcolumn = "5" -- '0' is not badufo
-- vim.opt.foldnestmax = 1 -- must be equal to foldcolumn to avoid showing odd numbers
-- vim.opt.foldenable = true
-- vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.opt.foldlevelstart = 99
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.statuscolumn = "%= "
	.. "%s" -- sign column FIXME: figure out how to put on the other side without having to do a lot of shifting
	.. "%{%" -- evaluate this, and then evaluate what it returns
	.. "&number ?"
	.. "(v:relnum ?"
	.. 'printf("%"..len(line("$")).."s", v:relnum)' -- when showing relative numbers, make sure to pad so things don't shift as you move the cursor
	.. ":"
	.. "v:lnum"
	.. ")"
	.. ":"
	.. '""'
	.. " " -- space between lines and fold
	.. "%}"
	.. "%= "
	.. "%#FoldColumn#" -- highlight group for fold
	.. "%{" -- expression for showing fold expand/colapse
	.. "foldlevel(v:lnum) > foldlevel(v:lnum - 1)" -- any folds?
	.. "? (foldclosed(v:lnum) == -1" -- currently open?
	.. '? ""' -- point down
	.. ':  ""' -- point to right
	.. ")"
	.. ': " "' -- blank for no fold, or inside fold
	.. "}"
	.. "%= " -- spacing between end of column and start of text
-- vim.o.statuscolumn = "%=%l%s%C"
-- vim.opt.signcolumn = "yes"

-- commands
-- use :bwipeout
-- vim.api.nvim_create_user_command("BuffClear", ':%bdelete|edit #|normal `"', { desc = "Deletes all but current buffer" })
