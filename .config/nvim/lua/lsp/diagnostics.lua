local M = {}

M.setup = function()

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = '●',
      severity_limit = 'Error',
    },
    signs = true,
    underline = true,
    update_in_insert = true,
    -- severity_sort = true,
  })


  -- Diagnostics Characters
  local signs = { Error = '✘', Warning = '', Hint = '', Information = '' }
  for type, icon in pairs(signs) do
    local hl = 'LspDiagnosticsSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end

end

return M
