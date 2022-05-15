local ls = require "luasnip"
local snippet = ls.s
local t = ls.t

return {
  --snippet("simple", t "wow, you were right!"),
  --snippet("with newline", t({ "wow", "", "you can skip lines" })),
  snippet({
    name= "Date YYYY-MM-DD",
    dscr = "Date formmated as YYYY-MM-DD, as of now",
    trig = "date"
  }, t(os.date("%Y-%m-%d")))
}
