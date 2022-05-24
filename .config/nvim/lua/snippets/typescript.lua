local ls = require'luasnip'
local s = ls.s
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node
local fmt = require'luasnip.extras.fmt'.fmt

local same = function(index)
  return f(function(arg)
    return arg[1][1]
  end, {index})
end

local jestSnippets = {
  s("describe", {
    t("describe(\""), i(1, "what to describe"),
    t({"\", () => {", "  "}),
    i(2, "case"),
    t({"", "})" })
  }),
  s("it", {
    t("it(\""), i(1, "what is tested"),
    t({"\", () => {", "  "}),
    i(2, "case"),
    t({"", "});" })
  }),
-- describe("As observer", () => {
--   it("I get notified when subscribing", () => {

  -- s("describe", {
  --   t("describe(\""),
  --   i(1, "What to describe"),
  --   i("\", () => {",
  --     -- t({"\\"", () => {", "\t"}),
  --     i(2, "2Gief me the test"),
  --     t(".!", ")"),
  --   t("}")
  --   )
  -- }),
};

local typescriptSnippets = {
  -- Console Logs
  s("cl", fmt([[console.log({})]], { i(0) })),
  s("clg", fmt([[console.log('{}', {})]], { i(1), same(1) })),
}

-- Merge all snippets
local allSnippets = { }
local n = 0;

for _, v in ipairs(jestSnippets) do n=n+1; allSnippets[n] = v end
for _, v in ipairs(typescriptSnippets) do n=n+1; allSnippets[n] = v end

return allSnippets
