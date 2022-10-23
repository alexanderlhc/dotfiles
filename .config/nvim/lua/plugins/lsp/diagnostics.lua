local icons = require("config.icons")
local util = require("util")
local M = {}

function M.setup()
	-- setup icons
	for type, icon in pairs(icons.lsp) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- Float style
	local float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	}

	-- Options
	local diagnostic = {
		virtual_text = { spacing = 4, prefix = "●" },
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = float,
	}

	vim.diagnostic.config(diagnostic)
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

	vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
		local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
		pcall(vim.diagnostic.reset, ns)
		return true
	end
end

-- Toggle Diagnostics
local diagnostics_active = true

function M.toggle_diagnostics()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		util.info("Diagnostics enabled")
		vim.diagnostic.show()
	else
		util.info("Diagnostics disabled")
		vim.diagnostic.hide()
	end
end

return M
