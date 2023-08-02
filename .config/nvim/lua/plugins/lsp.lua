return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		lazy = true,
		config = function()
			require("lsp-zero.settings").preset({})
		end,
	},
	{
		"hrsh7th/nvim-cmp", -- Required
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"zbirenbaum/copilot.lua",
			"zbirenbaum/copilot-cmp",
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			-- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
			-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

			require("lsp-zero.cmp").extend()

			-- And you can configure cmp even more, if you want to.
			-- local cmp = require('cmp')
			-- local cmp_action = require('lsp-zero.cmp').action()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
			require("copilot_cmp").setup()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{ name = "copilot" },
					{ name = "nvim_lsp" },
				},
				mapping = {
					["<CR>"] = cmp.mapping.confirm({
						-- documentation says this is important.
						-- I don't know why.
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{
				"jay-babu/mason-null-ls.nvim",
				event = { "BufReadPre", "BufNewFile" },
				dependencies = {
					"williamboman/mason.nvim",
					"jose-elias-alvarez/null-ls.nvim",
				},
			},
		},
		config = function()
			local lsp = require("lsp-zero").preset({})

			lsp.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp.default_keymaps({ buffer = bufnr })
			end)

			lsp.ensure_installed({
				"tsserver",
				"eslint",
				"html",
				"cssls",
				"rust_analyzer",
				"bashls",
				"dockerls", -- dockerls
				"docker_compose_language_service", -- docker-compose ls
				"jsonls",
				"intelephense", -- php
				"lua_ls",
				"marksman",
				"jedi_language_server", -- python
				"r_language_server",
				"sqlls",
				"lemminx", -- xml
				"yamlls", -- yaml
			})

			-- lua_ls
			-- (Optional) Configure lua language server for neovim
			require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

			lsp.setup()
			-- must be after lsp.setup()
			-- null_ls
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- Replace these with the tools you have installed
					-- make sure the source name is supported by null-ls
					-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.formatting.stylua,
				},
			})
			require("mason-null-ls").setup({
				ensure_installed = nil,
				automatic_installation = true,
				handlers = {},
			})
			lsp.format_on_save({
				format_opts = {
					async = false,
					timeout_ms = 10000,
				},
				servers = {
					["null-ls"] = { "javascript", "typescript", "lua" },
				},
			})
		end,
	},
}
