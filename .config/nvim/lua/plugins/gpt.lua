return {
  "robitx/gp.nvim",
  config = function()
    require("gp").setup({
      openai_api_key = os.getenv("OPENAI_API_KEY"),
    })
  end,
  keys = {
    {
      "<leader>cbn",
      "<Cmd>GpChatNew<CR>",
      desc = "New Chat"
    },
    {
      "<leader>cbt",
      "<Cmd>GpChatToggle<CR>",
      desc = "Toggle Popup Chat"
    },
    {
      "<leader>cbf",
      "<Cmd>GpChatFinder<CR>",
      desc = "Chat Finder"
    }
  }
}
