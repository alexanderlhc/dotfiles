local M = {}
M.opt = false

function M.config()
	local db = require("dashboard")

	db.custom_center = {
		{
			icon = " ",
			desc = "Find File                                ",
			shortcut = "f",
			action = "Telescope find_files",
		},
		{
			icon = " ",
			desc = "Update Plugins                          ",
			action = "PackerSync",
			shortcut = "u",
		},
		{
			icon = "  ",
			desc = "File Browser                            ",
			action = "NvimTreeOpen",
			shortcut = "b",
		},
		{
			icon = "  ",
			desc = "Find Text                               ",
			action = "Telescope live_grep",
			shortcut = "t",
		},
		{
			icon = "  ",
			desc = "Recent Files                            ",
			action = "Telescope oldfiles",
			shortcut = "r",
		},
	}

	db.custom_header = {
		[[.__   __.  _______   ______   ____    ____  __  .___  ___.]],
		[[|  \ |  | |   ____| /  __  \  \   \  /   / |  | |   \/   |]],
		[[|   \|  | |  |__   |  |  |  |  \   \/   /  |  | |  \  /  |]],
		[[|  . `  | |   __|  |  |  |  |   \      /   |  | |  |\/|  |]],
		[[|  |\   | |  |____ |  `--'  |    \    /    |  | |  |  |  |]],
		[[|__| \__| |_______| \______/      \__/     |__| |__|  |__|]],
		[[                                                          ]],
	}

	db.noautocmd = true
end

return M
