local cmp = require("cmp")
local luasnip = require("luasnip")

local select_opts = { behavior = cmp.SelectBehavior.Select }

local function next_in_completed(fallback)
	if luasnip.jumpable(1) then
		luasnip.jump(1)
	else
		fallback()
	end
end

local function prev_in_completed(fallback)
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	else
		fallback()
	end
end

local mapping = {

	-- navigation
	["<C-j>"] = cmp.mapping.select_next_item(select_opts),
	["<C-k>"] = cmp.mapping.select_prev_item(select_opts),
	["<C-l>"] = cmp.mapping(next_in_completed, { "i", "s" }),
	["<C-h>"] = cmp.mapping(prev_in_completed, { "i", "s" }),

	-- documenation
	["<C-b>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),

	-- complete, end
	["<C-e>"] = cmp.mapping.close(),
	--["<C-e>"] = cmp.mapping.abort(),
	["<C-space>"] = cmp.mapping.complete({}),
	["<C-o>"] = cmp.mapping.confirm({ select = true }),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
}

return mapping
