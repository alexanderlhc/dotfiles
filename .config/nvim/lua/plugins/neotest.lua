return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
	},
	config = function()
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					-- Replace newline and tab characters with space for more compact diagnostics
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)
		require("neotest").setup({
			adapters = {
				require("rustaceanvim.neotest"),
			},
		})
	end,
	keys = {
		{ "<leader>T", "", desc = "+test" },
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
				require("neotest").run.run({})
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
