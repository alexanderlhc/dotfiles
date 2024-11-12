return {
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("github-theme").setup({})
			vim.cmd("colorscheme github_light")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = { variant = "dawn" },
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
