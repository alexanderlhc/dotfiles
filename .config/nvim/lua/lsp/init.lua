local lsp = require "lspconfig"
local lsp_installer = require("nvim-lsp-installer")
local coq = require "coq"
require "lsp.completion"

local servers = {
  "bashlhs",
  "cssls",
  "diagnosticls",
  "dockerls",
  "graphql",
  "html",
  "jsonls",
  "texlab",
  "sumneko_lua",
  "pyright",
  "rust_analyzer",
  "sqlls",
  "tsserver",
  "yamlls"
}

lsp_installer.on_server_ready(function(server)
  require "lsp.diagnostics".setup()

	local default_opts = {
		on_attach = require "lsp.on_attach",
		capabilities = require "lsp.capabilities".setup(),
	}

	-- Now we'll create a server_opts table where we'll specify our custom LSP server configuration
	local server_opts = { }

	-- We check to see if any custom server_opts exist for the LSP server, if so, load them, if not, use our default_opts
	server:setup(
    coq.lsp_ensure_capabilities(server_opts[server.name] and server_opts[server.name]() or default_opts)
    -- server_opts[server.name] and server_opts[server.name]() or default_opts
  )
	vim.cmd([[ do User LspAttachBuffers ]])
end)

require("null-ls").config {}
require("lspconfig")["null-ls"].setup {}
require("lsp.languages.tsserver")
