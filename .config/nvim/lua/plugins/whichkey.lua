local M = {}

local wk = require("which-key")

local options_plugin = {
	window = {
		border = "single",
	},
	triggers_nowait = { "<leader>", "<space>" },
}

local options_normal = {
	mode = "n", -- Normal mode
	prefix = "<leader>",
}

local function keys_normal()
	local keymap = nil -- all keys
	local keymap_f = nil -- File search

	keymap_f = {
		name = "Find",
		f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Files" },
		b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
		h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
		m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
		g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
		c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
		w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
		t = { "<cmd>NvimTreeToggle<cr>", "File browser" },
	}

	keymap = {
		["w"] = { "<cmd>update!<CR>", "Save" },
		["q"] = { "<cmd>quit!<CR>", "Save" },
		y = { '"+y', "Copy {motion} to clipboard" },
		Y = { '"+Y', "Copy [count] lines to clipboard" },
		p = { '"+p', "Paste clipboard behind cursor" },
		P = { '"+P', "Paste clipboard before cursor" },
		["f"] = keymap_f,
	}

	wk.register(keymap, options_normal)
end

local options_visual = {
	mode = "v",
	prefix = "<leader>",
}

local function keys_visual()
	local keymap = nil -- all keys

	keymap = {
		["y"] = { '"+y', "Copy to clipboard" },
		["p"] = { '"+p', "Paste from clipboard" },
	}

	wk.register(keymap, options_visual)
end

function M.setup()
	wk.setup(options_plugin)
	keys_normal()
	keys_visual()
end

return M
