return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"haydenmeade/neotest-jest",
	},
	config = function()
		local neotest, neotest_jest = require("neotest"), require("neotest-jest")

		neotest.setup({
			enable_keybindings = true,
			adapters = {
				neotest_jest({
					jestCommand = "yarn test",
				}),
			},
		})
	end,
	keys = {
		{
			"<leader>Tt",
			function()
				require("neotest").run.run()
			end,
			desc = "Run test",
		},
		{
			"<leader>Tc",
			function()
				require("neotest").run.stop()
			end,
			desc = "Cancel running test",
		},
		{
			"<leader>TT",
			function()
				print("running neotest on file")
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run tests in file",
		},
		{
			"<leader>To",
			function()
				require("neotest").output.open({ enter = true })
			end,
			desc = "Open test output",
		},
		{
			"<leader>Tm",
			function()
				require("neotest").summary.marked()
			end,
			desc = "Run marked tests",
		},
		{
			"<leader>Ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle test summary",
		},
		{
			"]t",
			function()
				require("neotest").jump.next()
			end,
			desc = "Jump to next test",
		},
		{
			"[t",
			function()
				require("neotest").jump.prev()
			end,
			desc = "Jump to previous test",
		},
		{
			"]T",
			function()
				require("neotest").jump.next({ status = "failed" })
			end,
			desc = "Jump to next failed test",
		},
		{
			"[T",
			function()
				require("neotest").jump.prev({ status = "failed" })
			end,
			desc = "Jump to previous failed test",
		},
	},
}
