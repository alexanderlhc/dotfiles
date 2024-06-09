vim.cmd.highlight('IndentLine guifg=#ccd0da')        -- not inside region
vim.cmd.highlight('IndentLineCurrent guifg=#5c5f77') -- active region

return {
  "nvimdev/indentmini.nvim",
  lazy = true,
  event = { 'BufRead', 'BufNewFile' },
  opts = {
    char = '┊' --  ⁞, ⋮, ┆, ┊, ┋, ┇
  }
}
