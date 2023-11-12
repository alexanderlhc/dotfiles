return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  dependencies = {
    {
      'echasnovski/mini.indentscope',
      version = false,
      opts = {}
    },
    {
      'vidocqh/auto-indent.nvim',
      opts = {},
    },
  },
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
}
