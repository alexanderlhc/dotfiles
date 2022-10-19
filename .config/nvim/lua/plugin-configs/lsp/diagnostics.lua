local M = {}

---
-- Diagnostic customization
---
M.signs = {
	Error = "✘",
	Warn = "▲",
	Hint = "⚑",
	Info = "",
}
function M.setup()
	-- See :help sign_define()
	vim.diagnostic.config({
		numhl = "",
		severity_sort = true,
		underline = true,
		update_in_insert = false,
		virtual_text = { prefix = "", spacing = 0 },
	})

	vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
		local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
		pcall(vim.diagnostic.reset, ns)
		return true
	end

	for type, icon in pairs(M.signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
end

return M
