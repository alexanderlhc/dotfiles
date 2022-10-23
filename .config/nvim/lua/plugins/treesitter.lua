local M = {}

-- folding
vim.opt.foldlevel = 1
vim.opt.foldmethod = "expr" -- TreeSitter folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- TreeSitter folding

function M.setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = "all",
		ignore_install = { "" },
		sync_install = false,
		--auto_install = true,

		highlight = {
			enable = true,
		},
	})
end

return M
