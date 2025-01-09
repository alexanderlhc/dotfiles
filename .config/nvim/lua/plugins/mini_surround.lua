local maps = {
  { key = "sa", desc = "Add surrounding", mode = { "n", "v" } },
  { key = "sd", desc = "Delete surrounding" },
  { key = "sf", desc = "Find right surrounding" },
  { key = "sF", desc = "Find left surrounding" },
  { key = "sh", desc = "Highlight surrounding" },
  { key = "sr", desc = "Replace surrounding" },
  { key = "sn", desc = "Update n_lines" },
}

local keys = vim.tbl_map(function(m)
  return { m.key, desc = m.desc, mode = m.mode }
end, maps)

local mappings = {
  add = maps[1].key,
  delete = maps[2].key,
  find = maps[3].key,
  find_left = maps[4].key,
  highlight = maps[5].key,
  replace = maps[6].key,
  update_n_lines = maps[7].key,
}

return {
  "echasnovski/mini.surround",
  recommended = true,
  keys = keys,
  opts = { mappings = mappings },
}
