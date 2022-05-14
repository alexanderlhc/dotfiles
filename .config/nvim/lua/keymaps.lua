local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "
map('n', '<Leader>w', ':w<CR>',  { noremap = true, silent = true })

map('n', '<Leader>p', '"+p', { noremap = true, silent = true })
map('v', '<Leader>p', '"+p', { noremap = true, silent = true })
map('n', '<Leader>P', '"+P', { noremap = true, silent = true })
map('v', '<Leader>P', '"+P', { noremap = true, silent = true })
map('n', '<Leader>Y', '"+y', { noremap = true, silent = true })
map('v', '<Leader>Y', '"+y', { noremap = true, silent = true })
map('n', '<Leader>yh', ':Telescope neoclip unnamed<CR>', { noremap = true, silent = true })
