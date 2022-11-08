local M = {}

local wk = require("which-key")

function M.setup(client, buffer)
	--local cap = client.server_capabilities

	local keymap_code = {
		name = "Code",
		r = { vim.lsp.buf.rename, "Rename" },
		a = { vim.lsp.buf.code_action, "Code Action" },
		d = { vim.diagnostic.open_float, "Line Diagnostics" },
		x = {
			d = { "<cmd>Telescope diagnostics<cr>", "Search Diagnostics" },
			o = { "<cmd>:TypescriptOrganizeImports<CR>", "Organize Imports" },
			R = { "<cmd>:TypescriptRenameFile<CR>", "Rename File" },
		},
	}

	local keymap_goto = {
		name = "Goto",
		b = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
		d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
		D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
		h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
		I = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
		r = { vim.lsp.buf.rename, "Rename" },
		-- f format

		["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Next Diagnostic" },
		["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Prev Diagnostic" },
		["[e"] = { "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", "Next Error" },
		["]e"] = { "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", "Prev Error" },
		["[w"] = {
			"<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARNING})<CR>",
			"Next Warning",
		},
		["]w"] = {
			"<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARNING})<CR>",
			"Prev Warning",
		},
	}

	local keymap_language = {
		i = { "<cmd>LspInfo<CR>", "Lsp Info" },
		["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
	}

	local keymap = {
		["c"] = keymap_code,
		["g"] = keymap_goto,
		keymap_language,
	}

	local options = {
		prefix = "<leader>",
	}

	wk.register(keymap, options)
end

return M
