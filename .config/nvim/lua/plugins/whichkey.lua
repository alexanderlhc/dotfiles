return {
	"folke/which-key.nvim",
	opts = {
		plugins = { spelling = true },
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		-- wk.register(opts.defaults)
	end,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"echasnovski/mini.icons",
	},
}
