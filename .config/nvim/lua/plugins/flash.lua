return {
  "folke/flash.nvim",
  event = "VeryLazy",
  config = function()
    require("flash").setup()
    vim.api.nvim_set_hl(0, "FlashCursor", { fg = "red", bg = "yellow" })
  end,
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    {
      "<c-s>",
      mode = { "c" },
      function() require("flash").toggle() end,
      desc =
      "Toggle Flash Search"
    },
  },
}
