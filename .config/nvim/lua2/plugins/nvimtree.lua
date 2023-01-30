local M = {}

function M.setup()
  local nvimtree = require("nvim-tree")

  nvimtree.setup({
    disable_netrw = false,
    hijack_netrw = true,
    respect_buf_cwd = true,
  })

end

return M
