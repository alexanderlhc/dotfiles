local function on_attach(attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("eden_lsp_attach", { clear = true }),
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      attach(client, buffer)
    end,
  })
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = true,
        dependencies = { 'williamboman/mason-lspconfig.nvim' }
      },
      {
        'hrsh7th/nvim-cmp',
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "zbirenbaum/copilot.lua",
          "zbirenbaum/copilot-cmp",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-nvim-lua",
        },
        config = function()
          local cmp = require("cmp")
          local cmp_select = { behavior = cmp.SelectBehavior.Select }
          require("copilot_cmp").setup()
          cmp.setup({
            sources = {
              { name = "copilot" },
              { name = "path" },
              { name = "nvim_lsp" },
              { name = "nvim_lua" },
            },
            mapping = cmp.mapping.preset.insert({
              ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
              ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
              ["<C-y>"] = cmp.mapping.confirm({ select = true }),
              ["<C-Space>"] = cmp.mapping.complete(),
            }),
          })
        end,
      },
      {
        "zbirenbaum/copilot.lua",
        config = {
          suggestion = { enabled = false },
          panel = { enabled = false },
        }
      },
      {
        "lvimuser/lsp-inlayhints.nvim",
        opts = {}
      },
    },
    config = function()
      local lspconfig = require('lspconfig')
      require('mason-lspconfig').setup {
        ensure_installed = { "lua_ls", "tsserver", "marksman", "intelephense", "sqlls", "yamlls", "html", "htmx", "docker_compose_language_service", "dockerls", "cssls", "bashls" },
        automatic_installation = true,
        handlers = {
          function(server)
            lspconfig[server].setup({
              capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })
          end,
        },
      }
      on_attach(function(client, buffer)
        require("lsp-inlayhints").on_attach(client, buffer)
      end)
      require("plugins.lsp.keys").set_keymaps()
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^3', -- Recommended
    ft = { 'rust' },
    config = function()
      on_attach(function(client, buffer)
        require("lsp-inlayhints").on_attach(client, buffer)
      end)
    end,
  }
}
