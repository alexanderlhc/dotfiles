return {
	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	dependencies = "rafamadriz/friendly-snippets",

	-- use a release tag to download pre-built binaries
	version = "v0.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- see the "default configuration" section below for full documentation on how to define
		-- your own keymap.
		keymap = { preset = "default" },

		highlight = {
			-- sets the fallback highlight groups to nvim-cmp's highlight groups
			-- useful for when your theme doesn't support blink.cmp
			-- will be removed in a future release, assuming themes add support
			use_nvim_cmp_as_default = true,
		},

		windows = {
			autocomplete = {
				-- winblend = vim.o.pumblend, -- transparency
			},
			documentation = {
				auto_show = true,
			},
			ghost_text = {
				enabled = vim.g.ai_cmp,
			},
		},


		-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",

		-- experimental auto-brackets support
		accept = { auto_brackets = { enabled = true } },

		-- experimental signature help support
		trigger = { signature_help = { enabled = true } },

		sources = {
			completion = {
				enabled_providers = { 'lsp', 'path', 'snippets', 'buffer' },
			},
		},
	},

	-- allows extending the enabled_providers array elsewhere in your config
	-- without having to redefining it
	opts_extend = { "sources.completion.enabled_providers" },
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
