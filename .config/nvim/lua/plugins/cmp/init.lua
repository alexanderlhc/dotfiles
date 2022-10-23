local cmp = require("cmp")
local luasnip = require("luasnip")
local icons = require("config.icons").cmp
local mappings = require("plugins.cmp.mappings")
require("luasnip.loaders.from_vscode").lazy_load()

local M = {}

-- required by cmp
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Settings

local snippet = {
	expand = function(args)
		luasnip.lsp_expand(args.body)
	end,
}

local sources = {
	{ name = "path" },
	{ name = "nvim_lsp", keyword_length = 3 },
	{ name = "buffer", keyword_length = 3 },
	{ name = "luasnip", keyword_length = 2 },
	{ name = "emoji" },
	{ name = "nvim_lsp_signature_help" },
}

local window = {
	documentation = cmp.config.window.bordered(),
}

local formatting = {
	fields = { "menu", "abbr", "kind" },
	format = function(entry, item)
		item.menu = icons[entry.source.name]
		return item
	end,
}

function M.setup()
	--local neogen = require("neogen")

	cmp.setup({
		snippet = snippet,
		sources = sources,
		window = window,
		formatting = formatting,
		mapping = mappings,
	})
end

return M
