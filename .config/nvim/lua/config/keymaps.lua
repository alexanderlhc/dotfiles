local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

-- Move Lines
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Move down" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("i", "<A-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Move up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
map("i", "<A-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move up" })

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- indent repeatable
map("v", "<", "<gv")
map("v", ">", ">gv")

-- quit / save / new
map("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>q!", "<cmd>qa<cr>", { desc = "Quit" })
map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New File" })
map({ "i", "v", "n", "s" }, "<leader>w", "<cmd>update!<CR>", { desc = "Save" })

-- yank
map({ "v", "n" }, "<Leader>y", '"+y<CR>', { desc = "Copy {motion} to system clipboard" })
map({ "v", "n" }, "<Leader>p", '"+p<CR>', { desc = "Paste system clipboard" })

-- toggle options
map("n", "<leader>sf", require("plugins.lsp.format").toggle, { desc = "Switch/Toggle format on Save" })
--map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
--map("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
--map("n", "<leader>ul", function() Util.toggle("relativenumber", true) Util.toggle("number") end, { desc = "Toggle Line Numbers" })
map("n", "<leader>sd", require("utils").toggle_diagnostics, { desc = "Switch/Toggle Diagnostics" })
--local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
--map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
