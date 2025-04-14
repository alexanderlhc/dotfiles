local scratch_dir = vim.fn.stdpath("cache") .. "/scratch.nvim"

return {
	"LintaoAmons/scratch.nvim",
	event = "VeryLazy",
	opts = {
		scratch_file_dir = scratch_dir,
		filetypes = { "markdown", "js", "sh", "ts" },
	},
	keys = {
		{ "<leader>s", "", desc = "[S]cratchpad" },
		{
			"<leader>sn",
			"<cmd>Scratch<cr>",
			desc = "New scratch file",
		},
		{
			"<leader>sN",
			"<cmd>ScratchWithName<cr>",
			desc = "New Named scratch file",
		},
		{
			"<leader>so",
			"<cmd>ScratchOpen<cr>",
			desc = "Open scratch file",
		},
		{
			"<leader>fS",
			"<cmd>ScratchOpenFzf<cr>",
			desc = "[S]cratch files",
		},
		{
			"<leader>sd",
			function()
				require("fzf-lua").files({
					prompt = "Select scratch to delete > ",
					cwd = scratch_dir,
					file_icons = false,
					actions = {
						["default"] = function(selected)
							local filename = selected[1]:match("[^%s]+$") -- Match last non-whitespace sequence
							local filepath = scratch_dir .. "/" .. filename
							if vim.fn.delete(filepath) == 0 then
								vim.notify("Deleted " .. filename)
							end
						end,
					},
				})
			end,
			desc = "Delete scratch file",
		},
	},
}
