return {
	"saghen/blink.cmp",
	version = "*",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"giuxtaposition/blink-cmp-copilot",
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		completion = {
			accept = {
				auto_brackets = { -- experimental: https://cmp.saghen.dev/configuration/completion.html#auto-brackets
					enabled = true,
				},
			},
			menu = {
				draw = {
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			-- 	ghost_text = {
			-- 		enabled = vim.g.ai_cmp,
			-- 	},
		},
		sources = {
			default = { "lsp", "copilot", "path", "snippets", "buffer" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-cmp-copilot",
					-- kind = "Copilot",
					score_offset = 100,
					async = true,
				},
			},
		},
		keymap = {
			preset = "default",
			["<C-y>"] = { "select_and_accept" },
		},
	},
	opts_extend = { "sources.default" },
}

-- Text = '󰉿',
-- Method = '󰊕',
-- Function = '󰊕',
-- Constructor = '󰒓',
--
-- Field = '󰜢',
-- Variable = '󰆦',
-- Property = '󰖷',
--
-- Class = '󱡠',
-- Interface = '󱡠',
-- Struct = '󱡠',
-- Module = '󰅩',
--
-- Unit = '󰪚',
-- Value = '󰦨',
-- Enum = '󰦨',
-- EnumMember = '󰦨',
--
-- Keyword = '󰻾',
-- Constant = '󰏿',
--
-- Snippet = '󱄽',
-- Color = '󰏘',
-- File = '󰈔',
-- Reference = '󰬲',
-- Folder = '󰉋',
-- Event = '󱐋',
-- Operator = '󰪚',
-- TypeParameter = '󰬛',
