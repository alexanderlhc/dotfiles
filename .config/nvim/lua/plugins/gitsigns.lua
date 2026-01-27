vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup()

vim.keymap.set("n", "]h", require("gitsigns").next_hunk, { desc = "Next Git hunk" })
vim.keymap.set("n", "[h", require("gitsigns").prev_hunk, { desc = "Previous Git hunk" })
vim.keymap.set("n", "<leader>gs", require("gitsigns").stage_hunk, { desc = "Git stage hunk" })
vim.keymap.set("n", "<leader>gu", require("gitsigns").undo_stage_hunk, { desc = "Git undo stage hunk" })
vim.keymap.set("n", "<leader>gr", require("gitsigns").reset_hunk, { desc = "Git reset hunk" })
vim.keymap.set("n", "<leader>gb", require("gitsigns").blame_line, { desc = "Git blame line" })
vim.keymap.set("n", "<leader>gB", require("gitsigns").blame, { desc = "Git blame line" })
