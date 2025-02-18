local sql_ft = { "sql", "mysql", "plsql" }
return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = sql_ft, lazy = true }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		keys = {
			{
				"<leader>Dt",
				function()
					vim.cmd("tabnew")
					vim.cmd("DBUI")
				end,
				desc = "Open new tab with DBUI",
			},
		},
		init = function()
			-- Your DBUI configuration

			-- Table helper is a predefined query that is available for each table in the list.  Default = 0
			vim.g.db_ui_auto_execute_table_helpers = 1
			-- save destinations
			local data_path = vim.fn.stdpath("data")
			vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
			vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
			-- run on save
			vim.g.db_ui_execute_on_save = false
			-- nerd font
			vim.g.db_ui_use_nerd_fonts = 1

			-- not using notify atm
			-- vim.g.db_ui_use_nvim_notify = true

			-- Disable folds in output
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "dbout",
				callback = function()
					vim.wo.foldenable = false
				end,
			})
		end,
	},
	-- {
	-- 	"saghen/blink.cmp",
	-- 	optional = true,
	-- 	opts = {
	-- 		sources = {
	-- 			default = { "dadbod" },
	-- 			providers = {
	-- 				dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
	-- 			},
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		"kristijanhusak/vim-dadbod-completion",
	-- 	},
	-- },
}
