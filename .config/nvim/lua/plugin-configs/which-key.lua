local wk = require("which-key")

local telescope = {
	name = "telescope",
	f = { "<cmd>Telescope find_files<cr>", "Find File" },
	r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap = false },
	b = { "<cmd>Telescope buffers<cr>", "Find file in buffer" },
	g = {
		name = "telescope git",
		b = { "<cmd>Telescope git_bcommits<cr>", "Find git commit for buffer" },
	},
	c = { "<cmd>Telescope colorscheme<cr>", "Find colorscheme" },
	yh = { "<cmd>Telescope neoclip unnamed<CR>", "Clipboard history (neoclip)" },
}

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
	p = { '"+p', "paste from clipboard" },
	P = { '"+P', "paste from clipboard" },
	Y = { '"+y', "yank to clipboard" },
}, { mode = "nv", noremap = true, silent = true })

wk.register({
	t = telescope,
	w = { ":w<CR>", "Save File" },
}, { prefix = "<leader>" })

wk.register({
	name = "LSP",
})
