require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  ignore_install = { "ocaml", "ocaml_interface", "ocamllex" },
  highlight = {enable = true},
  indent = {enable = true},
  -- From: JoosepAlviste/nvim-ts-context-commentstring
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },

  -- module: treesitter-refactor
  refactor = {
    enable = true,
    clear_on_cursor_move = true,
    highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
  }
}
