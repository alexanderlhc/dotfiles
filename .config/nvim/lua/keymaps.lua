local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "
map('n', '<Leader>w', ':w<CR>',  { noremap = true, silent = true })

map('n', '<C-p>', '"+p', { noremap = true, silent = true })
map('v', '<C-p>', '"+p', { noremap = true, silent = true })
map('n', '<C-P>', '"+P', { noremap = true, silent = true })
map('v', '<C-P>', '"+P', { noremap = true, silent = true })
map('n', '<C-y>', '"+y', { noremap = true, silent = true })
map('v', '<C-y>', '"+y', { noremap = true, silent = true })
map('n', '<C-Y>', '"+y$', { noremap = true, silent = true })
