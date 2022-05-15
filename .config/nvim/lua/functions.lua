local nvim_command = vim.api.nvim_command

-- TODO: Check :help nvim_command() which suggests using: |nvim_cmd()| or |nvim_exec()|

function ToggleBackground()
  nvim_command(':exec &bg=="light"? "set bg=dark" : "set bg=light"')
end

nvim_command(':command ToggleBackground lua ToggleBackground()')
