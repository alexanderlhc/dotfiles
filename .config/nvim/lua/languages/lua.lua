local server_name = "lua_ls"

vim.lsp.config[server_name] = {
	settings = {
		diagnostics = { globals = { "vim" } },
	},
	init_options = {},
}

vim.lsp.enable(server_name)
