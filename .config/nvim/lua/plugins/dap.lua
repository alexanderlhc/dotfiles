function TypeScriptJavaScript()
	local dap = require("dap")
	-- Adapters: Node and TypeScript
	-- local node2_path = helpers.get_from_data_path("/mason/packages/node-debug2-adapter/out/src/nodeDebug.js")
	local node2_path = vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js"

	-- if not helpers.is_empty(node2_path) then
	dap.adapters.node2 = {
		type = "executable",
		command = "node",
		args = { node2_path },
	}
	-- end

	-- Adapters: Chrome
	-- local chrome_path = helpers.get_from_data_path("/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js")
	local chrome_path = vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js"

	-- if not helpers.is_empty(chrome_path) then
	dap.adapters.chrome = {
		type = "executable",
		command = "node",
		args = { chrome_path },
	}
	-- end

	dap.configurations.typescript = {
		{
			type = "node2",
			name = "Attach",
			request = "attach",
			program = "${file}",
			cwd = vim.fn.expand("%:p:h"),
			sourceMaps = true,
			protocol = "inspector",
		},
		{
			type = "node2",
			request = "launch",
			name = "Jest test",
			runtimeExecutable = "node",
			runtimeArgs = { "--inspect-brk", "${workspaceFolder}/node_modules/.bin/jest" },
			args = { "${file}", "--runInBand", "--no-cache", "--coverage", "false" },
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			sourceMaps = "inline",
			port = 9229,
			skipFiles = { "<node_internals>/**", "node_modules/**" },
			protocol = "inspector",
		},
		{
			type = "chrome",
			name = "chrome",
			request = "attach",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = vim.fn.getcwd(),
			sourceMapPathOverrides = {
				-- Sourcemap override for nextjs
				["webpack://_N_E/./*"] = "${webRoot}/*",
				["webpack:///./*"] = "${webRoot}/*",
			},
			protocol = "inspector",
			port = 9222,
			webRoot = "${workspaceFolder}",
		},
	}

	dap.configurations.javascript = dap.configurations.typescript
	dap.configurations.typescriptreact = dap.configurations.typescript
	dap.configurations.javascriptreact = dap.configurations.typescript

	-- used by neotest
	local jsdebug_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"
	require("dap-vscode-js").setup({
		adapters = { "pwa-node" },
		debugger_path = jsdebug_path,
	})
end

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		{
			"jayp0521/mason-nvim-dap.nvim",
			opts = {
				automatic_installation = true,
				automatic_setup = true,
			},
		},
		"nvim-telescope/telescope-dap.nvim",
		{
			"mxsdev/nvim-dap-vscode-js",
			branch = "start-debugging",
			config = function()
				TypeScriptJavaScript()
			end,
		},
	},
	config = function()
		require("dapui").setup()
		require("nvim-dap-virtual-text").setup()
	end,
	keys = {
		{ "db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "DAP: Toggle Breakpoint" },
		{ "dc", "<cmd>lua require('dap').continue()<cr>", desc = "DAP: Continue" },
		{ "dq", "<cmd>lua require('dap').close()<cr>", desc = "DAP: Close/Quit" },
		{ "do", "<cmd>lua require('dap').step_over()<cr>", desc = "DAP: Step Over" },
		{ "di", "<cmd>lua require('dap').step_into()<cr>", desc = "DAP: Step Into" },
		{ "dh", "<cmd>lua require('dap.ui.widgets').hover()<cr>", desc = "DAP: Widgets" },
		{
			"dr",
			function()
				require("dap").repl.open()
			end,
			desc = "DAP: Repl open",
		},
		{
			"du",
			function()
				require("dapui").toggle({})
			end,
			desc = "DAP: Dap UI",
		},
	},
}
