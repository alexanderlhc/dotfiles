local ls = require "luasnip"
local t = ls.t
local s = ls.s
local i = ls.insert_node

local snippets = {
  s({
    name = "local module",
    dscr = "initiates a local module setup",
    trig = "lm",
  },
    { t { "local M = {}", "", "function M.setup()", "" }, i(1, ""), t { "", "end", "", "return M" } }
  ),
  s({
    name = "create function",
    dscr = "creates a named function",
    trig = "fu",
  },
    {
      t('function '), i(1, 'name'), t({'()', '  '}), i(2, 'body'), t({ '', 'end' }),
    }
  ),
  s({
    name = "if condition",
    dscr = "if and if my ass was pointy",
    trig = "if",
  },
    {
      t('if '), i(1, 'condition'), t({' then', '  '}), i(2, 'body'), t({ '', 'end' }),
    }
  )
}

return snippets
