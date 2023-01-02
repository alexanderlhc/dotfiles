local M = {}

local nls = require("null-ls")
local builtins = nls.builtins

function M.setup(options)
	local sources = {
		builtins.formatting.stylua,
		builtins.formatting.prettierd,
		builtins.formatting.fixjson,
		builtins.formatting.shfmt,
		builtins.formatting.shellharden,
		builtins.diagnostics.eslint_d,
		builtins.diagnostics.tsc,
		builtins.diagnostics.zsh,
		builtins.code_actions.eslint_d,
		builtins.code_actions.refactoring,
		builtins.code_actions.shellcheck,
		builtins.code_actions.gitsigns,
	}
	nls.setup({
		sources = sources,
		on_attach = options.on_attach,
	})
end

function M.has_formatter(ft)
	local sources = require("null-ls.sources")
	local available = sources.get_available(ft, "NULL_LS_FORMATTING")
	return #available > 0
end

return M
