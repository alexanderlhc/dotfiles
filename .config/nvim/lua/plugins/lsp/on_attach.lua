local M = {}

function M.on_attach(client, bufnr)
  local caps = client.server_capabilities
  
  -- Configure key mappings
  require("plugins.lsp.keys").setup(client, bufnr)

  -- Configure highlighting
  --require("config.lsp.highlighter").setup(client, bufnr)

  -- Configure formatting
  --require("config.lsp.null-ls.formatters").setup(client, bufnr)

end

return M
