return {
	"ThePrimeagen/refactoring.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("refactoring").setup({})
	end,
	keys = {
		-- Remaps for the refactoring operations currently offered by the plugin
		{
			"<leader>re",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
			desc = "Refactor Extract Function",
			mode = "v",
		},
		{
			"<leader>rf",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
			desc = "Refactor Extract Function to File",
			mode = "v",
		},
		{
			"<leader>rv",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
			desc = "Refactor Extract Variable",
			mode = "v",
		},
		{
			"<leader>ri",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
			desc = "Refactor Extract Inline Variable",
			mode = "v",
		},

		-- Extract block doesn't need visual mode
		{
			"<leader>rb",
			[[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
			desc = "Refactor Extract Block",
			mode = "n",
		},
		{
			"<leader>rbf",
			[[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
			desc = "Refactor Extract Block to File",
			mode = "n",
		},

		-- Inline variable can also pick up the identifier currently under the cursor without visual mode
		{
			"<leader>ri",
			[[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
			desc = "Refactor Inline Variable",
			mode = "n",
		},
	},
}
