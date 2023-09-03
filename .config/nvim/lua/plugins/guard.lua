return {
  {
    "nvimdev/guard.nvim",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "GuardFmt", "GuardDisable", "GuardEnable" },
    config = function()
      local ft = require("guard.filetype")

      ft("typescript,javascript,typescriptreact"):fmt("prettierd")
      ft("lua"):fmt("stylua")
      ft("rust"):fmt("rustfmt")

      require("guard").setup {
        fmt_on_save = true,
        -- lsp_as_default_formatter = false,
      }
    end,
    keys = {
      {
        "<leader>=",
        function()
          vim.cmd([[GuardFmt]])
        end,
        desc = "Format current file",
      },
    },
  },
}
