vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

local M = {}

M.on_attach = function(client, bufnr)
	-- settings
	vim.lsp.inlay_hint.enable(true)

	-- keymap
	local get_opts = function(desc)
		return { buffer = bufnr, desc = desc }
	end
	local map = vim.keymap.set
	map({ "n", "v" }, "<leader>ca", require("fzf-lua").lsp_code_actions, get_opts("Code Action"))

	-- Rename file mapping
	map("n", "<leader>cR", function()
		Snacks.rename.rename_file()
	end, get_opts("[C]ode [R]ename File"))

	-- Rename symbol mapping
	map("n", "<leader>cr", vim.lsp.buf.rename, get_opts("[C]ode [r]ename"))

	-- Next Reference mapping
	map("n", "]]", function()
		Snacks.words.jump(vim.v.count1)
	end, get_opts("Next Reference"))

	-- Previous Reference mapping
	map("n", "[[", function()
		Snacks.words.jump(-vim.v.count1)
	end, get_opts("Previous Reference"))

	vim.keymap.set("n", "gd", require("fzf-lua").lsp_definitions, get_opts("[G]oto [D]efinition"))
	vim.keymap.set("n", "gD", require("fzf-lua").lsp_declarations, get_opts("[G]oto [D]efinition"))
	vim.keymap.set("n", "grr", require("fzf-lua").lsp_references, get_opts("[G]oto [R]eference"))
	vim.keymap.set("n", "gri", require("fzf-lua").lsp_implementations, get_opts("[G]oto [I]mplementation"))
	vim.keymap.set("n", "gs", require("fzf-lua").lsp_document_symbols, get_opts("[D]ocument [S]ymbols"))
	vim.keymap.set(
		"n",
		"<leader>ws",
		require("fzf-lua").lsp_workspace_symbols,
		get_opts("[W]orkspace [S]ymbols")
	)
end

return M
