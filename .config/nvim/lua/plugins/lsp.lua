vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim" },
})
--
require("mason").setup()
require("mason-lspconfig").setup({})

-- Diagnostic auto show
-- Show diagnostics under the cursor when holding the cursor
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false })
	end,
})

-- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("i", "<C-k>", function()
	vim.lsp.buf.signature_help()
end, { desc = "LSP Signature Help" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

require("languages.typescript")
require("languages.lua")
