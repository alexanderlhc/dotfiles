return {
  {
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  },
  {
    "TimUntersberger/neogit",
    requires = "nvim-lua/plenary.nvim",
    config = true,
    keys = {
      {
        "<leader>G",
        function()
          require("neogit").open()
        end,
        desc = "Neogit Open",
      },
      {
        "<leader>Gv",
        function()
          require("neogit").open_vsplit()
        end,
        desc = "Neogit Open VSplit",
      },
      {
        "<leader>Gc",
        function()
          require("neogit").open_popup()
        end,
        desc = "Neogit Open Popup",
      },
      {
        "<leader>Gp",
        function()
          require("neogit").open_pull_popup()
        end,
        desc = "Neogit Open Pull Popup",
      },
      {
        "<leader>Gr",
        function()
          require("neogit").open_push_popup()
        end,
        desc = "Neogit Open Push Popup",
      },
      {
        "<leader>Gw",
        function()
          require("neogit").open_status()
        end,
        desc = "Neogit Open Status",
      },
      {
        "<leader>G?",
        function()
          require("neogit").open_help()
        end,
        desc = "Neogit Open Help",
      },
      {
        "<leader>Gc",
        function()
          require("neogit").open({ "commit" })
        end,
        desc = "Neogit commit",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
    lazy = false,
    keys = {
      {
        "<leader>Gb",
        function()
          require("gitsigns").blame_line({ full = true })
        end,
        desc = "Git line blame toggle",
      },
      {
        "<leader>Gbs",
        function()
          require("gitsigns").toggle_current_line_blame()
        end,
        desc = "Git line blame toggle",
      },
      {
        "<leader>Gd",
        function()
          require("gitsigns").diffthis()
        end,
        desc = "Git diff this",
      },
      {
        "]g",
        function()
          require("gitsigns").next_hunk()
        end,
        desc = "[G]it: Next hunk",
      },
      {
        "[g",
        function()
          require("gitsigns").prev_hunk()
        end,
        desc = "[G]it: Prev hunk",
      },
      {
        "<leader>Gs",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "[G]it: Stage hunk",
        mode = "n"
      },

      {
        "<leader>Gr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "[G]it: Reset hunk",
        mode = "n"
      },

      {
        "<leader>Gs",
        function()
          require("gitsigns").stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
        end,
        desc = "[G]it: Stage hunk in visual mode",
        mode = "v"
      },

      {
        "<leader>Gr",
        function()
          require("gitsigns").reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
        end,
        desc = "[G]it: Reset hunk in visual mode",
        mode = "v"
      },

      {
        "<leader>GS",
        function()
          require("gitsigns").stage_buffer()
        end,
        desc = "[G]it: Stage buffer",
        mode = "n"
      },

      {
        "<leader>Gu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "[G]it: Undo stage hunk",
        mode = "n"
      },

      {
        "<leader>GR",
        function()
          require("gitsigns").reset_buffer()
        end,
        desc = "[G]it: Reset buffer",
        mode = "n"
      },

      {
        "<leader>Gp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "[G]it: Preview hunk",
        mode = "n"
      }
    },
  },
  {
    'ruifm/gitlinker.nvim',
    opts = {
      mappings = "<leader>Gy"
    },
    keys = {
      {
        "<leader>Gy",
        desc = "Git linker to URL",
      }
    }
  }
}
