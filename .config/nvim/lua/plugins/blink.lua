vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp" },
	"https://github.com/rafamadriz/friendly-snippets",
})

vim.opt.runtimepath:append(vim.fn.expand("~/.config/nvim/pack/plugins/start/friendly-snippets"))

require("blink.cmp").setup({
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	completion = {
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
		default = { "snippets", "lsp", "path", "buffer" },
	},

	signature = { enabled = true }, -- lsp signature while in insert
})
