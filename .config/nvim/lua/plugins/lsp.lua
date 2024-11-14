local mlsp_opts = {
	ensure_installed = { "lua_ls", "vtsls", "cssls", "html" },
}

return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup(mlsp_opts)

		local capabilities = require("blink.cmp").get_lsp_capabilities()
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["rust_analyzer"] = function() end,
		})
	end,
}
