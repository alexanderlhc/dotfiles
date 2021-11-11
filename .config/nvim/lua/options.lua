local o = vim.opt

o.number         = true -- line numbers
o.ignorecase     = true -- ignore case
o.smartcase      = true -- ignore case unless contain mixed
o.lazyredraw     = true -- disable redraw during macro and cmds (speed)
--o.list           = true -- prettier end of line, and tab
o.listchars      = {
  eol = "↲",
  tab = "» ",
}
o.foldmethod     = "expr"
o.foldexpr       = "nvim_treesitter#foldexpr()"
o.foldlevelstart = 132
o.tabstop        = 2     -- tab takes 2 spaces
o.shiftwidth     = 2     -- spaces used for (auto)indent
o.expandtab      = true  -- tabs to spaces
o.autoindent     = true  -- use current line indent
o.splitright     = true  -- splits go right
o.mouse          = "nvi" -- mouse in: normal, visual, insert
o.syntax         = "on"
o.shell          = "/bin/bash"

o.termguicolors  = true -- 24 bit RGB colors!
vim.g.nvcode_termcolors=256
require('github-theme').setup({
  theme_style="light"
})
-- o.background     = "light"
-- vim.cmd('colorscheme one')
