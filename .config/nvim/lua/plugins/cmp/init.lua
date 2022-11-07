local cmp = require("cmp")
local luasnip = require("luasnip")
local icons = require("config.icons").cmp
local mappings = require("plugins.cmp.mappings")
require("luasnip.loaders.from_vscode").lazy_load()
local completion = require("null-ls.builtins._meta.completion")

-- autopairs
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

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
	{ name = "nvim_lsp_signature_help" },
	{ name = "copilot" },
	{ name = "luasnip", keyword_length = 2 },
	{ name = "path" },
	{ name = "nvim_lsp", keyword_length = 3 },
	{ name = "buffer", keyword_length = 3 },
	{ name = "emoji" },
}

local window = {
	documentation = cmp.config.window.bordered(),
	completion = cmp.config.window.bordered(),
}

local formatting = {
	fields = { "menu", "abbr", "kind" },
	format = function(entry, item)
		item.menu = icons[entry.source.name]
		return item
	end,
}

local experimental = {
	ghost_text = true, -- inlay completion hints
}

function M.setup()
	--local neogen = require("neogen")

	cmp.setup({
		snippet = snippet,
		sources = sources,
		window = window,
		formatting = formatting,
		mapping = mappings,
		experimental = experimental,
	})
end

return M
