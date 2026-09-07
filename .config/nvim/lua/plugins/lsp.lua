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
	marksman = {},
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

-- Stock diagnostics render nothing inline: no virtual text, no virtual lines.
-- Turn the message on at the end of the line and sort worst-first. Swap
-- `virtual_text` for `virtual_lines = { current_line = true }` if messages get
-- too long to sit on one line.
vim.diagnostic.config({
	severity_sort = true,
	virtual_text = { spacing = 2, source = "if_many" },
	float = { border = "rounded", source = "if_many" },
})

-- Neovim 0.11 already maps grn/gra/grr/gri/grt, K, gO, ]d/[d and <C-w>d.
-- Only the goto-definition pair is missing; route it through fzf-lua so several
-- results land in the picker the rest of this config uses, not the quickfix list.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
	callback = function(event)
		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
		end

		map("gd", "<cmd>FzfLua lsp_definitions<cr>", "Goto definition")
		map("gD", "<cmd>FzfLua lsp_declarations<cr>", "Goto declaration")
	end,
})
