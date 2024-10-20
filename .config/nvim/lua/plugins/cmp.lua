local MAX_INDEX_FILE_SIZE = 4000
local sources = {
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
					if
						vim.api.nvim_buf_is_loaded(bufnr)
						and vim.api.nvim_buf_line_count(bufnr) < MAX_INDEX_FILE_SIZE
					then
						table.insert(bufs, bufnr)
					end
				end
				return bufs
			end,
		},
	},
}

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
	cmd = { "CmpInfo" },
	event = "InsertEnter *",
	opts = function()
		local cmp = require("cmp")

		vim.api.nvim_create_user_command("CmpInfo", function()
			cmp.status()
		end, {})

		local defaults = require("cmp.config.default")()
		local auto_select = true

		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

		local mapping = cmp.mapping.preset.insert({
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-e>"] = cmp.mapping.close(),
			["<C-y>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
		})

		local formatting = {}

		return {
			mapping = mapping,
			formatting = formatting,
			preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
			sources = sources,
			experimental = {
				ghost_text = {
					hl_group = "CmpGhostText",
				},
			},
			-- sorting = defaults.sorting,
		}
	end,
}
