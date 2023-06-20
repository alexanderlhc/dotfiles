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
			["]p"] = { query = "@parameter.inner", desc = "Parameter: Next start" },
			["]c"] = { query = "@comment.outer", desc = "Comment: next" },
		},
		goto_next_end = {
			["]M"] = "@function.outer",
			["]["] = "@class.outer",
			["]P"] = { query = "@parameter.outer", desc = "Parameter: Previous start" },
		},
		goto_previous_start = {
			["[m"] = "@function.outer",
			["[["] = "@class.outer",
			["[p"] = { query = "@parameter.inner", desc = "Parameter: Next start" },
			["[c"] = { query = "@comment.outer", desc = "Comment: prev" },
		},
		goto_previous_end = {
			["[M"] = "@function.outer",
			["[]"] = "@class.outer",
			["[P"] = { query = "@parameter.inner", desc = "Parameter: Next start" },
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

return {
	"nvim-treesitter/nvim-treesitter",
	version = false, -- last release is way too old and doesn't work on Windows
	build = ":TSUpdate",
	event = "BufReadPost",
	--keys = {
	--	{ "<c-space>", desc = "Increment selection" },
	--	{ "<bs>", desc = "Schrink selection", mode = "x" },
	--},
	opts = {
		ensure_installed = {
			"bash",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"tsx",
			"typescript",
			"vim",
			"yaml",
		},
		indent = { enable = true },
		highlight = { enable = true },
		context_commentstring = { enable = true, enable_autocmd = false },
		textobjects = textobjects,
		incremental_selection = incremental_selection,
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
}
