local ensure_installed = {
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
}

local function cmp_setup()
	local cmp = require("cmp")
	require("copilot").setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
	})
	require("copilot_cmp").setup()
	cmp.setup({
		sources = {
			{ name = "copilot" },
			{ name = "nvim_lsp" },
		},
		mapping = {
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}),
		},
	})
end

return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" }, -- Required
		{ "williamboman/mason.nvim" }, -- Optional
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional

		-- Autocompletion
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				{
					"zbirenbaum/copilot.lua",
					"zbirenbaum/copilot-cmp",
				},
			}, -- Required
		}, -- Required
		{ "hrsh7th/cmp-nvim-lsp" }, -- Required
		{ "L3MON4D3/LuaSnip" },
	},
	config = function()
		local lsp = require("lsp-zero").preset({})

		lsp.on_attach(function(client, bufnr)
			lsp.default_keymaps({ buffer = bufnr })
		end)

		lsp.ensure_installed(ensure_installed)

		cmp_setup()

		lsp.setup()
	end,
}