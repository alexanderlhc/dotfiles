local M = {}

local function keymaps()
	local wk = require("which-key")

	local options_normal = {
		mode = "n", -- Normal mode
		prefix = "<leader>",
	}

	local keymap = nil -- all keys
	local keymap_d = nil -- File search

	keymap_d = {
		name = "DAP",
		b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
		q = { "<cmd>lua require('dap').close()<cr>", "Close/Quit" },
		o = { "<cmd>lua require('dap').step_over()<cr>", "Step Over" },
		i = { "<cmd>lua require('dap').step_into()<cr>", "Step Into" },
		h = { "<cmd>lua require('dap.ui.widgets').hover()<cr>", "Widgets" },
		r = { "<cmd>lua require('dap').repl.open()<cr>", "Repl open" },
		u = { "<cmd>lua require('dapui').toggle({})<cr>", "Dap UI" },
	}

	keymap = {
		["d"] = keymap_d,
	}

	wk.register(keymap, options_normal)
end

local function debuggers()
	require("plugins.dap.javascript").setup()
end

function M.setup()
	local dap, dapui = require("dap"), require("dapui")
	dap.set_log_level("TRACE")

	keymaps()
	debuggers()

	-- Automatic Launch Dap UI
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open({})
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close({})
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close({})
	end
end

return M
