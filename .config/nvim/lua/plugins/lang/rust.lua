return {
	"mrcjkb/rustaceanvim",
	version = "^6",
	lazy = false,
	config = function()
		require("config.lsp")
		vim.g.rustaceanvim = {}
	end,
}
