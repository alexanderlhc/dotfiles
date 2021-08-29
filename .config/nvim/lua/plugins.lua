return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'
  -- Currently installed (manually):
  -- efm yaml vim php json java html graphql dockerfile css bash typescript lua latex

  use {
    'hrsh7th/nvim-compe',
    requires = {{ 'hrsh7th/vim-vsnip', 'hrsh7th/vim-vsnip-integ', 'rafamadriz/friendly-snippets' }}
  }

  use 'glepnir/lspsaga.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  use {
    'lewis6991/spellsitter.nvim',
    requires = {{ 'nvim-telescope/telescope.nvim' }}
  }

  use {
    'christianchiarulli/nvcode-color-schemes.vim',
    requires = {{ 'nvim-treesitter/nvim-treesitter' }}
  }

  use { 'rakr/vim-one' }
  use "Pocco81/Catppuccino.nvim"

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {{ 'kyazdani42/nvim-web-devicons' }}
  }

  use 'justinmk/vim-sneak'

  use 'tpope/vim-commentary'

  use 'tpope/vim-surround'

  use 'tpope/vim-fugitive'

  use 'airblade/vim-gitgutter'

end)
