return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
	cmd = { "CmpInfo" },
	event = "InsertEnter *",
	config = function()
		local cmp = require("cmp")
		local MAX_INDEX_FILE_SIZE = 4000

		local mapping = cmp.mapping.preset.insert({
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-e>"] = cmp.mapping.close(),
			["<C-y>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
		})

		local formatting = {}

		cmp.setup({
			mapping = mapping,
			formatting = formatting,

			sources = {
				{ name = "nvim_lsp" },
				{ name = "path" },
				{
					name = "buffer",
					keyword_length = 4,
					options = {
						get_bufnrs = function()
							local bufs = {}
							for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
								-- Don't index giant files
								if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_line_count(bufnr) < MAX_INDEX_FILE_SIZE then
									table.insert(bufs, bufnr)
								end
							end
							return bufs
						end,
					},
				},
			},

		})

		vim.api.nvim_create_user_command("CmpInfo", function() cmp.status() end, {})
	end,
}
