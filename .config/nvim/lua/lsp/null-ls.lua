-- null-ls (formatter/linter)
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts

local null_ls = require("null-ls")

local b = require "null-ls".builtins

local sources = {
   -- JS html css stuff
   b.formatting.prettierd.with {
     filetypes = { "html", "json", "markdown", "css", "javascript", "javascriptreact", "typescript" },
   },

   -- Lua
   b.formatting.stylua,
   b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
   b.diagnostics.shellcheck,

   -- Gitsignsb
   b.code_actions.gitsigns,

   -- markdown
   b.diagnostics.markdownlint,

}

null_ls.setup {
  sources = sources,
  on_attach = on_attach
}

