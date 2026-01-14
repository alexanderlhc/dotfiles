local server_name = 'ts_ls'
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config[server_name] = {
  capabilities = capabilities,
  settings = {},
  init_options = {},
}

vim.lsp.enable(server_name)
