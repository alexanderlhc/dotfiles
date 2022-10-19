local M = {}

local wk = require("which-key")

function M.setup(client, buffer)
    --local cap = client.server_capabilities

    local keymap_code = {
      name = "Code",
      r = { vim.lsp.buf.rename, "Rename" },
      a = { vim.lsp.buf.code_action, "Code Action" },
      d = { vim.diagnostic.open_float, "Line Diagnostics" },
    }

    local keymap_goto = {
      name = "Goto",
      b = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
      d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
      D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
      h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
      i = { "<cmd>LspInfo<CR>", "Lsp Info" },
      I = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
      r = { vim.lsp.buf.rename, "Rename" },
      -- f format 
    }
    
    local keymap = {
      ["c"] = keymap_code,
      ["g"] = keymap_goto
    }
    
    local options = {
      prefix = "<leader>",
    }

  wk.register(keymap, options)

end

return M
