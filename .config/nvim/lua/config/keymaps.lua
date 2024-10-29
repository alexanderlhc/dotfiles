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
	local clients = vim.lsp.get_clients({ bufnr = buffer })
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

local function bufremove(buf)
	buf = buf or 0
	buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

	if vim.bo.modified then
		local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
		if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
			return
		end
		if choice == 1 then -- Yes
			vim.cmd.write()
		end
	end

	for _, win in ipairs(vim.fn.win_findbuf(buf)) do
		vim.api.nvim_win_call(win, function()
			if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
				return
			end
			-- Try using alternate buffer
			local alt = vim.fn.bufnr("#")
			if alt ~= buf and vim.fn.buflisted(alt) == 1 then
				vim.api.nvim_win_set_buf(win, alt)
				return
			end

			-- Try using previous buffer
			local has_previous = pcall(vim.cmd, "bprevious")
			if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
				return
			end

			-- Create new listed buffer
			local new_buf = vim.api.nvim_create_buf(true, false)
			vim.api.nvim_win_set_buf(win, new_buf)
		end)
	end
	if vim.api.nvim_buf_is_valid(buf) then
		pcall(vim.cmd, "bdelete! " .. buf)
	end
end

map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", bufremove, { desc = "Delete Buffer" })
