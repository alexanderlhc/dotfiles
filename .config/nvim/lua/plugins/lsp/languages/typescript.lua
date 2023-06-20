local M = {}

function M.setup(opts)
	require("utils").on_attach(function(client, buffer)
		if client.name == "tsserver" then
			-- stylua: ignore
      vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
			vim.keymap.set(
				"n",
				"<leader>cR",
				"<cmd>TypescriptRenameFile<CR>",
				{ desc = "Rename File", buffer = buffer }
			)
		end
	end)
	require("typescript").setup({
		server = opts,
		settings = {
			documentformatting = false,
			diagnostics = {
				enable = false,
			},
		},
	})
end

return M
