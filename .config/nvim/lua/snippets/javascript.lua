local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local quote = '"'

return {
  --- CONSOLE ---
  s({
    trig = "cl",
    name = "Console Log",
  }, fmt("console.log({})", i(1))),

  s({
    trig = "ci",
    name = "Console Info",
  }, fmt("console.info({})", i(1))),

  s({
    trig = "cd",
    name = "Console Debug",
  }, fmt("console.debug({})", i(1))),

  s({
    trig = "ce",
    name = "Console Error",
  }, fmt("console.error({})", i(1))),

  --- MODULE ---
  s(
    {
      trig = "im",
      name = "Import",
    },
    fmt("import {{ {} }} from " .. quote .. "{}" .. quote, {
      i(2),
      i(1),
    })
  ),

  s(
    {
      trig = "imd",
      name = "Import Default",
    },
    fmt("import {} from " .. quote .. "{}" .. quote, {
      d(2, function(args)
        local name = "_"

        local parts = vim.split(args[1][1], "/")
        if parts[#parts] ~= "" then
          name = parts[#parts]
        end

        return sn(nil, i(1, name))
      end, 1),
      i(1),
    })
  ),

  s({
    trig = "ex",
    name = "Export",
  }, t("export ")),

  s({
    trig = "exd",
    name = "Export Default",
  }, t("export default ")),

  --- FUNCTION ---
  s(
    {
      trig = "fun",
      name = "Function",
    },
    fmt(
      [[
      const {} = ({}) => {{
        {}
      }}
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
      trig = "afun",
      name = "Async Function",
    },
    fmt(
      [[
      const {} = async ({}) => {{
        {}
      }}
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
      ({}) => {{
        {}
      }}
      ]],
      {
        i(1),
        i(0),
      }
    )
  ),

  s(
    {
      trig = "afune",
      name = "Async Function Expression",
    },
    fmt(
      [[
      async ({}) => {{
        {}
      }}
      ]],
      {
        i(1),
        i(0),
      }
    )
  ),

  --- TRY CATCH ---
  s(
    {
      trig = "tc",
      name = "Try Catch",
    },
    fmt(
      [[
      try {{
        {}
      }} catch (error) {{
        {}
      }}
      ]],
      {
        i(1),
        i(2, "console.error(error);"),
      }
    )
  ),
}
