vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
	{ src = "https://github.com/zbirenbaum/copilot.lua" },
	{ src = "https://github.com/giuxtaposition/blink-cmp-copilot" },
	"https://github.com/rafamadriz/friendly-snippets",
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
})

vim.opt.runtimepath:append(vim.fn.expand("~/.config/nvim/pack/plugins/start/friendly-snippets"))
require("nvim-autopairs").setup()
require("nvim-ts-autotag").setup()

require("copilot").setup({
	suggestion = {
		enabled = false,
	},
	panel = { enabled = false },
})

require("blink.cmp").setup({
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	completion = {
		ghost_text = {
			enabled = true,
			show_with_menu = false,
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		list = { selection = { preselect = true, auto_insert = true } },
		menu = {
			draw = {
				components = {
					kind_icon = {
						text = function(ctx)
							if ctx.kind == "Snippet" then
								return ""
							end
							local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
							return kind_icon
						end,
						-- (optional) use highlights from mini.icons
						highlight = function(ctx)
							local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							return hl
						end,
					},
					kind = {
						-- (optional) use highlights from mini.icons
						highlight = function(ctx)
							local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							return hl
						end,
					},
				},
			},
		},
	},

	sources = {
		default = { "lsp", "path", "buffer", "snippets", "copilot" },
		providers = {
			copilot = {
				name = "Copilot",
				module = "blink-cmp-copilot",
				score_offset = 100,
				async = true,
			},
			snippets = {
				-- hide snippet after trigger character
				should_show_items = function(ctx)
					return ctx.trigger.initial_kind ~= "trigger_character"
				end,
				score_offset = 50,
			},
		},
	},

	signature = { enabled = true }, -- lsp signature while in insert
})
