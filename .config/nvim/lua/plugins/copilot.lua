return {
  "zbirenbaum/copilot.lua",
  config = function()
    require("copilot").setup(
      {
        suggestion = { enabled = false },
        panel = { enabled = false },
        formatters = {
          insert_text = require("copilot_cmp.format").remove_existing
        }
      }
    )
  end
}
