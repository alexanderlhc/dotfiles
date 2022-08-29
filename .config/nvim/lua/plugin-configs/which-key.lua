local wk = require("which-key")

wk.register({
	name = "DAP",
	["<F1>"] = { ":lua require'dap'.step_into()<CR>", "DAP: Step into" },
	["<F2>"] = { ":lua require'dap'.step_over()<CR>", "DAP: Step over" },
	["<F3>"] = { ":lua require'dap'.step_out()<CR>", "DAP: Step out" },
	["<F4>"] = { ":lua require'dap'.continue()<CR>", "DAP: Continue" },
	["<Leader>"] = {
		b = { ":lua require'dap'.toggle_breakpoint()<CR>", "DAP: Breakpoint toggle" },
		B = {
			":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
			"DAP: Breakpoint condition",
		},
		["lp"] = {
			":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
			"DAP: Log point message",
		},
		["dr"] = { ":lua require'dap'.repl.open()<CR>", "DAP: Launch REPL" },
		["td"] = { ':lua require("telescope").extensions.dap.commands{}<CR>', "DAP: Telescope filter" },
	},
})

wk.register({
	name = "Test",
	h = { ":lua require'neotest'.run.run()<CR>", "DAP: Test nearest" },
	o = { ":lua require'neotest'.output.open({ enter = true })<CR>", "DAP: Test output" },
	s = { ":lua require'neotest'.summary.toggle()<CR>", "DAP: Test summary toggle" },
}, { prefix = "dt" })

wk.register({
	P = { '"+P', "paste from clipboard" },
	Y = { '"+y|:echo "yanked"<CR>', "yank to clipboard" },
}, { mode = "v", noremap = true, silent = true })

wk.register({
	t = {
		name = "telescope",
		k = { "<cmd>Telescope keymaps<cr>", "Find Keys" },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap = false },
		b = { "<cmd>Telescope buffers<cr>", "Find file in buffer" },
		g = {
			name = "telescope git",
			b = { "<cmd>Telescope git_bcommits<cr>", "Find git commit for buffer" },
		},
		c = { "<cmd>Telescope colorscheme<cr>", "Find colorscheme" },
		yh = { "<cmd>Telescope neoclip unnamed<CR>", "Clipboard history (neoclip)" },
	},
	w = { ":w<CR>", "Save File" },
	s = { "<cmd>SymbolsOutline<cr>", "Toggles Symbols Panel" },
}, { prefix = "<leader>" })

local diagnostic_goto_previous = function()
	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end
local diagnostic_goto_next = function()
	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end

wk.register({
	name = "LSP",

	-- diagnostics
	["<leader>el"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Diagnostic: show line" },
	["[e"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Diagnostic: jump next" },
	["]e"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Diagnostic: jump prev" },
	["[E"] = { diagnostic_goto_previous, "Diagnostic: jump prev error" },
	["]E"] = { diagnostic_goto_next, "Diagnostic: jump next error" },
	["<Leader>gh"] = { "<cmd>Lspsaga lsp_finder<CR>", "LSP find cursor definition/reference" },
	K = { "<cmd>Lspsaga hover_doc<CR>", "Documentation hover" },
	["<Leader>r"] = { "<cmd>Lspsaga rename<CR>", "Rename symbol" },
	["<leader>ca"] = { "<cmd>Lspsaga code_action<CR>", "LSP: Code Action" },
})

wk.register({
	name = "LSP Visual",
	["<leader>ca"] = { "<cmd><C-U>Lspsaga range_code_action<CR>", "LSP: Code Action Visual" },
}, { mode = "v" })
