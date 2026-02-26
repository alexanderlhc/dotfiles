vim.pack.add({
	"https://github.com/tadmccorkle/markdown.nvim",
})

require("markdown").setup({
	on_attach = function(bufnr)
		if vim.bo[bufnr].ft ~= "markdown" then
			return
		end

		local map = vim.keymap.set
		local opts = { buffer = bufnr }
		map("n", "<M-c>", "<Cmd>MDTaskToggle<CR>", opts)
		map("x", "<M-c>", ":MDTaskToggle<CR>", opts)
	end,
})
