return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim",
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
					"jsonls",
					"vtsls",
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			local icons = require("config.icons").lazy
			require("mason").setup({
				ui = {
					icons = {
						package_installed = icons.package_installed,
						package_pending = icons.package_pending,
						package_uninstalled = icons.package_uninstalled,
					},
				},
			})
		end,
	},
}
