-- Enable spell checking for Markdown buffers.
local opt = vim.opt_local
opt.spell = true
opt.spelllang = "en_us"
opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

opt.wrap = true
