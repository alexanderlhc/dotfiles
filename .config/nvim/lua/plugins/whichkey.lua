return {
	"folke/which-key.nvim",
	opts = {
		plugins = { spelling = true },
		defaults = {
			mode = { "n", "v" },
			["<leader>c"] = { name = "+code" },
			["]"] = { name = "+next" },
			["["] = { name = "+prev" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
