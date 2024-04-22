return {
  -- UX
  {
    "catppuccin/nvim",
    lazy = true,
    priority = 1000,
    opts = {
      flavor = "latte", -- latte, frappe, macchiato, mocha
      background = {    -- :h background
        light = "latte",
        dark = "mocha",
      },
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
    {
      "danymat/neogen",
      dependencies = "nvim-treesitter/nvim-treesitter",
      config = true,
      -- Uncomment next line if you want to follow only stable versions
      -- version = "*"
    },
    {
      "m4xshen/hardtime.nvim",
      dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
      opts = {
        disabled_keys = {
          ["<Up>"] = {},
          ["<Down>"] = {},
          ["<Left>"] = {},
          ["<Right>"] = {},
        },
        restricted_keys = {
          ["<Up>"] = { "n", "x" },
          ["<Down>"] = { "n", "x" },
          ["<Left>"] = { "n", "x" },
          ["<Right>"] = { "n", "x" },
        },
        disabled_filetypes = {
          "NvimTree",
          "TelescopePrompt",
          "aerial",
          "alpha",
          "checkhealth",
          "dapui*",
          "Diffview*",
          "Dressing*",
          "help",
          "httpResult",
          "lazy",
          "Neogit*",
          "mason",
          "neotest-summary",
          "minifiles",
          "neo-tree*",
          "neo-tree",
          "netrw",
          "noice",
          "notify",
          "prompt",
          "qf",
          "oil",
          "undotree",
          "Trouble",
        },
      }
    },
  },
}
