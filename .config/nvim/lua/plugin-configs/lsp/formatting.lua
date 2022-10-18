local util = require("util.notifiers")

local M = {}

M.autoformat = true

function M.toggle()
	M.autoformat = not M.autoformat
	if M.autoformat then
		util.info("Auto format ON", "Formatting")
	else
		util.warn("Auto format OFF", "Formatting")
	end
end

function M.format()
	if M.autoformat then
		if vim.lsp.buf.format then
			vim.lsp.buf.frsa  ormat()
		else
			vim.lsp.buf.formatting_sync()
		end
		util.info("Your computer mother was here, cleaning.", "Formatting")
	end
end

function M.setup(client, buf)
	local ft = vim.api.nvim_buf_get_option(buf, "filetype")
	local nls = require("plugin-configs.null-ls")

	local enable = false
	if nls.has_formatter(ft) then
		enable = client.name == "null-ls"
	else
		enable = not (client.name == "null-ls")
	end

	if client.name == "tsserver" then
		enable = false
	end

	client.server_capabilities.documentFormattingProvider = enable
	-- format on save
	if client.server_capabilities.documentFormattingProvider then
		vim.cmd([[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua require("plugin-configs.lsp.formatting").format()
      augroup END
    ]])
	end
end

return M
