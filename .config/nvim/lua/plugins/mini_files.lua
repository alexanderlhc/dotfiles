local function open_cwd()
	local MiniFiles = require("mini.files")
	local buf_name = vim.api.nvim_buf_get_name(0)
	local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
	MiniFiles.open(path)
	MiniFiles.reveal_cwd()
end

local files_set_cwd = function()
	local MiniFiles = require("mini.files")
	local cur_entry_path = MiniFiles.get_fs_entry().path
	local cur_directory = vim.fs.dirname(cur_entry_path)
	if cur_directory ~= nil then
		vim.fn.chdir(cur_directory)
	end
end

local map_split = function(buf_id, lhs, direction, close_on_file)
	local rhs = function()
		local new_target_window
		local cur_target_window = require("mini.files").get_explorer_state().target_window
		if cur_target_window ~= nil then
			vim.api.nvim_win_call(cur_target_window, function()
				vim.cmd("belowright " .. direction .. " split")
				new_target_window = vim.api.nvim_get_current_win()
			end)

			require("mini.files").set_target_window(new_target_window)
			require("mini.files").go_in({ close_on_file = close_on_file })
		end
	end

	local desc = "Open in " .. direction .. " split"
	if close_on_file then
		desc = desc .. " and close"
	end
	vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
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
	config = function(_, opts)
		require("mini.files").setup(opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id

				vim.keymap.set(
					"n",
					opts.mappings and opts.mappings.change_cwd or "gc",
					files_set_cwd,
					{ buffer = args.data.buf_id, desc = "Set cwd" }
				)

				map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal or "<C-w>s", "horizontal", false)
				map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical or "<C-w>v", "vertical", false)
				map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S", "horizontal", true)
				map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V", "vertical", true)
			end,
		})
	end,
}
