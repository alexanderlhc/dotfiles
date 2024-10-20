return {
	"echasnovski/mini.files",
	version = false,
	keys = {
		{
			"<Leader>ft",
			function()
				require("mini.files").open()
			end,
			desc = "[F]iletree",
		},
	},
}
-- return {
-- 	"stevearc/oil.nvim",
-- 	keys = {
-- 		{
-- 			"<Leader>ft",
-- 			"<cmd>Oil<CR>",
-- 			desc = "[F]iletree",
-- 		},
-- 		{
-- 			"<Leader>ft",
-- 			"<cmd>Oil<CR>",
-- 			desc = "[F]iletree",
-- 		},
-- 	},
-- 	---@module 'oil'
-- 	---@type oil.SetupOpts
-- 	opts = {},
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- }
