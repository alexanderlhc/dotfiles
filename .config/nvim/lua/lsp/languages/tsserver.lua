local ts_utils = require("nvim-lsp-ts-utils")
ts_utils.setup {
    -- Linter
    eslint_enable_code_actions = true,
    eslint_bin = "eslint_d",

    -- Formatter
    formatter = "prettier_d_slim",
    formatter_args = {"--stdin", "--stdin-filepath", "$FILENAME"},
    format_on_save = true
}
