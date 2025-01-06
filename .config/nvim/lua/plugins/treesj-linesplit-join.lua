return {
	"Wansmer/treesj",
	keys = {
		{
			"<Leader>S",
			function()
				require("treesj").toggle()
			end,
			desc = "[S]plit/Join current TS Node line",
		},
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		use_default_keymaps = false,
	},
}
