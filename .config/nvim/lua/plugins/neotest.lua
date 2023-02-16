return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- "antoinemadec/FixCursorHold.nvim",
		"haydenmeade/neotest-jest",
	},
	opts = function()
		return {
			adapters = {
				require("neotest-jest")({
					jestCommand = "npm test --",
					jestConfigFile = "custom.jest.config.ts",
					env = { CI = true },
					cwd = function(path)
						return vim.fn.getcwd()
					end,
				}),
			},
			quickfix = {
				open = false,
			},
		}
	end,
	keys = {
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Test File",
		},
		{
			"<leader>tn",
			function()
				require("neotest").run.run()
			end,
			desc = "Test Nearest",
		},

		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Test Dap",
		},

		{
			"<leader>ts",
			function()
				require("neotest").run.stop()
			end,
			desc = "Test Stop",
		},

		{
			"<leader>tro",
			function()
				require("neotest").output.open({ enter = true })
			end,
			desc = "Test Result Open Popup",
		},

		{
			"<leader>trp",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Test Result Panel",
		},
	},
}
