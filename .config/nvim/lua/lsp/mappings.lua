require 'lspsaga'

local M = {}

-- https://rishabhrd.github.io/jekyll/update/2020/09/19/nvim_lsp_config.html
function M.setup(bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'ca', "<CMD>lua vim.lsp.buf.code_action()<CR><CR>", opts)
  buf_set_keymap('v', 'ca', "<CMD>:<C-U>Lspsaga range_code_action<CR>", opts) 
  --buf_set_keymap('n', 'ca', "<CMD>:Lspsaga code_action<CR>", opts)
  --buf_set_keymap('v', 'ca', "<CMD>:<C-U>Lspsaga range_code_action<CR>", opts)
  -- buf_set_keymap('n', 'ca', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
  -- buf_set_keymap('v', 'ca', '<Cmd>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)


  -- Declaration / Definition / Signature / Implementation
  buf_set_keymap('n', 'gD',  "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", opts)
  buf_set_keymap('n', 'gd', "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)
  -- buf_set_keymap('n', 'gD',  '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd',  "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- buf_set_keymap('n', 'gd', "<cmd>lua require('lspsaga.provider').preview_definition()<CR>", opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gs', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  -- Documentation with scrolling
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', 'K', "<Cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
  buf_set_keymap('n', '<C-f>', "<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
  buf_set_keymap('n', '<C-b>', "<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)

  -- Workspace
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  -- Rename
  buf_set_keymap('n', '<space>rn', "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)

  -- Diagnostics
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '<space>e', "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  -- if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  -- end


end

return M
