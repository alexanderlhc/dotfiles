require("mason").setup()
local lspconfig_mason = require("mason-lspconfig")
local lspconfig = require("lspconfig")

lspconfig_mason.setup({
	ensure_installed = { "sumneko_lua", "tsserver", "jsonls", "bashls", "yamlls", "sqlls", "pyright" },
})

-------------------------
----- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-------------------------
----- on_attach
local function my_on_attach(client)
	require("lsp_signature").on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
	})
end

-------------------------
----- Initialize
for _, server in ipairs(lspconfig_mason.get_installed_servers()) do
	lspconfig[server].setup({
		capabilities = capabilities,
		on_attach = my_on_attach,
	})
end
