local keymap_utils = require("config.keymap_utils")
local map = keymap_utils.map
local has = keymap_utils.has

-- Define the LSP keymap setting function
local function set_lsp_keymaps(buffer)
	print("LSP KEYMAPS SET")

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

-- Export the function in a table
return {
	set_lsp_keymaps = set_lsp_keymaps,
}
