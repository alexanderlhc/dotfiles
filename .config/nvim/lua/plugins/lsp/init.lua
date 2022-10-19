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

function M.setup()
  require("plugins.lsp.installers").setup(servers, opts)
end

return M
