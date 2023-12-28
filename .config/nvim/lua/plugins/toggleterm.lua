local map = require("utils").map

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-t>]],
		})

		-- lazygit
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			float_opts = {
				border = "curved",
				width = 120,
				height = 40,
				winblend = 3,
			},
			hidden = true,
		})
		map("n", "<c-g>", function()
			lazygit:toggle()
		end)
	end,
}
