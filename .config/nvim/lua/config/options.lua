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

opt.undofile = true -- Save undo history

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

opt.inccommand = "split" -- view substitutions live

opt.scrolloff = 10 -- number of screen lines to keep above and below the cursor
