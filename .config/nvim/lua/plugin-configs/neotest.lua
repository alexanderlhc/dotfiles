require("neotest").setup({
  adapters = {
    require("neotest-jest")({
      jestCommand = "yarn test --"
    }),
  },
})

--guifg=#e1e2e7
-- vim.api.nvim_set_hl(0, 'NeotestDir', { fg = "#000000" })
-- vim.api.nvim_set_hl(0, 'NeotestFile', { fg= "#000000" })
-- vim.api.nvim_set_hl(0, 'NeotestTest', { fg= "#000000" })
vim.api.nvim_set_hl(0, 'NeotestFailed', { fg= "#c64343" })
-- vim.api.nvim_set_hl(0, 'NeotestIndent', { fg= "#000000" })
vim.api.nvim_set_hl(0, 'NeotestPassed', { fg = "#188092" })
-- vim.api.nvim_set_hl(0, 'NeotestFocused', { fg= "#000000" })
-- vim.api.nvim_set_hl(0, 'NeotestRunning', { fg= "#000000" })
-- vim.api.nvim_set_hl(0, 'NeotestSkipped', { fg= "#000000" })
-- vim.api.nvim_set_hl(0, 'NeotestNamespace', { fg= "#000000" })

vim.api.nvim_set_keymap("n", "<Leader>ntr", [[ <Cmd>lua require("neotest").run.run()<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>nto", [[ <Cmd>lua require("neotest").output.open({ enter = true })<CR>]], {noremap = true, silent = true, expr = false})