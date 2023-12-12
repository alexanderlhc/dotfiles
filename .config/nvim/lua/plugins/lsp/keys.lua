local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

local function set_keymaps()
  local map = require("utils").map

  -- keymaps
  map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic", remap = false })
  map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic", remap = false })
  map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error", remap = false })
  map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error", remap = false })
  map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning", remap = false })
  map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning", remap = false })
  map("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info", remap = false })

  map("n", "gd", function()
    require("telescope.builtin").lsp_definitions({ reuse_win = true })
  end, { desc = "Goto Definition", remap = false })
  map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References", remap = false })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration", remap = false })
  map("n", "gI", function()
    require("telescope.builtin").lsp_implementations({ reuse_win = true })
  end, { desc = "Goto Implementation", remap = false })
  map("n", "gy", function()
    require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
  end, { desc = "Goto T[y]pe Definition", remap = false })
  map("n", "<leader>cd", function()
    vim.diagnostic.open_float()
  end, { desc = "Open floating [D]iagnostic", remap = false })
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover", remap = false })
  map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help", remap = false })
  map("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help", remap = false }) -- TODO test
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", remap = false })
  map("n", "<leader>cA", function()
    vim.lsp.buf.code_action({
      context = {
        only = {
          "source",
        },
        diagnostics = {},
      },
    })
  end, { desc = "Source Action", remap = false })
  map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>")
end

local M = {}
M.set_keymaps = set_keymaps

return M;
