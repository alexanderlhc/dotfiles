local function open_cwd()
	local MiniFiles = require("mini.files")
	local buf_name = vim.api.nvim_buf_get_name(0)
	local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
	MiniFiles.open(path)
	MiniFiles.reveal_cwd()
end

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
		{
			"<Leader>fT",
			open_cwd,
			desc = "[F]iletree",
		},
	},
}
