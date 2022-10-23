vim.opt.number = true -- line numbers
vim.opt.signcolumn = "yes" -- diagnostics in number column

-- highlight current line number
vim.opt.cursorline = true
vim.api.nvim_set_option("cursorlineopt", "number")
