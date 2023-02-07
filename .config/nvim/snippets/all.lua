local ls = require("luasnip")
local s = ls.snippet
local p = require("luasnip.extras").partial

return {
	-- current date
	s({ trig = "ymd", name = "Current date", dscr = "Insert the current date" }, {
		p(os.date, "%Y-%m-%d"),
	}),
}
