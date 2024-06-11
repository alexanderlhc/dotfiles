return {
  "hedyhli/outline.nvim",
  opts = {},
  keys = {
    {
      "<leader>o",
      function()
        require("outline").toggle()
      end,
      desc = "Toggle Outline",
      mode = "n",
    },
  },
}
