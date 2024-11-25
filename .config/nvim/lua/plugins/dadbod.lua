return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1

			-- Disable folds in output
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "dbout",
				callback = function()
					vim.wo.foldenable = false
				end,
			})
		end,
	},
	{
		"saghen/blink.cmp",
		optional = true,
		opts = {
			sources = {
				completion = {
					enabled_providers = { "dadbod" },
				},
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},
		},
		dependencies = {
			"kristijanhusak/vim-dadbod-completion",
		},
	},
}
