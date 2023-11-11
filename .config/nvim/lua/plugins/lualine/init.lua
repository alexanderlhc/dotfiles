--[[
https://github.com/nvim-lualine/lualine.nvim

+-------------------------------------------------+
| A | B | C                             X | Y | Z |
+-------------------------------------------------+
--]]

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local mode = require("plugins.lualine.components.mode")
    local macro = require("plugins.lualine.components.macro")
    local filetype = require("plugins.lualine.components.filetype")
    local filename = require("plugins.lualine.components.filename")
    local gitdiff = require("plugins.lualine.components.gitdiff")
    local diagnostics = require("plugins.lualine.components.diagnostics")

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "lazy" } },
      },
      sections = {
        lualine_a = { { mode }, { macro } },
        lualine_b = { "branch" },
        lualine_c = { filetype, filename, },
        lualine_x = {},
        lualine_y = { diagnostics },
        lualine_z = { gitdiff },
      },
      extensions = { "neo-tree" },
    }
  end,
}
