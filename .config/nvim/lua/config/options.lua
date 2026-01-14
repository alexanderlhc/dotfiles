local opt = vim.opt -- Abbreviation for options

opt.termguicolors = true -- Enable true color support
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.signcolumn = "yes" -- Always show the sign column
opt.wrap = false -- Disable text wrapping
opt.mouse = "a"
-- opt.showmode = false

opt.cursorline = true -- Enable highlighting of the current line
opt.list = true -- Show some invisible characters
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 2 -- Number of spaces or tabs used for indentation levels using comands
opt.softtabstop = 2 -- Tab key moves 2 columns (inserts spaces)

opt.undofile = true -- Save undo history

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

opt.inccommand = "split" -- view substitutions live

opt.scrolloff = 10 -- number of screen lines to keep above and below the cursor

-- Disable some rtp plugins for perf improvement
vim.g.did_install_default_menus = 1
vim.g.loaded_gzip = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
