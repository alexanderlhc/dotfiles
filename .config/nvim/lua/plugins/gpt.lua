return {
  "robitx/gp.nvim",
  config = function()
    require("gp").setup({
      openai_api_key = os.getenv("OPENAI_API_KEY"),
      chat_model = { model = "gpt-4", temperature = 0.7, top_p = 1 },
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
