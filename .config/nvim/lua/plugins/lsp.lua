vim.pack.add({
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/williamboman/mason.nvim'},
    { src = 'https://github.com/williamboman/mason-lspconfig.nvim' }
})
--
require('mason').setup()
require('mason-lspconfig').setup({ })

-- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { desc = "Restart LSP" })

require('languages.typescript')
