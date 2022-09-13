local ls = require "luasnip"
local snippet = ls.s
local t = ls.t
local s = ls.s
local i = ls.insert_node

return {
  snippet({
    name= "Message type: fix",
    dscr = "Git commit message for fixing a bug",
    trig = "f"
  }, t("fixes: "), i("some bug"))
    -- t(i("fix", s(" "), s("#", "1")))),
}
