local servers = require("plugin-configs.lsp.servers")

local M = {
	event = "BufReadPre",
}

function M.config()
	require("plugin-configs.mason").config()
	require("plugin-configs.lsp.diagnostics")
	local function on_attach(client, bufnr)
		require("plugin-configs.lsp.formatting").setup(client, bufnr)
		require("plugin-configs.lsp.keys").setup(client, bufnr)
	end

	----
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	---- options
	local options = {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}

	---- attach
	for server, opts in pairs(servers) do
		opts = vim.tbl_deep_extend("force", {}, options, opts or {})
		if server == "tsserver" then
			print("tsserver")
			require("typescript").setup({ server = opts })
		else
			require("lspconfig")[server].setup(opts)
		end
	end

	require("plugin-configs.null-ls").setup(options)
end

return M
