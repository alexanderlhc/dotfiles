return {
	-- UX
	{
		"catppuccin/nvim",
		lazy = true,
		priority = 1000,
		opts = {
			flavor = "latte", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			integrations = {
				alpha = true,
				cmp = true,
				flash = true,
				gitsigns = true,
				illuminate = true,
				indent_blankline = { enabled = true },
				lsp_trouble = true,
				mason = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
				navic = { enabled = true, custom_bg = "lualine" },
				neotest = true,
				noice = true,
				notify = true,
				neotree = true,
				semantic_tokens = true,
				telescope = true,
				treesitter = true,
				which_key = true,
			},
		},
		{
			"danymat/neogen",
			dependencies = "nvim-treesitter/nvim-treesitter",
			config = true,
			-- Uncomment next line if you want to follow only stable versions
			-- version = "*"
		},
	},
}
