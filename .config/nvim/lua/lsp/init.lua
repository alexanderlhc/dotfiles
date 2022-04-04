local lsp = require "lspconfig"
local lsp_installer = require("nvim-lsp-installer")
local on_attach = require "lsp.on_attach"

local servers = {
  "bashlhs",
  "cssls",
  "diagnosticls",
  "dockerls",
  "eslint",
  "graphql",
  "html",
  "jsonls",
  "pyright",
  "rust_analyzer",
  "sqlls",
  "sumneko_lua",
  "texlab",
  "tsserver",
  "yamlls"
}

-- Automatic install
for _, name in pairs(servers) do
	local ok, server = lsp_installer.get_server(name)
	-- Check that the server is supported in nvim-lsp-installer
	if ok then
		if not server:is_installed() then
			print("Installing " .. name)
			server:install()
		end
	end
end

lsp_installer.on_server_ready(function(server)
  require "lsp.diagnostics".setup()

	local default_opts = {
		on_attach = on_attach,
		capabilities = require "lsp.capabilities".setup(),
	}

	-- Now we'll create a server_opts table where we'll specify our custom LSP server configuration
	local server_opts = { }

	-- We check to see if any custom server_opts exist for the LSP server, if so, load them, if not, use our default_opts
	server:setup(
    server_opts[server.name] and server_opts[server.name]() or default_opts
  )
	vim.cmd([[ do User LspAttachBuffers ]])
end)
