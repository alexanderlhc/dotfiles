vim.pack.add({ { src = 'https://github.com/Saghen/blink.cmp', version = vim.version.range('*') } },
{ "https://github.com/L3MON4D3/LuaSnip" },
{ "https://github.com/rafamadriz/friendly-snippets" }
)

require("blink.cmp").setup({ })
