local map = require('utility').map

vim.g.mapleader = " "
map('n', '<Leader>w', ':w<CR>',  { noremap = true, silent = true })

-- Clipboard
map('n', '<Leader>p', '"+p', { noremap = true, silent = true })
map('v', '<Leader>p', '"+p', { noremap = true, silent = true })
map('n', '<Leader>P', '"+P', { noremap = true, silent = true })
map('v', '<Leader>P', '"+P', { noremap = true, silent = true })
map('n', '<Leader>Y', '"+y', { noremap = true, silent = true })
map('v', '<Leader>Y', '"+y', { noremap = true, silent = true })
map('n', '<Leader>yh', ':Telescope neoclip unnamed<CR>', { noremap = true, silent = true })
