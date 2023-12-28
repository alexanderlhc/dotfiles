vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "

local opt = vim.opt

opt.autoindent = true -- ! -- use current line indent
opt.completeopt = "menu,menuone,noselect"
opt.expandtab = true -- Use spaces instead of tabs
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- ! -- ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.shell = "/bin/bash" -- !
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- ! -- spaces used for (auto)indent
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- ! -- ignore case unless contain mixed
opt.smartindent = true -- ! -- Insert indents automatically
opt.spelllang = { "en", "da" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- ! -- splits go right
opt.syntax = "on" -- !
opt.tabstop = 2 -- ! -- tab takes 2 spaces
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = true -- Disable line wrap
