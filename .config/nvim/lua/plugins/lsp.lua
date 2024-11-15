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
		"yioneko/nvim-vtsls",
	},
	config = function()
		-- Call this function when the LSP attaches to a buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				require("config.keymap_on_attach").set_lsp_keymaps(args.buf)
			end,
		})

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
			["vtsls"] = function()
				require("lspconfig.configs").vtsls = require("vtsls").lspconfig
				require("lspconfig").vtsls.setup({
					settings = {
						vtsls = {
							experimental = {
								completion = {
									enableServerSideFuzzyMatch = true,
									entriesLimit = 10,
								},
							},
						},
						typescript = {
							inlayHints = {
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								enumMemberValues = { enabled = true },
							},
							tsserver = {
								maxTsServerMemory = 8192,
								-- log = "terse",
							},
						},
					},
					capabilities = capabilities,
				})
			end,
		})
	end,
}
