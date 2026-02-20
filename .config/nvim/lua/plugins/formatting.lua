vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/NMAC427/guess-indent.nvim" },
})

-- -------------------
-- CONFORM
require("conform").setup({
	notify_on_error = false,
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters = {
		biome = {
			prefer_local = "node_modules/.bin",
		},
	},
	formatters_by_ft = {
		javascript = { "biome" },
		javascriptreact = { "biome" },
		typescript = { "biome" },
		typescriptreact = { "biome" },
		json = { "biome" },
		jsonc = { "biome" },
		css = { "biome" },
		scss = { "biome" },
		less = { "biome" },
		lua = { "stylua" },
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file or range (Conform)" })

-- -------------------
-- GUESS-INDENT
require("guess-indent").setup({})
