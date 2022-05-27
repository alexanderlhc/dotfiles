local map = require('utility').map

vim.cmd [[autocmd FileType fugitive noremap <buffer> q :q<cr>]]
vim.cmd [[autocmd FileType fugitive noremap <buffer> <Leader>p :Gpush<cr>]]

map('n', '<Leader>G', ':G<CR>', { noremap = true, silent = true })
map('n', '<Leader>Gch', ':G checkout ', { noremap = true, silent = true })
map('n', '<Leader>Gw', ':Gwrite', { noremap = true, silent = true })
map('n', '<Leader>Gwc', ':Gwrite<CR>:G commit<CR>', { noremap = true, silent = true })
