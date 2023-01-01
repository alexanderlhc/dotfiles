local M = {}

function M.setup()
	require("lualine").setup({
		options = {
			icons_enabled = false,
		},
		--[[ 
		+-------------------------------------------------+
		| A | B | C                             X | Y | Z |
		+-------------------------------------------------+
    ]]
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {
			lualine_a = {
				{
					"filename",
					symbols = {
						modified = "[ + ]", -- Text to show when the file is modified.
						readonly = "[ - ]", -- Text to show when the file is non-modifiable or readonly.
						unnamed = "[NN ]", -- Text to show for unnamed buffers.
						newfile = "[New]", -- Text to show for new created file before first writting
					},
				},
				"tabs",
				-- "buffers",
			},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		extensions = { "nvim-tree" },
	})
end

return M
