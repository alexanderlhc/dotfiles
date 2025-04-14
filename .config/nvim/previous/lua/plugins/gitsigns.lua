return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"]c",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					require("gitsigns").nav_hunk("next")
				end
			end,
			desc = "Next hunk",
		},
		{
			"[c",
			function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					require("gitsigns").nav_hunk("prev")
				end
			end,
			desc = "Previous hunk",
		},
		{
			"<leader>gs",
			function()
				require("gitsigns").stage_hunk()
			end,
			desc = "Stage hunk",
		},
		{
			"<leader>gr",
			function()
				require("gitsigns").reset_hunk()
			end,
			desc = "Reset hunk",
		},
		{
			"<leader>gs",
			function()
				require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			mode = "v",
			desc = "Stage selected hunk",
		},
		{
			"<leader>gr",
			function()
				require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			mode = "v",
			desc = "Reset selected hunk",
		},
		{
			"<leader>gS",
			function()
				require("gitsigns").stage_buffer()
			end,
			desc = "Stage buffer",
		},
		{
			"<leader>gu",
			function()
				require("gitsigns").undo_stage_hunk()
			end,
			desc = "Undo stage hunk",
		},
		{
			"<leader>gR",
			function()
				require("gitsigns").reset_buffer()
			end,
			desc = "Reset buffer",
		},
		{
			"<leader>gp",
			function()
				require("gitsigns").preview_hunk()
			end,
			desc = "Preview hunk",
		},
		{
			"<leader>gb",
			function()
				require("gitsigns").blame_line({ full = true })
			end,
			desc = "Blame line",
		},
		{
			"<leader>gd",
			function()
				require("gitsigns").diffthis()
			end,
			desc = "Diff this",
		},
		{
			"<leader>gD",
			function()
				require("gitsigns").diffthis("~")
			end,
			desc = "Diff this ~",
		},
		{
			"<leader>tb",
			function()
				require("gitsigns").toggle_current_line_blame()
			end,
			desc = "Toggle git line blame",
		},
		{
			"<leader>td",
			function()
				require("gitsigns").toggle_deleted()
			end,
			desc = "Toggle git deleted",
		},
		{
			"<leader>tG",
			function()
				require("gitsigns").toggle_signs()
			end,
			desc = "Toggle git signs",
		},
		{ "ih", ":<C-U>Gitsigns select_hunk<CR>", mode = { "o", "x" }, desc = "Select hunk" },
	},
}
