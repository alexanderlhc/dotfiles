local map = require("util").map

vim.g.mapleader = " "
-- map("n", "<Leader>w", ":w<CR>", { noremap = true, silent = true })

-- Clipboard
-- map("n", "<Leader>p", '"+p', { noremap = true, silent = true })
-- map("v", "<Leader>p", '"+p', { noremap = true, silent = true })
-- map("n", "<Leader>P", '"+P', { noremap = true, silent = true })
-- map("v", "<Leader>P", '"+P', { noremap = true, silent = true })
-- map("n", "<Leader>Y", '"+y', { noremap = true, silent = true })
-- map("v", "<Leader>Y", '"+y', { noremap = true, silent = true })
map("n", "<Leader>zz", ":let &scrolloff=999-&scrolloff<CR>", { noremap = true, silent = true })

-- Telescope
-- map("n", "<Leader>ty", ":Telescope neoclip unnamed<CR>", { noremap = true, silent = true })
-- map("n", "<Leader>tb", ":Telescope buffers<CR>", { noremap = true, silent = true })

-- DAP
-- map("n", "<F1>", ":lua require'dap'.step_into()<CR>", { desc = "DAP: Step into" })
-- map("n", "<F2>", ":lua require'dap'.step_over()<CR>", { desc = "DAP: Step over" })
-- map("n", "<F3>", ":lua require'dap'.step_out()<CR>", { desc = "DAP: Step out" })
-- map("n", "<F4>", ":lua require'dap'.continue()<CR>", { desc = "DAP: Continue" })
-- map("n", "<Leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "DAP: Breakpoint toggle" })
-- map(
-- 	"n",
-- 	"<Leader>B",
-- 	":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
-- 	{ desc = "DAP: Breakpoint condition" }
-- )
-- map(
-- 	"n",
-- 	"<Leader>lp",
-- 	":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
-- 	{ desc = "DAP: Log point message" }
-- )
-- map("n", "<Leader>dr", ":lua require'dap'.repl.open()<CR>", { desc = "DAP: Launch REPL" })
--
-- map("n", "<Leader>dth", ":lua require'neotest'.run.run()<CR>", { desc = "DAP: Test nearest" })
-- map("n", "<Leader>dto", ":lua require'neotest'.output.open({ enter = true })<CR>", { desc = "DAP: Test output" })
-- map("n", "<Leader>dts", ":lua require'neotest'.summary.toggle()<CR>", { desc = "DAP: Test summary toggle" })
-- map(
-- 	"n",
-- 	"<Leader>dT",
-- 	':lua require("telescope").extensions.dap.commands{}<CR>',
-- 	{ desc = "DAP: Telescope filter", noremap = true, silent = true }
-- )
