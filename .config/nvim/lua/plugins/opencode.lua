vim.pack.add({ "https://github.com/NickvanDyke/opencode.nvim" })

vim.g.opencode_opts = {}

-- Required for `opts.events.reload`.
vim.o.autoread = true

-- Opencode keymaps (grouped under <leader>c to avoid conflicts with Vim defaults)
vim.keymap.set({ "n", "x" }, "<leader>ca", function()
	require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode" })
vim.keymap.set({ "n", "x" }, "<leader>cx", function()
	require("opencode").select()
end, { desc = "Execute opencode action…" })
vim.keymap.set({ "n", "t" }, "<leader>ct", function()
	require("opencode").toggle()

	vim.defer_fn(function()
		local provider = require("opencode.config").provider
		if provider and provider.name == "tmux" then
			local pane_id = provider:get_pane_id()
			if pane_id then
				vim.fn.system("tmux select-pane -t " .. pane_id)
			end
		end
	end, 50)
end, { desc = "Toggle opencode and focus" })

vim.keymap.set({ "n", "x" }, "<leader>co", function()
	return require("opencode").operator("@this ")
end, { desc = "Opencode operator" })
