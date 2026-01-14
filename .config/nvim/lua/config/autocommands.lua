-- Highlight when yanking (copying) text
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Update all packs
vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
    vim.cmd.write()
    -- TODO tsupdate and mason updates
end, { desc = "Update all plugins" })
