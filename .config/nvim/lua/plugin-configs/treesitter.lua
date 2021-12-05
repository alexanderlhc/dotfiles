require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = {enable = true},
  indent = {enable = true},
  -- From: JoosepAlviste/nvim-ts-context-commentstring
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
}
