-- TODO: migrate https://neovim.io/doc/user/lua.html#vim.keymap.set()
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return {
  map = map,
}
