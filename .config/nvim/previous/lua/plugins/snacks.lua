return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		animate = {
			enabled = true,
		},
		bigfile = {
			enabled = true,
			-- size = 1.5 * 1024 * 1024, -- 1.5MB
			notify = true,
		},
		-- bufdelete just helper funcs
		dashboard = {
			enabled = true,

			sections = {
				{ section = "header" },
				{
					pane = 2,
					section = "terminal",
					cmd = "colorscript -e square",
					height = 5,
					padding = 1,
				},
				{ section = "keys", gap = 1, padding = 1 },
				{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{
					pane = 2,
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = function()
						return Snacks.git.get_root() ~= nil
					end,
					cmd = "git status --short --branch --renames",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				},
				{ section = "startup" },
			},
		},
		-- debug:
		-- 	- Snacks.debug()
		-- 	- Snacks.debug.backtrace(msg, opts)
		-- 	- Snacks.debug.inspect(...)
		dim = {
			enabled = true,
		},
		indent = { enabled = false },
		input = { enabled = true },
		notifier = { enabled = true },
		-- notify:
		-- 	- Snacks.notify()
		-- 	- Snacks.notify.error(msg, opts)
		-- 	- Snacks.notify.info(msg, opts)
		-- 	- Snacks.notify.notify(msg, opts)
		-- 	- Snacks.notify.warn(msg, opts)
		quickfile = { enabled = true },
		-- rename. key mapped
		scope = { enabled = false },
		scratch = { enabled = false },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		-- terminal not using
		-- toggle good keymaps / which-key
		-- wim not using
		words = { enabled = true },
		-- zen mapped
	},
	keys = {
		{ "<leader>t", "", desc = "[T]oggles" },
		{
			"<leader>n",
			function()
				require("snacks").notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>bd",
			function()
				require("snacks").bufdelete()
			end,
			desc = "[B]uff [D]elete",
		},
		{
			"<leader>bD",
			function()
				require("snacks").bufdelete.other()
			end,
			desc = "[B]uff [D]elete Others: Close all buffers except current",
		},
		{
			"<leader>gb",
			function()
				require("snacks").git.blame_line()
			end,
			desc = "[G]it [B]lame Line",
		},
		{
			"<leader>gB",
			function()
				require("snacks").gitbrowse()
			end,
			desc = "[G]it [B]rowse",
		},
		{
			"<leader>cR",
			function()
				require("snacks").rename.rename_file()
			end,
			desc = "[C]ode [R]ename File",
		},
		{
			"<Leader>z",
			function()
				require("snacks").zen.zoom({ toggles = { dim = true, git_signs = false } })
			end,
			desc = "[Z]en",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Snacks.dim.enable()

				-- keymaps
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")
				Snacks.toggle.diagnostics():map("<leader>td")
				Snacks.toggle.line_number():map("<leader>tl")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>tc")
				Snacks.toggle.treesitter():map("<leader>tT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>tb")
				Snacks.toggle.inlay_hints():map("<leader>th")
				Snacks.toggle.dim():map("<leader>tD")
				Snacks.toggle({
					name = "Git Signs",
					get = function()
						return require("gitsigns.config").config.signcolumn
					end,
					set = function(state)
						require("gitsigns").toggle_signs(state)
					end,
				})
			end,
		})

		-- Rename
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesActionRename",
			callback = function(event)
				Snacks.rename.on_rename_file(event.data.from, event.data.to)
			end,
		})
	end,
}
