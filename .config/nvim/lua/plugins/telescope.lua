return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "danielfalk/smart-open.nvim",
        branch = "0.2.x",
        config = function()
          require("telescope").load_extension("smart_open")
        end,
        dependencies = {
          "kkharji/sqlite.lua",
          -- Only required if using match_algorithm fzf
          { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
          -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
          { "nvim-telescope/telescope-fzy-native.nvim" },
        },
      },
      {

        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      -- { "folke/trouble.nvim" },
      {
        "AckslD/nvim-neoclip.lua",
        requires = {
          { "nvim-telescope/telescope.nvim" },
        },
        config = function()
          require("neoclip").setup()
        end,
      },
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Files",
      },
      {
        "<leader><leader>",
        function()
          require("telescope").extensions.smart_open.smart_open()
        end,
        desc = "Smart Open"
      },
      {
        "<leader>fj",
        function()
          require("telescope.builtin").jumplist()
        end,
        desc = "Buffers",
      },
      {
        "<leader>fo",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "Find recent old files",
      },
      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help",
      },
      {
        "<leader>fm",
        function()
          require("telescope.builtin").marks()
        end,
        desc = "Marks",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live Grep",
      },
      {
        "<leader>fgw",
        function()
          require("telescope.builtin").grep_string()
        end,
        desc = "Live Grep Current Word",
      },
      {
        "<leader>fC",
        function()
          require("telescope.builtin").commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>fc",
        function()
          require("telescope").extensions.neoclip.default()
        end,
        desc = "Neoclip Cliboard History",
      },
      {
        "<leader>fs",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Symbols",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live Grep",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live Grep",
      },
      {
        "<leader>fwf",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        desc = "Current Buffer",
      },
      {
        "<leader>fd",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>fs",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Symbols",
      },
      {
        "<leader>fr",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "Resume last search",
      },
      -- alt+b or altgr+b
      {
        "<A-b>",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffers",
      },

      {
        "“", -- altgr+b. “ = altgr +b
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffers",
      },
    },
    config = function()
      -- idea for how to delete buffers https://www.reddit.com/r/neovim/comments/qspemc/close_buffers_with_telescope/
      require("telescope").setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = { width = 0.9 },
          path_display = {
            -- "shorten",
            filename_first = {
              reverse_directions = true,
            },
          },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_previous",
              ["<C-k>"] = "move_selection_previous",
              ["<C-h>"] = "which_key",
              -- ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble,
              -- ["<c-s>"] = require("trouble.providers.telescope").open_selected_with_trouble,
              ["<c-d>"] = require("telescope.actions").delete_buffer,
            },
            n = {
              ["<C-h>"] = "which_key",
              -- ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble,
              -- ["<c-s>"] = require("trouble.providers.telescope").open_selected_with_trouble,
              ["<c-d>"] = require("telescope.actions").delete_buffer,
            },
          },
        },
      })
    end,
  },
}
