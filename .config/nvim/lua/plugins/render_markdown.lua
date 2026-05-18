vim.pack.add({
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("render-markdown").setup({
	file_types = { "markdown" },
	change_events = { "DiagnosticChanged" },
	anti_conceal = {
		enabled = false,
	},
	link = {
		wiki = {
			body = function(ctx)
				local diagnostics = vim.diagnostic.get(ctx.buf, {
					lnum = ctx.row,
					severity = vim.diagnostic.severity.HINT,
				})

				for _, diagnostic in ipairs(diagnostics) do
					if diagnostic.source == "zk"
						and diagnostic.col <= ctx.start_col
						and diagnostic.end_col >= ctx.end_col
					then
						return diagnostic.message
					end
				end

				return nil
			end,
		},
	},
})
