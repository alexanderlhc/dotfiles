-- resize splits if window got resized
-- vim.api.nvim_create_autocmd({ "VimResized" }, {
-- 	callback = function()
-- 		local current_tab = nvim_get_current_tabpage()
-- 		vim.cmd("tabdo wincmd =")
-- 		nvim_set_current_tabpage(current_tab)
-- 	end,
-- })

-- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.api.nvim_create_autocmd("FileType", {
	desc = "remove formatoptions",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- spell
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- go to last loc when opening a buffer
-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	callback = function()
-- 		local mark = vim.api.nvim_buf_get_mark(0, '"')
-- 		local lcount = vim.api.nvim_buf_line_count(0)
-- 		if mark[1] > 0 and mark[1] <= lcount then
-- 			pcall(vim.api.nvim_win_set_cursor, 0, mark)
-- 		end
-- 	end,
-- })

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"man",
		"notify",
		"lspinfo",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})
