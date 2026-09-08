if vim.env.HERDR_ENV ~= nil and vim.env.HERDR_ENV ~= "" then
	-- Herdr's ctrl+hjkl passes through to this pane (see
	-- ~/.config/herdr/bin/herdr-nav.sh). Move between splits, and when the
	-- move hits the edge, hand focus back to the neighbouring herdr pane.
	local function navigate(wincmd, direction)
		return function()
			local from = vim.fn.winnr()
			vim.cmd.wincmd(wincmd)
			if from == vim.fn.winnr() then
				local pane = vim.env.HERDR_PANE_ID
				local cmd = { "herdr", "pane", "focus", "--direction", direction }
				if pane and pane ~= "" then
					table.insert(cmd, "--pane")
					table.insert(cmd, pane)
				end
				vim.system(cmd, { text = true })
			end
		end
	end

	vim.keymap.set("n", "<C-h>", navigate("h", "left"), { desc = "Go to left window/pane" })
	vim.keymap.set("n", "<C-j>", navigate("j", "down"), { desc = "Go to lower window/pane" })
	vim.keymap.set("n", "<C-k>", navigate("k", "up"), { desc = "Go to upper window/pane" })
	vim.keymap.set("n", "<C-l>", navigate("l", "right"), { desc = "Go to right window/pane" })
else
	vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
	vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
	vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
	vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
end
