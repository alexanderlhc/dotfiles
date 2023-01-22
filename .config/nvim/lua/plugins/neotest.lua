local neotest = require("neotest")
local M = {}

function M.setup()
	neotest.setup({
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
	})

	vim.keymap.set("n", "<leader>tf", function()
		neotest.run.run(vim.fn.expand("%"))
	end, { desc = "Test File" })

	vim.keymap.set("n", "<leader>tn", function()
		neotest.run.run()
	end, { desc = "Test Nearest" })

	vim.keymap.set("n", "<leader>td", function()
		neotest.run.run({ strategy = "dap" })
	end, { desc = "Test Dap" })

	vim.keymap.set("n", "<leader>ts", function()
		neotest.run.stop()
	end, { desc = "Test Stop" })

	vim.keymap.set("n", "<leader>tro", function()
		neotest.output.open({ enter = true })
	end, { desc = "Test Result Open Popup" })

	vim.keymap.set("n", "<leader>trp", function()
		neotest.output_panel.toggle()
	end, { desc = "Test Result Panel" })
end

return M
