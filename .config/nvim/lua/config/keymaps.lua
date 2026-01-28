local map = vim.keymap.set
local opts = { noremap = true, silent = true }

------- File management ---------
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save File" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit Neovim" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Quit All Force" })
map("n", "<leader>x", "<cmd>wq<CR>", { desc = "Save File and Quit" })

------- Searching ---------
map({ "i", "n", "s" }, "<esc>", function()
	vim.cmd("noh")
	-- .actions.snippet_stop()
	return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

------- Buffers ---------
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
	vim.cmd("bdelete")
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, { force = false })
		end
	end
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
