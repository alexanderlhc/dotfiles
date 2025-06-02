return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
	keys = {
		{
			"<Leader>S",
			function()
				require("treesj").toggle()
			end,
			desc = "[S]plit/Join current TS Node line",
		},
	},
	opts = {
		use_default_keymaps = false,
	},
}
