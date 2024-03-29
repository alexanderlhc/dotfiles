return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree Toggle" },
    { "<leader>fT", "<cmd>Neotree<cr>",        desc = "NeoTree Goto" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  opts = {
    filesystem = { follow_current_file = { enabled = true } },
  },
}
