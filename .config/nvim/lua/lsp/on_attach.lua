local on_attach = function(client, bufnr)
  require("lsp.mappings").setup(client)
end

return on_attach
