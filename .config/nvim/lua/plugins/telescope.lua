return {
	{
		"nvim-telescope/telescope.nvim",
		keys = { },
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>ff",
				function()
					require("fzf-lua").files({
						cmd = "rg --files",
						winopts = { preview = { hidden = "nohidden" } }
					})
				end, desc = "[F]ind [F]ile"
			},
			{
				"<leader>fg",
				function()
					require("fzf-lua").live_grep_native({
						cmd = "rg",
						winopts = { preview = { hidden = "nohidden" } }
					})
				end, desc = "[F]ind [G]rep"
			},
			{
				"<leader>fv",
				function()
					require("fzf-lua").grep_visual({ })
				end, 
				mode = { "v" },
				desc = "[F]ind [V]isual"
			},
			{
				"<leader>fr",
				function()
					require("fzf-lua").resume()
				end, desc = "[F]ind [R]esume"
			},
			{
				"<leader>fs",
				function()
					require("fzf-lua").treesitter()
				end, desc = "[F]ind [S]ymbols"
			},
			{
				"<leader>fb",
				function()
					require("fzf-lua").buffers()
				end, desc = "[F]ind [B]uffers"
			},
			{
				"<leader>fd",
				function()
					require("fzf-lua").files({
						cmd = "rg --files",
						winopts = { preview = { hidden = "nohidden" } },
						cwd="~/.config/"
					})
				end, desc = "[F]ind [B]uffers"
			}
		},
		opts = {}
	}
}
