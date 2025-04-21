return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader><tab>", group = "[T]abs" },
			{ "<leader>T", group = "[T]oggles" },
			{ "<leader>b", group = "[b]uffer" },
			{ "<leader>c", group = "[c]ode" },
			{ "<leader>d", group = "[d]ap" },
			{ "<leader>f", group = "[f]ind/[f]ile" },
			{ "<leader>g", group = "[g]it" },
			{ "<leader>s", group = "[s]earch" },
			{
				"<leader>w",
				group = "windows",
				proxy = "<c-w>",
			},
			{ "<leader>x", group = "quickfi[x]", icon = { icon = "󱖫 ", color = "green" } },
			{ "[", group = "prev" },
			{ "]", group = "next" },
			{ "g", group = "goto" },
			{ "gx", desc = "Open with system app" },
			{ "z", group = "fold" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
