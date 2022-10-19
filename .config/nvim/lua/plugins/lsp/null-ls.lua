local M = {}

local nls = require("null-ls")
local builtins = nls.builtins

local sources = {
        builtins.formatting.stylua,
        builtins.formatting.prettierd,
        builtins.formatting.fixjson,
        builtins.formatting.shfmt,
        builtins.formatting.shellharden,
        builtins.diagnostics.eslint_d,
        builtins.diagnostics.tsc,
        builtins.diagnostics.zsh,
        builtins.code_actions.eslint_d,
        builtins.code_actions.refactoring,
        builtins.code_actions.shellcheck,
    }


function M.setup(options) 
  nls.setup({
    sources = sources,
    on_attach = options.on_attach,
  })
end

return M
