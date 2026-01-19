vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim" },
})

-- 1. Define all your standard servers here.
--    Keys are the server names (as recognized by Mason/lspconfig).
--    Values are the configuration tables (empty {} for default).
local servers = {
	lua_ls = {
		settings = {
			Lua = { diagnostics = { globals = { "vim" } } },
		},
	},
	ts_ls = {},
	bashls = {},
	["fish_lsp"] = {},
	["docker_language_server"] = {},
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = vim.tbl_keys(servers),
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

for server_name, server_config in pairs(servers) do
	server_config.capabilities = capabilities
	vim.lsp.config[server_name] = server_config
	vim.lsp.enable(server_name)
end

-- Rust
vim.pack.add({ "https://github.com/mrcjkb/rustaceanvim" })
