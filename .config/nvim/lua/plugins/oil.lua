return {
	'stevearc/oil.nvim',
	keys = {
		{
			"<Leader>F",
			"<cmd>Oil<CR>",
			desc = "[F]iletree"
		}
	},
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" }
}
