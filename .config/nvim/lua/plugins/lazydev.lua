vim.pack.add({
	{ src = "https://github.com/folke/lazydev.nvim" },
})

-- Configures lua_ls for editing this config: resolves `require` paths against
-- installed plugins and only pulls in library types when they are referenced.
require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})
