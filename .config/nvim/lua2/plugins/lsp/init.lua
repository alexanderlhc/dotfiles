local servers = require("plugins.lsp.servers")
local capabilities = require("plugins.lsp.capabilities")
local M = {}

function M.setup()
	require("fidget").setup() -- Loading Fidget
	require("mason").setup()
	require("mason-nvim-dap").setup({
		automatic_installation = true,
		automatic_setup = true,
	})
	require("plugins.dap").setup()
	require("plugins.lsp.diagnostics").setup()
	require("plugins.neodev").setup()

	local options = {
		on_attach = require("plugins.lsp.on_attach").on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}

	for server, opts in pairs(servers) do
		opts = vim.tbl_deep_extend("force", {}, options, opts or {})

		if server == "tsserver" then
			require("typescript").setup({ server = opts })
		else
			require("lspconfig")[server].setup(opts)
		end
	end

	require("plugins.lsp.installers").setup(servers, options)
	require("plugins.lsp.null-ls").setup(options)
end

return M