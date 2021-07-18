return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'
  -- Currently installed (manually):
  -- efm yaml vim php json java html graphql dockerfile css bash typescript lua latex

  use 'ayu-theme/ayu-vim'

  use 'justinmk/vim-sneak'

  use 'tpope/vim-commentary'

end)
