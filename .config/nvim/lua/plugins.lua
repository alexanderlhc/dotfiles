-- Packer Automatic Installation
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

return require('packer').startup{function()

  -- Theme/Style
  use {
    'norcalli/nvim-colorizer.lua',
    config = [[ require('plugin-configs/colorizer') ]]
  }
  use "projekt0n/github-nvim-theme"

  -- Fuzzy Find
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      {'nvim-lua/plenary.nvim'}
    },
    config = [[ require('plugin-configs/telescope') ]]
  }

  use {
    'lewis6991/spellsitter.nvim',
    requires = {{ 'nvim-telescope/telescope.nvim' }},
    config = [[ require('plugin-configs.treesitter') ]]
  }

  -- File Browser
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {{ 'kyazdani42/nvim-web-devicons' }},
    config = [[ require('plugin-configs.nvimtree') ]]
  }

  -- Improve location specific jumps
  use 'justinmk/vim-sneak'

  -- "<[(`' Automatically create as pairs
  use {
    'windwp/nvim-autopairs',
    config = function ()
      require('nvim-autopairs').setup{}
    end
  }

  -- Comments how it's supposed to be
  use {
    'numToStr/Comment.nvim',
    config = [[ require('plugin-configs.comment') ]],
    requires = {{ 'JoosepAlviste/nvim-ts-context-commentstring' }}
  }


  -- Surroundings modification vastly improved
  use 'tpope/vim-surround'

  -- ActivityWatcher
  use 'ActivityWatch/aw-watcher-vim'

  ---- Git git dit dat git
  -- git w/o leaving nvim
  use 'tpope/vim-fugitive'
  -- git decorations
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function ()
      require('gitsigns').setup()
    end
  }

  use {
    'sindrets/diffview.nvim',
    config = function ()
      require'plugin-configs.diffview'
    end
  }

  ------- LSP and Languages

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

  -- Parser almost too good
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = [[ require('plugin-configs/treesitter') ]]
  }

  -- TypeScript
  use({ "jose-elias-alvarez/null-ls.nvim",
    config = function()
        require("null-ls").config({})
        require("lspconfig")["null-ls"].setup({})
    end,
    requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
  })
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  -- Latex - Markdown - Text
  use {
    "brymer-meneses/grammar-guard.nvim",
    requires = "neovim/nvim-lspconfig"
  }

end, config = {
  compile_path = vim.fn.stdpath('config')..'/plugin/packer_compiled.lua'
  }
}
