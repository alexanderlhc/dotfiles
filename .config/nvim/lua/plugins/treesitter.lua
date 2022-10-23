local M = {}

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
