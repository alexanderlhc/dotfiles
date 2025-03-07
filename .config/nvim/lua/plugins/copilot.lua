return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "BufReadPost",
	requires = {
		{ "giuxtaposition/blink-cmp-copilot" },
	},
	opts = {
		suggestion = {
			enabled = false,
			auto_trigger = true,
			keymap = {
				accept = false, -- handled by nvim-cmp / blink.cmp
				next = "<M-]>",
				prev = "<M-[>",
			},
		},
		panel = { enabled = false },
		filetypes = {
			markdown = true,
			help = true,
		},
	},
}
