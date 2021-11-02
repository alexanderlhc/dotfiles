return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
    'hrsh7th/nvim-cmp', -- Autocompletion plugin
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
    'L3MON4D3/LuaSnip' -- Snippets plugin
  }
  use { 'ms-jpq/coq_nvim' }

  -- use { 'antoinemadec/FixCursorHold.nvim' }

  -- Currently installed (manually):
  -- efm yaml vim php json java html graphql dockerfile css bash typescript lua latex

  -- use {
  --   'hrsh7th/nvim-compe',
  --   requires = {{ 'hrsh7th/vim-vsnip', 'hrsh7th/vim-vsnip-integ', 'rafamadriz/friendly-snippets' }}
  -- }
  -- use 'hrsh7th/cmp-nvim-lsp' -- hmm
  -- use 'hrsh7th/nvim-cmp'
  -- use 'rafamadriz/friendly-snippets'
  -- use 'hrsh7th/cmp-vsnip'
  -- use 'hrsh7th/vim-vsnip'

  use 'xuhdev/vim-latex-live-preview'

  -- git
  use {
    "lewis6991/gitsigns.nvim",
    wants = "plenary.nvim",
    config = [[require("plugins.gitsigns")]],
  }

  use { 'sindrets/diffview.nvim' }

  use { 'windwp/nvim-autopairs' }

  -- use 'glepnir/lspsaga.nvim'

  -- TypeScript
  -- use({ "jose-elias-alvarez/null-ls.nvim",
  --   config = function()
  --       require("null-ls").config({})
  --       require("lspconfig")["null-ls"].setup({})
  --   end,
  --   requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
  -- })
  -- use 'jose-elias-alvarez/nvim-lsp-ts-utils'


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

  use { 'norcalli/nvim-colorizer.lua' }

  --use {
  --  'christianchiarulli/nvcode-color-schemes.vim',
  --  requires = {{ 'nvim-treesitter/nvim-treesitter' }}
  --}

  use "projekt0n/github-nvim-theme"
  --use { 'rakr/vim-one' }
  --use "Pocco81/Catppuccino.nvim"

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {{ 'kyazdani42/nvim-web-devicons' }}
  }

  use 'justinmk/vim-sneak'

  use 'tpope/vim-commentary'

  use 'tpope/vim-surround'

  use 'tpope/vim-fugitive'

  -- use 'airblade/vim-gitgutter'

end)
