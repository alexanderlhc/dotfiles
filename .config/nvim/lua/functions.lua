local nvim_command = vim.api.nvim_command

function ToggleBackground()
  nvim_command(':exec &bg=="light"? "set bg=dark" : "set bg=light"')
end

nvim_command(':command ToggleBackground lua ToggleBackground()')
