vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup()

vim.keymap.set("n", "]h", function()
	require("gitsigns").nav_hunk("next")
end, { desc = "Next Git hunk" })
vim.keymap.set("n", "[h", function()
	require("gitsigns").nav_hunk("prev")
end, { desc = "Previous Git hunk" })
-- stage_hunk toggles: on a staged sign it unstages, so it replaces undo_stage_hunk
vim.keymap.set({ "n", "v" }, "<leader>gs", require("gitsigns").stage_hunk, { desc = "Git stage/unstage hunk" })
vim.keymap.set("n", "<leader>gr", require("gitsigns").reset_hunk, { desc = "Git reset hunk" })
vim.keymap.set("n", "<leader>gb", require("gitsigns").blame_line, { desc = "Git blame line" })
vim.keymap.set("n", "<leader>gB", require("gitsigns").blame, { desc = "Git blame line" })
