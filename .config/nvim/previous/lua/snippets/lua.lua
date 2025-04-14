local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	--- MODULE ---
	s({
		trig = "req",
		name = "Require",
	}, fmt("require(" .. '"' .. "{}" .. '"' .. ")", i(1, "module"))),

	s(
		{
			trig = "m",
			name = "Module",
		},
		fmt(
			[[
      local M = {{}}
      M.{}
      return M
      ]],
			i(0)
		)
	),

	--- FUNCTION ---
	s(
		{
			trig = "fun",
			name = "Function",
		},
		fmt(
			[[
      local {} = function({})
        {}
      end
      ]],
			{
				i(1, "_"),
				i(2),
				i(0),
			}
		)
	),

	s(
		{
			trig = "fune",
			name = "Function Expression",
		},
		fmt(
			[[
      function({})
        {}
      end
      ]],
			{
				i(1),
				i(0),
			}
		)
	),
}
