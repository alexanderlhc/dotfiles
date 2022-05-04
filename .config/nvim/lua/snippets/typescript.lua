local ls = require'luasnip'
local s = ls.s
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local t = ls.text_node
local fmt = require'luasnip.extras.fmt'.fmt
local rep = require'luasnip.extras'.rep

local same = function(index)
  return f(function(arg)
    return arg[1][1]
  end, {index})
end

local jestSnippets = {
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
  s("cl", fmt([[console.log({})]], { i(0) })),
  s("clg", fmt([[console.log('{}', {})]], { i(1), same(1) })),
}

-- Merge all snippets
local allSnippets = { }
local n = 0;

for _, v in ipairs(jestSnippets) do n=n+1; allSnippets[n] = v end
for _, v in ipairs(typescriptSnippets) do n=n+1; allSnippets[n] = v end

return allSnippets
