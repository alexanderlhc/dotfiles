vim.pack.add({"https://github.com/tinted-theming/tinted-nvim"})

local ok, tinted = pcall(require, "tinted")
if ok then tinted.setup() end
