local M = {}

function M.setup()
	require("neogen").setup({
		snippet_engine = "luasnip",
		enabled = true,
		languages = {
			lua = {
				template = {
					annotation_convention = "ldoc",
				},
			},
			javascript = {
				template = {
					annotation_convention = "jsdoc",
				},
			},
			typescript = {
				template = {
					annotation_convention = "tsdoc",
				},
			},
			typescriptreact = {
				template = {
					annotation_convention = "tsdoc",
				},
			},
		},
	})
end

return M
