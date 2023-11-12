return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    {
      "<leader>xt",
      function()
        require("trouble").toggle()
      end,
      desc = "Toggle Trouble",
    },
    {
      "<leader>xq",
      function()
        require("trouble").toggle("quickfix")
      end,
      desc = "Toggle Trouble Quickfix",
    },
    {
      "<leader>xl",
      function()
        require("trouble").toggle("loclist")
      end,
      desc = "Toggle Trouble Loclist",
    },
    {
      "<leader>xw",
      function()
        require("trouble").toggle("workspace_diagnostics")
      end,
      desc = "Toggle Trouble Workspace diagnostics",
    },
    {
      "<leader>xd",
      function()
        require("trouble").toggle("document_diagnostics")
      end,
      desc = "Toggle Trouble Document diagnostics",
    },
  }
}
