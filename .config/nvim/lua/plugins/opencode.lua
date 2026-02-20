vim.pack.add({
	{ src = "https://github.com/sudo-tee/opencode.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
}, { load = true })

require("opencode").setup({
	preferred_picker = "fzf",
	preferred_completion = "blink",
})
