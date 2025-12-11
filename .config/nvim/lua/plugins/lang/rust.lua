return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		config = function()
			require("config.lsp")
			vim.g.rustaceanvim = {}
		end,
	},
	{
		"saecki/crates.nvim",
	},
	{
		"nvim-neotest/neotest",
		dependencies = { "mrcjkb/rustaceanvim" },
		opts = function(_, opts)
			opts.adapters = {
				require("rustaceanvim.neotest"),
			}
		end,
	},
}
