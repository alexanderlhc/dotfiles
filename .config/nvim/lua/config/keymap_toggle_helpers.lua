local M = {}

--- Toggle a Neovim option between two values.
-- @param opt The option name to toggle.
-- @param off_value The value representing the "off" state.
-- @param on_value The value representing the "on" state.
local function toggle_option(opt, off_value, on_value)
	local current_value = vim.o[opt]
	if current_value == off_value then
		vim.o[opt] = on_value
	else
		vim.o[opt] = off_value
	end
end

--- Toggle a boolean Neovim option.
-- @param opt The option name to toggle.
local function toggle_boolean_option(opt)
	vim.o[opt] = not vim.o[opt]
end

--- Toggles the 'spell' option in Neovim.
function M.toggle_spell()
	toggle_boolean_option("spell")
end

--- Toggles the 'wrap' option in Neovim.
function M.toggle_wrap()
	toggle_boolean_option("wrap")
end

--- Toggles the 'relativenumber' option in Neovim.
function M.toggle_relative_number()
	toggle_boolean_option("relativenumber")
end

--- Toggles the diagnostic virtual text in Neovim.
function M.toggle_diagnostics()
	vim.diagnostic.config({
		virtual_text = not vim.diagnostic.config().virtual_text,
	})
end

--- Toggles the line number visibility in Neovim.
function M.toggle_line_number()
	toggle_boolean_option("number")
end

--- Toggles the 'conceallevel' option between 0 and 2 or the current 'conceallevel'.
function M.toggle_conceal_level()
	local new_value = vim.o.conceallevel > 0 and 0 or 2
	toggle_option("conceallevel", 0, new_value)
end

--- Toggles the 'showtabline' option between 0 and 2 or the current 'showtabline'.
function M.toggle_showtabline()
	local new_value = vim.o.showtabline > 0 and 0 or 2
	toggle_option("showtabline", 0, new_value)
end

--- Toggles the 'background' option between 'light' and 'dark'.
function M.toggle_background()
	toggle_option("background", "light", "dark")
end

function M.lsp_toggle_inlay_hints(client, bufnr)
	if not client then
		return
	end

	local has_hint =
		require("config.client_supports_method").client_supports_method(client, "textDocument/inlayHint", bufnr)

	if not has_hint then
		return
	end

	M.map("n", "<leader>th", function()
		local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
		vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
	end, {
		buffer = bufnr,
		desc = "[T]oggle Inlay [H]ints",
		silent = true,
	})
end

return M
