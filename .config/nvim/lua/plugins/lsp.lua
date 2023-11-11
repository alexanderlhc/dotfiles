local ensure_installed = {
  "tsserver",
  "eslint",
  "html",
  "cssls",
  "rust_analyzer",
  "bashls",
  "dockerls",                        -- dockerls
  "docker_compose_language_service", -- docker-compose ls
  "jsonls",
  "intelephense",                    -- php
  "lua_ls",
  "marksman",
  "jedi_language_server", -- python
  "r_language_server",
  "sqlls",
  "lemminx", -- xml
  "yamlls",  -- yaml
}

local function cmp_setup()
  local cmp = require("cmp")
  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })
  require("copilot_cmp").setup()
  local cmp_select = { behavior = cmp.SelectBehavior.Select }
  cmp.setup({
    sources = {
      { name = "copilot" },
      { name = "path" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
    },
    formatting = require("lsp-zero").cmp_format(),
    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
      ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      ["<C-Space>"] = cmp.mapping.complete(),
    }),
  })
end

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

local function set_keymaps(bufnr)
  local map = require("utils").map

  -- keymaps
  map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic", buffer = bufnr, remap = false })
  map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic", buffer = bufnr, remap = false })
  map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error", buffer = bufnr, remap = false })
  map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error", buffer = bufnr, remap = false })
  map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning", buffer = bufnr, remap = false })
  map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning", buffer = bufnr, remap = false })
  map("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info", buffer = bufnr, remap = false })

  map("n", "gd", function()
    require("telescope.builtin").lsp_definitions({ reuse_win = true })
  end, { desc = "Goto Definition", buffer = bufnr, remap = false })
  map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References", buffer = bufnr, remap = false })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration", buffer = bufnr, remap = false })
  map("n", "gI", function()
    require("telescope.builtin").lsp_implementations({ reuse_win = true })
  end, { desc = "Goto Implementation", buffer = bufnr, remap = false })
  map("n", "gy", function()
    require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
  end, { desc = "Goto T[y]pe Definition", buffer = bufnr, remap = false })
  map("n", "<leader>cd", function()
    vim.diagnostic.open_float()
  end, { desc = "Open floating [D]iagnostic", buffer = bufnr, remap = false })
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = bufnr, remap = false })
  map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = bufnr, remap = false })
  map("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = bufnr, remap = false }) -- TODO test
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = bufnr, remap = false })
  map("n", "<leader>cA", function()
    vim.lsp.buf.code_action({
      context = {
        only = {
          "source",
        },
        diagnostics = {},
      },
    })
  end, { desc = "Source Action", buffer = bufnr, remap = false })
  map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>")
end

return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  dependencies = {
    -- LSP Support
    { "neovim/nvim-lspconfig" },             -- Required
    { "williamboman/mason.nvim" },           -- Optional
    { "williamboman/mason-lspconfig.nvim" }, -- Optional
    { "lukas-reineke/lsp-format.nvim" },

    -- Autocompletion
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        {
          "zbirenbaum/copilot.lua",
          "zbirenbaum/copilot-cmp",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-nvim-lua",
        },
      },                        -- Required
    },                          -- Required
    { "hrsh7th/cmp-nvim-lsp" }, -- Required
    { "L3MON4D3/LuaSnip" },
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "lsp-zero.nvim", "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    },
    { "hinell/lsp-timeout.nvim", }, -- Pause LSP when window is inactive
  },
  config = function()
    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(function(_, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
      set_keymaps(bufnr)
    end)



    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed,
      handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
          local lua_opts = lsp_zero.nvim_lua_ls()
          require("lspconfig").lua_ls.setup(lua_opts)
        end,
        tsserver = function()
          require("typescript-tools").setup({
            settings = {
              -- separate_diagnostic_server = true,
              publish_diagnostic_on = "insert_leave",
            },
          })
        end
      },
    })

    cmp_setup()
  end,
}
