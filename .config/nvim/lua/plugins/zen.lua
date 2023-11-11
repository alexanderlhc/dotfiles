return {
  "folke/zen-mode.nvim",
  opts = {},
  keys = {
    {
      "<leader>tz",
      function()
        require("zen-mode").toggle({ window = { width = .85 } })
      end,
      desc = "Toggle Zen Mode",
      mode = "n",
    },
  }
}
