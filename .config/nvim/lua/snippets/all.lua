local ls = require "luasnip"
local snippet = ls.s

return {
  -- basic, don't need to know anything else
  --    arg 1: string
  --    arg 2: a node
  snippet("simple", t "wow, you were right!"),
}
