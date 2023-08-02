return {
	"glepnir/lspsaga.nvim",
	event = "LspAttach",
	config = function()
		require("lspsaga").setup({})
	end,
	keys = {
		{
			"gd",
			mode = { "n" },
			"<cmd>Lspsaga goto_definition<CR>",
			desc = "Go to definition",
		},
		{
			"gD",
			mode = { "n" },
			"<cmd>Lspsaga peek_definition<CR>",
			desc = "Peek definition",
		},
		{
			"gt",
			mode = { "n" },
			"<cmd>Lspsaga goto_type_definition<CR>",
			desc = "Go to type definition",
		},
		{
			"gT",
			mode = { "n" },
			"<cmd>Lspsaga peek_type_definition<CR>",
			desc = "Peek type definition",
		},
		{
			"K",
			mode = { "n" },
			"<cmd>Lspsaga hover_doc ++keep<CR>",
			desc = "Show hover documentation",
		},
		{
			"<leader>rn",
			mode = { "n" },
			"<cmd>Lspsaga rename<CR>",
			desc = "Rename",
		},
		{
			"<leader>ca",
			"<cmd>Lspsaga code_action<CR>",
			desc = "Code action",
		},
		{
			"gr",
			mode = { "n" },
			"<Cmd>Lspsaga finder<CR>",
			desc = "Go to references",
		},
		{
			"<leader>e",
			mode = { "n" },
			"<cmd>Lspsaga show_buf_diagnostics<CR>",
			desc = "Show buffer diagnostics",
		},
		{
			"<leader>wd",
			mode = { "n" },
			"<cmd>Lspsaga show_workspace_diagnostics<CR>",
			desc = "Show workspace diagnostics",
		},
		{
			"[d",
			mode = { "n" },
			"<cmd>Lspsaga diagnostic_jump_prev<CR>",
			desc = "Go to prev diagnostic",
		},
		{
			"]d",
			mode = { "n" },
			"<cmd>Lspsaga diagnostic_jump_next<CR>",
			desc = "Go to next diagnostic",
		},
	},
	opts = {
		lightbulb = {
			enable = true,
			enable_in_insert = true,
			sign = true,
			sign_priority = 40,
			virtual_text = false,
		},
	},
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-treesitter/nvim-treesitter" },
	},
}
