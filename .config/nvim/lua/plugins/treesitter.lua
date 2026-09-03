vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" }, -- shows context while scrolling
	{ src = "https://github.com/MeanderingProgrammer/treesitter-modules.nvim" },
}, { load = true })

-- Disable entire built-in ftplugin mappings to avoid conflicts.
-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
vim.g.no_plugin_maps = true

require("nvim-treesitter").setup({})
require("treesitter-modules").setup({
	-- This build of Nvim ships no bundled parsers, so every language used here
	-- has to be installed explicitly; auto_install covers anything else opened.
	ensure_installed = {
		"bash",
		"c",
		"css",
		"diff",
		"dockerfile",
		"fish",
		"git_config",
		"git_rebase",
		"gitcommit",
		"gitignore",
		"html",
		"javascript",
		"json",
		"lua",
		"luadoc",
		"markdown",
		"markdown_inline",
		"python",
		"query",
		"regex",
		"rust",
		"scss",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"yaml",
	},
	auto_install = true,
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
})

require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
	},
	move = {
		set_jumps = true,
	},
})

-- Textobject keys are split with mini.ai (see plugins/ai_textobjects.lua): it keeps
-- `aa`/`ia` (argument) and `aF`/`iF` (function call), treesitter owns definitions.
local ts_select = require("nvim-treesitter-textobjects.select")
local ts_move = require("nvim-treesitter-textobjects.move")
local ts_swap = require("nvim-treesitter-textobjects.swap")

for key, capture in pairs({ f = "function", c = "class" }) do
	vim.keymap.set({ "x", "o" }, "a" .. key, function()
		ts_select.select_textobject("@" .. capture .. ".outer", "textobjects")
	end, { desc = "Around " .. capture })

	vim.keymap.set({ "x", "o" }, "i" .. key, function()
		ts_select.select_textobject("@" .. capture .. ".inner", "textobjects")
	end, { desc = "Inside " .. capture })

	vim.keymap.set({ "n", "x", "o" }, "]" .. key, function()
		ts_move.goto_next_start("@" .. capture .. ".outer", "textobjects")
	end, { desc = "Next " .. capture })

	vim.keymap.set({ "n", "x", "o" }, "[" .. key, function()
		ts_move.goto_previous_start("@" .. capture .. ".outer", "textobjects")
	end, { desc = "Prev " .. capture })
end

vim.keymap.set("n", "<leader>na", function()
	ts_swap.swap_next("@parameter.inner")
end, { desc = "Swap parameter with next" })

vim.keymap.set("n", "<leader>pa", function()
	ts_swap.swap_previous("@parameter.inner")
end, { desc = "Swap parameter with previous" })
