return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	event = "BufWritePre",
	opts = {
		formatters_by_ft = {
			["*"] = { "codespell" },
			javascript = { "biome" },
			javascriptreact = { "biome" },
			json = { "jq" },
			lua = { "stylua" },
			-- rust = { "rustfmt", lsp_format = "fallback" },
			sh = { "shfmt" },
			typescript = { "biome" },
			typescriptreact = { "biome" },
			sql = { "sqlfluff" },
			mysql = { "sqlfluff" },
		},
		formatters = {
			sqlfluff = {
				command = "sqlfluff",
				args = { "format", "--dialect=mariadb", "-" },
				stdin = true,
				cwd = function()
					return vim.fn.getcwd()
				end,
			},
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
