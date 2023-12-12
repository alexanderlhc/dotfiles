return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {

        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      { "folke/trouble.nvim" },
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
        "<leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffers",
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
        "<leader>fc",
        function()
          require("telescope.builtin").commands()
        end,
        desc = "Commands",
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
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_previous",
              ["<C-k>"] = "move_selection_previous",
              ["<C-h>"] = "which_key",
              ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble,
              ["<c-s>"] = require("trouble.providers.telescope").open_selected_with_trouble,
            },
            n = {
              ["<C-h>"] = "which_key",
              ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble,
              ["<c-s>"] = require("trouble.providers.telescope").open_selected_with_trouble,
            },
          },
        },
      })
    end
  }
}
