return {
  "robitx/gp.nvim",
  config = function()
    require("gp").setup({
      openai_api_key = os.getenv("OPENAI_API_KEY"),
      agents = {
        {
          name = "ChatGPT4 Fast",
          chat = true,
          command = false,
          model = { model = "gpt-4-1106-preview", temperature = 0.8, top_p = 1 },
          system_prompt = "You're an AI working as a coding expert and assistant."
              .. "You'll provide clear and technical answers, leaving out beginner jargon"
              .. "You correct the errors (code and in question), explain the solution."
              .. "Answers are kept concise and to the point."
        }
      },
      hooks = {
        BufferChatNew = function(gp, _)
          -- call GpChatNew command in range mode on whole buffer
          vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
        end,
      },
    })
  end,
  keys = {
    {
      "<leader>cbn",
      "<Cmd>GpChatNew<CR>",
      desc = "New Chat"
    },
    {
      "<leader>cbp",
      ":<C-u>'<,'>GpChatPaste<cr>",
      mode = "v",
      desc = "Paste to Chat"
    },
    {
      "<leader>cbC",
      "<Cmd>GpContext<CR>",
      desc = "Visual GpContext"
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
