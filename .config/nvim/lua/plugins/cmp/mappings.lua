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

-- copilot
local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
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
	["<CR>"] = cmp.mapping.confirm({
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	}),
	["<Tab>"] = vim.schedule_wrap(function(fallback)
		if cmp.visible() and has_words_before() then
			cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
		else
			fallback()
		end
	end),
}

return mapping
