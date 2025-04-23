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
	-- map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = bufnr })

	-- Rename file mapping
	map("n", "<leader>cR", function()
		Snacks.rename.rename_file()
	end, { desc = "Rename File", buffer = bufnr })

	-- Rename symbol mapping
	map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })

	-- Next Reference mapping
	map("n", "]]", function()
		Snacks.words.jump(vim.v.count1)
	end, { desc = "Next Reference", buffer = bufnr })

	-- Previous Reference mapping
	map("n", "[[", function()
		Snacks.words.jump(-vim.v.count1)
	end, { desc = "Prev Reference", buffer = bufnr })
end

return M
