local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

return {

	s(
		{
			trig = "rh",
			name = "React Hook",
		},
		fmt(
			[[
      const {} = ({}) => {{
        {}

        return {}
      }}
      ]],
			{
				i(1),
				i(2),
				i(0),
				c(3, {
					fmt("[{}]", i(1)),
					fmt("{{ {} }}", i(1)),
				}),
			}
		)
	),

	s(
		{
			trig = "state",
			name = "React useState",
		},
		fmt("const [{}, {}] = useState({})", {
			i(1, "state"),
			f(function(args)
				return "set" .. args[1][1]:gsub("^%l", string.upper)
			end, 1),
			i(2),
		})
	),

	s(
		{
			trig = "effect",
			name = "React useEffect",
		},
		fmt(
			[[
      useEffect(() => {{
        {}
      }}, [{}])
      ]],
			{
				i(0),
				i(1),
			}
		)
	),
}
