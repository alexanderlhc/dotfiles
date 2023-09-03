local ensure_installed = {
  "tsserver",
  "prettierd",
  "eslint",
  "html",
  "cssls",
  "rust_analyzer",
  "rustfmt",
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
  cmp.setup({
    sources = {
      { name = "copilot" },
      { name = "nvim_lsp" },
      { name = "path" },
      { name = 'nvim_lua' },
    },
    mapping = {
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
    },
  })
end

return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v2.x",
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
          "hrsh7th/cmp-nvim-lua"
        },
      },                        -- Required
    },                          -- Required
    { "hrsh7th/cmp-nvim-lsp" }, -- Required
    { "L3MON4D3/LuaSnip" },
  },
  config = function()
    local lsp = require("lsp-zero").preset({})

    lsp.on_attach(function(client, bufnr)
      -- local opts = { buffer = bufnr }
      lsp.default_keymaps({ buffer = bufnr })

      -- -- Format on save
      -- if client.supports_method('textDocument/formatting') then
      --   require('lsp-format').on_attach(client)
      --
      --   vim.keymap.set({ 'n', 'x' }, 'gq', function()
      --     vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
      --   end, opts)
      -- end
    end)

    lsp.ensure_installed(ensure_installed)

    cmp_setup()

    lsp.setup()
  end,
}
