local mason_lsp_config_opts = {
	ensure_installed = {
		"bashls",
		"lua_ls",
	}
}

return 	{
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function ()
		require("mason").setup()
		require("mason-lspconfig").setup(mason_lsp_config_opts)

		require("mason-lspconfig").setup_handlers({
			-- function(server_name)
			-- 	require("lspconfig")[server_name].setup({ })
			-- end,
		})
	end,
}
