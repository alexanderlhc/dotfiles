local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup{function()
  -- use 'wbthomason/packer.nvim'

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }
  -- Completion
  use {
    'hrsh7th/nvim-cmp', -- Autocompletion plugin
    requires = {
      'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
      'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline'
    },
    config = [[ require('plugin-configs/completion')]]
  }
  -- Snippets
  use {
    'L3MON4D3/LuaSnip', -- Snippets plugin
    requires = {"rafamadriz/friendly-snippets"},
    config = [[ require('plugin-configs/snippets') ]]
  }

  -- git
  -- use {
  --   "lewis6991/gitsigns.nvim",
  --   wants = "plenary.nvim",
  --   config = [[require("plugins.gitsigns")]],
  -- }
  use { 'sindrets/diffview.nvim' }

  -- use 'glepnir/lspsaga.nvim'

  -- TypeScript
  use({ "jose-elias-alvarez/null-ls.nvim",
    config = function()
        require("null-ls").config({})
        require("lspconfig")["null-ls"].setup({})
    end,
    requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
  })
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  -- Latex - Markdown - Language
  use {
    "brymer-meneses/grammar-guard.nvim",
    requires = "neovim/nvim-lspconfig"
  }

  -- Theme/Style
  use { 'norcalli/nvim-colorizer.lua' }
  use "projekt0n/github-nvim-theme"


  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = [[ require('plugin-configs/telescope') ]]
  }

  use {
    'lewis6991/spellsitter.nvim',
    requires = {{ 'nvim-telescope/telescope.nvim' }}
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {{ 'kyazdani42/nvim-web-devicons' }}
  }

  use 'justinmk/vim-sneak'

  use { 'windwp/nvim-autopairs' }

  use 'tpope/vim-commentary'

  use 'tpope/vim-surround'

  use 'tpope/vim-fugitive'

  -- use 'airblade/vim-gitgutter'

end, config = {
  compile_path = vim.fn.stdpath('config')..'/plugin/packer_compiled.lua'
  }
}
