vim.pack.add({ "https://github.com/cousine/opencode-context.nvim" })

require("opencode-context").setup({
	tmux_target = "opencode:1",
	auto_detect_pane = false,
	-- tmux_target = nil,
	-- auto_detect_pane = true,
})

vim.keymap.set("n", "<leader>oc", "<cmd>OpencodeSend<cr>", { desc = "Send prompt to opencode" })
vim.keymap.set("v", "<leader>oc", "<cmd>OpencodeSend<cr>", { desc = "Send prompt to opencode" })
vim.keymap.set("n", "<leader>ot", "<cmd>OpencodeSwitchMode<cr>", { desc = "Toggle opencode mode" })
vim.keymap.set("n", "<leader>op", "<cmd>OpencodePrompt<cr>", { desc = "Open opencode persistent prompt" })
