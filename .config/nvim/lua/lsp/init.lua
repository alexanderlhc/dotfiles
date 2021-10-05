local lspconfig = require('lspconfig')
local lspinstall = require('lspinstall')
local on_attach = require('lsp.on_attach')
require('lsp.completion')

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  -- capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
  return {
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = vim.loop.cwd,
  }
end

local function setup_servers()
  lspinstall.setup()
  local servers = lspinstall.installed_servers()

  for _, lang in pairs(servers) do
    if lang == "lua" then
      -- require("lsp.languages.lua").setup(on_attach)
    elseif lang == "typescript" then
       require("lsp.languages.typescript").setup(on_attach)
    elseif lang == "json" then
      -- require("lsp.languages.json").setup(on_attach)
    else
      local config = make_config()
      lspconfig[lang].setup(config)
    end
  end

  require("lsp.null-ls").setup()
  require("lspconfig")["null-ls"].setup({ capabilities = capabilities, on_attach = on_attach })
end


setup_servers()
