local M = {
	module = "mason",
}

M.tools = {
	"prettierd",
	"stylua",
	"selene",
	"luacheck",
	"eslint_d",
	"shellcheck",
	"shfmt",
}

function M.check()
	local mr = require("mason-registry")
	for _, tool in ipairs(M.tools) do
		local p = mr.get_package(tool)
		if not p:is_installed() then
			p:install()
		end
	end
end

function M.config()
	require("mason").setup()
	M.check()
	require("mason-lspconfig").setup({
		automatic_installation = true,
	})
end

return M
--require("mason").setup()
--local lspconfig_mason = require("mason-lspconfig")
--local lspconfig = require("lspconfig")
--
--lspconfig_mason.setup({
--	ensure_installed = { "sumneko_lua", "tsserver", "jsonls", "bashls", "yamlls", "sqlls", "pyright" },
--})
--
---------------------------
------- Capabilities
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
--
---------------------------
------- on_attach
--local function my_on_attach(client)
--	require("lsp_signature").on_attach({
--		bind = true, -- This is mandatory, otherwise border config won't get registered.
--	})
--end
--
---------------------------
------- Initialize
--for _, server in ipairs(lspconfig_mason.get_installed_servers()) do
--	lspconfig[server].setup({
--		capabilities = capabilities,
--		on_attach = my_on_attach,
--	})
--end
