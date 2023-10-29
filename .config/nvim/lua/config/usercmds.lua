vim.api.nvim_create_user_command("LuaSnipEdit", ':lua require("luasnip.loaders").edit_snippet_files()', {})
vim.api.nvim_create_user_command("ToggleBackground", function()
	vim.o.background = vim.o.background == "dark" and "light" or "dark"
end, {})
