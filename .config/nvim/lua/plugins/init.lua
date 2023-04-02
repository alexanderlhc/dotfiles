return {
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {}, -- mappings are not applied without
	},
	-- UX
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "latte", -- latte, frappe, macchiato, mocha
				background = {
					light = "latte",
					dark = "mocha",
				},
				--transparent_background = true,
			})
			vim.cmd([[colorscheme catppuccin]])
			vim.cmd([[set background=light]])
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = {
			{ "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup()
		end,
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
	},
	{
		"chrisgrieser/nvim-spider",
		lazy = true,
		keys = {
			{ "<leader>sp", "<cmd>Spider<cr>", desc = "Spider" },
			-- Keymaps
			{
				"w",
				function()
					require("spider").motion("w")
				end,
				desc = "Spider-w",
				mode = { "n", "o", "x" },
			},
			{
				"e",
				function()
					require("spider").motion("e")
				end,
				desc = "Spider-e",
				mode = { "n", "o", "x" },
			},
			{
				"b",
				function()
					require("spider").motion("b")
				end,
				desc = "Spider-b",
				mode = { "n", "o", "x" },
			},
			{
				"ge",
				function()
					require("spider").motion("ge")
				end,
				desc = "Spider-ge",
				mode = { "n", "o", "x" },
			},
		},
	},
}
