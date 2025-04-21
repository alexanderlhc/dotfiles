vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

local M = {}

M.on_attach = function(client, bufnr)
	local map = vim.keymap.set

	print("LSP attached to buffer: " .. bufnr .. " Client: " .. client.name)

	map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
end

return M
