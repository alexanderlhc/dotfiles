return {
	"mrcjkb/rustaceanvim",
	version = "^6",
	lazy = false,
	config = function()
		local on_attach_shared = require("config.lsp").on_attach
		vim.g.rustaceanvim = {
			server = {
				on_attach = on_attach_shared,
			},
		}
	end,
}
