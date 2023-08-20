return {
	{
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	},
	{
		"TimUntersberger/neogit",
		requires = "nvim-lua/plenary.nvim",
		config = true,
		keys = {
			{
				"<leader>G",
				function()
					require("neogit").open()
				end,
				desc = "Neogit Open",
			},
			{
				"<leader>Gs",
				function()
					require("neogit").open_split()
				end,
				desc = "Neogit Open Split",
			},
			{
				"<leader>Gv",
				function()
					require("neogit").open_vsplit()
				end,
				desc = "Neogit Open VSplit",
			},
			{
				"<leader>Gc",
				function()
					require("neogit").open_popup()
				end,
				desc = "Neogit Open Popup",
			},
			{
				"<leader>Gp",
				function()
					require("neogit").open_pull_popup()
				end,
				desc = "Neogit Open Pull Popup",
			},
			{
				"<leader>Gr",
				function()
					require("neogit").open_push_popup()
				end,
				desc = "Neogit Open Push Popup",
			},
			{
				"<leader>Gw",
				function()
					require("neogit").open_status()
				end,
				desc = "Neogit Open Status",
			},
			{
				"<leader>G?",
				function()
					require("neogit").open_help()
				end,
				desc = "Neogit Open Help",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		keys = {
			{
				"<leader>Gb",
				function()
					require("gitsigns").blame_line({ full = true })
				end,
				desc = "Git line blame toggle",
			},
			{
				"<leader>Gbs",
				function()
					require("gitsigns").toggle_current_line_blame()
				end,
				desc = "Git line blame toggle",
			},
			{
				"<leader>Gd",
				function()
					require("gitsigns").diffthis()
				end,
				desc = "Git line blame toggle",
			},
			{
				"]g",
				function()
					require("gitsigns").next_hunk()
				end,
				desc = "Goto: Git Next hunk",
			},
			{
				"[g",
				function()
					require("gitsigns").prev_hunk()
				end,
				desc = "Goto: Git Prev hunk",
			},
		},
	},
}
