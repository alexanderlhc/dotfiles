return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			javascript = { "biome" },
			typescript = { "biome" },
			rust = { "rustfmt", lsp_format = "fallback" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
	},
	keys = {
		{
			"<leader>cF",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "n",
			desc = "Format Buffer",
		},
		{
			"<leader>cF",
			function()
				require("conform").format({ range = require("conform").range })
			end,
			mode = "v",
			desc = "Format Selection",
		},
	},
}
