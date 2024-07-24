local map = require("utils").map

-- file navigation
map("n", "<leader>fe", "<cmd>:Explore<cr>", { desc = "File Explore" })

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
map("n", "<leader>q!", "<cmd>qa!<cr>", { desc = "Quit" })
map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>qb", "<cmd>bdelete<cr>", { desc = "Quit buffer" })
map("n", "<leader>qbo", '<cmd>%bdelete|edit #|normal ` "<cr>', { desc = "Quit other buffers" })
map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New File" })
map({ "v", "n", "s" }, "<leader>w<leader>", "<cmd>update!<CR>", { desc = "Save" })

-- yank
map({ "v", "n" }, "<Leader>y", '"+y<CR>', { desc = "Copy {motion} to system clipboard" })
map({ "v", "n" }, "<Leader>p", '"+p<CR>', { desc = "Paste system clipboard" })

-- Move Lines
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Move down" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("i", "<A-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Move up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
map("i", "<A-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move up" })

-- toggle options
-- map("n", "<leader>tf", require("plugins.lsp.format").toggle, { desc = "Switch/Toggle format on Save" })
map("n", "<leader>td", require("utils").toggle_diagnostics, { desc = "Switch/Toggle Diagnostics" })
map("n", "<leader>ts", function()
	require("utils").toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<leader>tw", function()
	require("utils").toggle("wrap")
end, { desc = "Toggle Word Wrap" })
if vim.lsp.inlay_hint then
	map("n", "<leader>th", function()
		vim.lsp.inlay_hint(0, nil)
	end, { desc = "Toggle Inlay Hints" })
end

-- tabs
-- map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Add undo break-points
-- map("i", ",", ",<c-g>u")
-- map("i", ".", ".<c-g>u")
-- map("i", ";", ";<c-g>u")
