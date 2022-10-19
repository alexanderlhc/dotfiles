local M = {}

local servers = {
  html = {},
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  sumneko_lua = {},
  tsserver = {},
  vimls = {},
  yamlls = {
    schemastore = {
      enable = true,
    },
    settings = {
      yaml = {
        hover = true,
        completion = true,
        validate = true,
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  dockerls = {},
  bashls = {},
}

local opts = {
  on_attach = require("plugins.lsp.on_attach").on_attach,
  capabilities = {},
  flags = {
    debounce_text_changes = 150,
  },
}


function M.setup()
  require("plugins.lsp.null-ls").setup(opts)
  require("plugins.lsp.installers").setup(servers, opts)
end

return M
