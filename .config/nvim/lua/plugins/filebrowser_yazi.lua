vim.pack.add({ "https://github.com/mikavilpas/yazi.nvim", "https://github.com/nvim-lua/plenary.nvim" })

---@module "yazi"

require("yazi").setup(
  ---@type YaziConfig
  {
    integrations = {
      grep_in_selected_files = "fzf-lua",
      grep_in_directory = "fzf-lua",
   },
  }
)

vim.keymap.set("n", "<leader>-", function()
  require("yazi").yazi()
end)
