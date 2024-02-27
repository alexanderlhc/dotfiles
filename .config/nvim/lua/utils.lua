local M = {}

function M.map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

function M.info(msg)
  vim.cmd("echohl Directory")
  M._echo_multiline(msg)
  vim.cmd("echohl None")
end

function M.warn(msg)
  vim.cmd("echohl WarningMsg")
  M._echo_multiline(msg)
  vim.cmd("echohl None")
end

function M.err(msg)
  vim.cmd("echohl ErrorMsg")
  M._echo_multiline(msg)
  vim.cmd("echohl None")
end

function M._echo_multiline(msg)
  for _, s in ipairs(vim.fn.split(msg, "\n")) do
    vim.cmd("echom '" .. s:gsub("'", "''") .. "'")
  end
end

function M.has(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

local enabled_diagnostics = true
function M.toggle_diagnostics()
  enabled_diagnostics = not enabled_diagnostics
  if enabled_diagnostics then
    vim.diagnostic.enable()
    M.info("Enabled diagnostics")
  else
    vim.diagnostic.disable()
    M.warn("Disabled diagnostics")
  end
end

function M.toggle(option, silent, values, scope)
  local target = scope == "global" and vim.g or vim.opt_local

  if values then
    if target[option]:get() == values[1] then
      target[option] = values[2]
    else
      target[option] = values[1]
    end
    if not silent then
      M.info("Set " .. option .. " to " .. target[option]:get(), { title = "Option" })
    end
    return
  end

  local current_value = (target[option] ~= nil) and target[option]:get() or false
  target[option] = not current_value

  if not silent then
    if target[option]:get() then
      M.info("Enabled " .. option, { title = "Option" })
    else
      M.warn("Disabled " .. option, { title = "Option" })
    end
  end
end

return M
