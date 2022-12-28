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
			lualine_c = { "filename" },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	})
end

return M
