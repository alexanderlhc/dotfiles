return {
	"yioneko/nvim-vtsls",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("lspconfig.configs").vtsls = require("vtsls")
				.lspconfig

		-- require("lspconfig").vtsls.setup({})
	end
}
