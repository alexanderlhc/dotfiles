--- Map a key combination to a command
---@param modes string|string[]: The mode(s) to map the key combination to
---@param lhs string: The key combination to map
---@param rhs string|function: The command to run when the key combination is pressed
---@param opts table: Options to pass to the keymap
local map = function(modes, lhs, rhs, opts)
	local options = { silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	if type(modes) == "string" then
		modes = { modes }
	end
	for _, mode in ipairs(modes) do
		vim.keymap.set(mode, lhs, rhs, options)
	end
end

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })


--
-- LSP
--
-- Function to check if a method is supported
local function has(buffer, method)
	if type(method) == "table" then
		for _, m in ipairs(method) do
			if has(buffer, m) then
				return true
			end
		end
		return false
	end
	method = method:find("/") and method or "textDocument/" .. method
	local clients = vim.lsp.get_active_clients({ bufnr = buffer })
	for _, client in ipairs(clients) do
		if client.supports_method(method) then
			return true
		end
	end
	return false
end

-- Add the following LSP key mappings
local function set_lsp_keymaps(buffer)
	if has(buffer, "definition") then
		map("n", "gd", vim.lsp.buf.definition, { desc = "Goto [D]efinition", buffer = buffer })
	end
	if has(buffer, "references") then
		map("n", "gr", vim.lsp.buf.references, { desc = "[R]eferences", nowait = true, buffer = buffer })
	end
	if has(buffer, "implementation") then
		map("n", "gI", vim.lsp.buf.implementation, { desc = "Goto [I]mplementation", buffer = buffer })
	end
	if has(buffer, "typeDefinition") then
		map("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto T[y]pe Definition", buffer = buffer })
	end
	if has(buffer, "declaration") then
		map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto [D]eclaration", buffer = buffer })
	end
	map("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = buffer })
	if has(buffer, "signatureHelp") then
		map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = buffer })
		map("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = buffer })
	end
	if has(buffer, "codeAction") then
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = buffer })
	end
	if has(buffer, "codeLens") then
		map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens", buffer = buffer })
		map("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens", buffer = buffer })
	end
	if has(buffer, { "workspace/didRenameFiles", "workspace/willRenameFiles" }) then
		map("n", "<leader>cR", vim.lsp.buf.rename, { desc = "Rename File", buffer = buffer })
	end
	if has(buffer, "rename") then
		map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = buffer })
	end
end

-- Call this function when the LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		set_lsp_keymaps(args.buf)
	end,
})
