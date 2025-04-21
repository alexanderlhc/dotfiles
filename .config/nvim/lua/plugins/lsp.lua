return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local icons = require("config.icons").diagnostics
			local signs = { Error = icons.Error, Warn = icons.Warn, Hint = icons.Hint, Info = icons.Info }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			local lsp_config = require("config.lsp")
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = {
					"biome",
				},
				-- This function gets called for each server defined AFTER setup handlers
				-- Use it for general server setup, supplemented by language-specific setups
				handlers = {
					-- Default handler: Sets up LSP using capabilities and on_attach from lsp_config
					function(server_name)
						require("lspconfig")[server_name].setup({
							on_attach = lsp_config.on_attach,
						})
					end,
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			local icons = require("config.icons")
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						icons.lazy.package_installed,
						icons.lazy.package_pending,
						icons.lazy.package_uninstalled,
					},
				},
			})
		end,
	},
}
