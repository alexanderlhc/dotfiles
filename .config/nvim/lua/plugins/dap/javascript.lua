local M = {}

function M.setup()
	local dap = require("dap")

	--dap.adapters.node2 = {
	--	type = "executable",
	--	command = "node",
	--	args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
	--}

	dap.adapters.node2 = {
		type = "executable",
		command = "node-debug2-adapter", -- installed via Mason
		args = {},
	}

	dap.adapters.node = dap.adapters.node2

	dap.configurations.javascript = {
		{
			name = "Launch",
			type = "node2",
			request = "launch",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			-- For this to work you need to make sure the node process is started with the `--inspect` flag.
			name = "Attach to process",
			type = "node2",
			request = "attach",
			processId = require("dap.utils").pick_process,
		},
	}

	dap.configurations.typescript = {
		{
			name = "npm start",
			type = "node2",
			request = "launch",
			runtimeExecutable = "npm",
			runtimeArgs = { "run-script", "start" },
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
			outFiles = { "${workspaceRoot}/dist/**/*.js" },
		},
		{
			name = "${file}",
			type = "node2",
			request = "launch",
			program = "${workspaceFolder}/${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
			outFiles = { "${workspaceRoot}/dist/**/*.js" },
		},
		{
			name = "jest",
			type = "node2",
			request = "launch",
			cwd = vim.fn.getcwd(),
			runtimeArgs = {
				"--inspect-brk",
				"${workspaceFolder}/node_modules/.bin/jest",
				"--no-coverage",
				"--",
				"${workspaceFolder}/${file}",
			},
			sourceMaps = true,
			protocol = "inspector",
			skipFiles = { "<node_internals>/**/*.js" },
			console = "integratedTerminal",
			port = 9229,
			outFiles = { "${workspaceRoot}/dist/**/*.js" },
		},
	}
end

return M
