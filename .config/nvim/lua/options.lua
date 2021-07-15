local o = vim.opt


o.number         = true -- line numbers
o.ignorecase     = true -- ignore case
o.smartcase      = true -- ignore case unless contain mixed
o.lazyredraw     = true -- disable redraw during macro and cmds (speed)
o.termguicolors  = true -- 24 bit RGB colors!
o.list           = true -- prettier end of line, and tab
o.listchars      = {
  eol = "↲",
  tab = "» ",
}
o.tabstop        = 2     -- tab takes 2 spaces
o.shiftwidth     = 2     -- spaces used for (auto)indent
o.expandtab      = true  -- tabs to spaces
o.autoindent     = true  -- use current line indent
o.splitright     = true  -- splits go right
o.mouse          = "nvi" -- mouse in: normal, visual, insert
