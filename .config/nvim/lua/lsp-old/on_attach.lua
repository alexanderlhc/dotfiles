local function on_attach(client, bufnr)
  --require("lsp.commands").setup()
  require("lsp.autocommands").setup(client)
  require("lsp.mappings").setup(bufnr)
  require("lsp.formatting").setup(client, bufnr)
  require("lsp.diagnostics").setup()
  require "lsp.signs"
end

return on_attach
