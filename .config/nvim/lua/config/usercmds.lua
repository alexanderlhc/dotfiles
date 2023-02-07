vim.api.nvim_create_user_command("LuaSnipEdit", ':lua require("luasnip.loaders").edit_snippet_files()', {})
