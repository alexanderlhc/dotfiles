local M = {}

function M.setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = "all",
		ignore_install = { "" },
		sync_install = false,
		--auto_install = true,

		highlight = {
			enable = true,
		},

		-- requires: nvim-treesitter/nvim-treesitter-textobjects
		textobjects = {
			select = {
				enable = true,

				-- Automatically jump forward to textobj, similar to targets.vim
				--lookahead = true,

				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["am"] = { query = "@function.outer", desc = "Select Around method" },
					["im"] = { query = "@function.inner", desc = "Select Inside method" },
					["ac"] = { query = "@class.outer", desc = "Select Around class" },
				},
				-- You can choose the select mode (default is charwise 'v')
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * method: eg 'v' or 'o'
				-- and should return the mode ('v', 'V', or '<c-v>') or a table
				-- mapping query_strings to modes.
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = { query = "@class.outer", desc = "Next class start" },
					["]p"] = { query = "@parameter.inner", desc = "Next parameter start" },
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
		},
	})
end

return M
