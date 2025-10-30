return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		{
			"saghen/blink.pairs",
			build = "cargo build --release",
			--- @module 'blink.pairs'
			--- @type blink.pairs.Config
			opts = {},
		},
		{ "phanen/blink-cmp-register", lazy = true },
		{ "moyiz/blink-emoji.nvim", lazy = true },
		-- copilot
		{ "fang2hou/blink-copilot", lazy = true },
		{
			"zbirenbaum/copilot.lua",
			enabled = false,
		},
		{
			"github/copilot.vim",
			cmd = "Copilot",
			event = "BufWinEnter",
			init = function()
				vim.g.copilot_no_maps = true
			end,
			config = function()
				-- Block the normal Copilot suggestions
				vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
					group = "github_copilot",
					callback = function(args)
						vim.fn["copilot#On" .. args.event]()
					end,
				})
				vim.fn["copilot#OnFileType"]()
			end,
		},
	},

	-- version = '1.*',
	build = "cargo build --release",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		signature = { enabled = true },
		completion = { documentation = { auto_show = true } },

		sources = {
			default = { "lazydev", "lsp", "path", "copilot", "emoji", "snippets", "buffer", "register" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
					opts = {
						show_multiline = true,
					},
				},
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100, -- show at a higher priority than lsp
				},
				register = {
					name = "Register",
					module = "blink-cmp-register",
					score_offset = -7,
				},
				snippets = {
					max_items = 2,
				},
				emoji = {
					module = "blink-emoji",
					name = "Emoji",
					score_offset = 15, -- Tune by preference
					opts = {
						insert = true, -- Insert emoji (default) or complete its name
						---@type string|table|fun():table
						trigger = function()
							return { ":" }
						end,
					},
					should_show_items = function()
						return vim.tbl_contains(
							-- Enable emoji completion only for git commits and markdown.
							-- By default, enabled for all file-types.
							{ "gitcommit", "markdown" },
							vim.o.filetype
						)
					end,
				},
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
