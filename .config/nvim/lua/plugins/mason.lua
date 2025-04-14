return {
  "williamboman/mason.nvim",
  dependencies = { 
	"williamboman/mason-lspconfig.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim"
  },
  config = function()
    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = {
        "html",
        "cssls",
        "vtsls",
        "jsonls",
        "yamlls",
        "lua_ls",
        "bashls",
      },
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        "biome",
        "shfmt",
        "stylua",
      },
    })
  end,
}
