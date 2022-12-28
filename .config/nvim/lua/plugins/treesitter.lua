local M = {}

-- requires: nvim-treesitter/nvim-treesitter-textobjects
local textobjects = {
	select = {
		enable = true,
		-- Automatically jump forward to textobj, similar to targets.vim
		lookahead = true,
		keymaps = {
			-- You can use the capture groups defined in textobjects.scm
			["am"] = { query = "@function.outer", desc = "Select Around method" },
			["im"] = { query = "@function.inner", desc = "Select Inside method" },
			["ac"] = { query = "@class.outer", desc = "Select Around class" },
			["ic"] = { query = "@class.inner", desc = "Select Inner class" },
		},
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
}

local incremental_selection = {
	enable = true,
	keymaps = {
		init_selection = "<c-space>",
		node_incremental = "<c-space>",
		scope_incremental = "<c-s>",
		node_decremental = "<c-d>",
	},
}

function M.setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = "all",
		ignore_install = { "" },
		sync_install = false,

		-- Modules
		indent = { enable = true },
		highlight = { enable = true },
		textobjects = textobjects,
		incremental_selection = incremental_selection,
	})
end

return M
