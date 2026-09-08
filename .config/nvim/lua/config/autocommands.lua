local augroup = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

-- Highlight when yanking (copying) text
--  See `:help vim.hl.hl_op()`, which deprecated vim.hl.on_yank() in 0.13.
--  Add "TextPutPost" to the event list to highlight pasted text too.
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.hl_op()
	end,
})
