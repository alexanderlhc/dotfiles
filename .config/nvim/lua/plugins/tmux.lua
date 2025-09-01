return {
	"aserowy/tmux.nvim",
	event = "VeryLazy",
	config = function()
		require("tmux").setup({
			navigation = {
				-- set through keys
				enable_default_keybindings = false,
				-- prevents unzoom tmux when navigating beyond vim border
				persist_zoom = false,
			},
			resize = {
				-- set through keys
				enable_default_keybindings = false,
				resize_step = 3,
			},
		})
	end,
	keys = {
		-- navigation
		{
			"<C-h>",
			function()
				require("tmux").move_left()
			end,
			mode = "n",
			desc = "tmux: focus left",
		},
		{
			"<C-j>",
			function()
				require("tmux").move_bottom()
			end,
			mode = "n",
			desc = "tmux: focus bottom",
		},
		{
			"<C-k>",
			function()
				require("tmux").move_top()
			end,
			mode = "n",
			desc = "tmux: focus top",
		},
		{
			"<C-l>",
			function()
				require("tmux").move_right()
			end,
			mode = "n",
			desc = "tmux: focus right",
		},

		-- resizing
		{
			"<C-Left>",
			function()
				require("tmux").resize_left()
			end,
			mode = "n",
			desc = "tmux: resize left",
		},
		{
			"<C-Down>",
			function()
				require("tmux").resize_bottom()
			end,
			mode = "n",
			desc = "tmux: resize bottom",
		},
		{
			"<C-Up>",
			function()
				require("tmux").resize_top()
			end,
			mode = "n",
			desc = "tmux: resize top",
		},
		{
			"<C-Right>",
			function()
				require("tmux").resize_right()
			end,
			mode = "n",
			desc = "tmux: resize right",
		},
	},
}
