local lspconfig = require "lspconfig"
local lspinstall = require "lspinstall"
local on_attach = require "lsp.on_attach"


local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  --? capabilities.textDocument.colorProvider = { dynamicRegistration = false }
  return {
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {},
    settings = {},
  }
end


local function setup_servers()
  lspinstall.setup()
  local servers = lspinstall.installed_servers()

  for _, lang in pairs(servers) do
    if lang == "lua" then
      require("lsp.languages.lua").setup(on_attach)
    elseif lang == "typescript" then
      require("lsp.languages.typescript").setup(on_attach)
    elseif lang == "json" then
      require("lsp.languages.json").setup(on_attach)
    else
      local config = make_config()
      lspconfig[lang].setup(config)
    end
  end
end


setup_servers()

-- todo: move to own plugin config (or make part of packer?)
-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function()
  setup_servers() -- reload installed servers
  vim.cmd "bufdo e"
end

-- null-ls
require("lsp.null-ls").setup(on_attach)
