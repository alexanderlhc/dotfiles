vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

require("fzf-lua")

local set = vim.keymap.set
set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find Files (all)" })
set("n", "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })
set("n", "<leader>fF", "<cmd>FzfLua live_grep<cr>", { desc = "Find Files Grep (all)" })
set("n", "<leader>fk", "<cmd>FzfLua keymaps<cr>", { desc = "Find Keymaps" })

set("n", "<leader>sk", "<cmd>FzfLua keymaps<cr>", { desc = "Key Maps" })
