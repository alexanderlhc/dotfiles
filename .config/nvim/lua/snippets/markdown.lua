local ls = require("luasnip")
local snippet = ls.s
local t = ls.t
local s = ls.s
local i = ls.insert_node
local func = ls.function_node

return {
	snippet({
		trig = "link",
		namr = "markdown_link",
		dscr = "Create markdown link [txt](url)",
	}, {
		t("["),
		i(1),
		t("]("),
		func(function(_, snip)
			return snip.env.TM_SELECTED_TEXT[1] or {}
		end, {}),
		t(")"),
		i(0),
	}),
}
