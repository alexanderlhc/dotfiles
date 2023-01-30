local M = {}

function M.setup(opts)

	require("utils").on_attach(function(client, buffer)
		if client.name == "tsserver" then
			-- stylua: ignore
			vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
			vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
		end
	end)
	require("typescript").setup({ server = opts })
end

return M

