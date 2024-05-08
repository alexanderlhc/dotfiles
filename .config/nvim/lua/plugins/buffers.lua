return {
  "j-morano/buffer_manager.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    width = 0.8,
  },
  keys = {
    {
      "<leader>fb",
      function()
        require("buffer_manager.ui").toggle_quick_menu()
      end,
      desc = "Toggle buffer manager",
    },
  },
}
