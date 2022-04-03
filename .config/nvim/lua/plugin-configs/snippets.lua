local ls = require"luasnip"
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local events = require("luasnip.util.events")


ls.config.set_config {
  history = true, -- Snippets that were exited can still be jumped back into
  update_events = 'TextChanged,TextChangedI', -- events trigger an update (default: InsertLeave)
  enable_autosnippets = true, -- (default: false)

  ext_opts = {
      -- these ext_opts are applied when the node is active (eg. it has been
      -- jumped into, and not out yet).
      active =
      -- this is the table actually passed to `nvim_buf_set_extmark`.
      {
          -- highlight the text inside the node red.
          hl_group = "GruvboxRed"
      },
      -- these ext_opts are applied when the node is not active, but
      -- the snippet still is.
      passive = {
          -- add virtual text on the line of the node, behind all text.
          virt_text = {{"virtual text!!", "GruvboxBlue"}}
      },
      -- and these are applied when both the node and the snippet are inactive.
     snippet_passive = {}
  }
}

require("luasnip.loaders.from_vscode").load()
require("luasnip.loaders.from_vscode").lazy_load() -- friendly-snippets
