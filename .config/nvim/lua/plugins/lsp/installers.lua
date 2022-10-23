local M = {}

function M.setup(servers, server_options)
	require("mason").setup()

	require("mason-tool-installer").setup({
		ensure_installed = { "stylua", "shfmt", "shellcheck", "prettierd" },
		auto_update = false,
		run_on_start = true,
	})

	require("mason-lspconfig").setup({
		ensure_installed = vim.tbl_keys(servers),
		automatic_installation = false,
	})
end

return M
