require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	ignore_install = { "ocaml", "ocaml_interface", "ocamllex" },
	highlight = { enable = true },
	indent = { enable = true },
	-- From: JoosepAlviste/nvim-ts-context-commentstring
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},

	-- module: treesitter-refactor
	refactor = {
		enable = true,
		clear_on_cursor_move = true,
		-- highlight_current_scope = { enable = true },
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},
	},

	-- module: ts-autotag
	autotag = {
		enable = true,
	},

	-- module: nvim-ts-rainbow
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})
