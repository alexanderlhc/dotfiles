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
  use "RRethy/nvim-base16"
  use "sainnhe/everforest"
  use 'folke/tokyonight.nvim'

  -- Scroll Smooth
  use { 'karb94/neoscroll.nvim',
    config = [[ require('plugin-configs/neoscroll')]]
  }

  use { 'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = [[ require('plugin-configs/lualine')]]
  }

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
    config = [[ require('plugin-configs.spellsitter') ]]
  }

  -- File Browser
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {{ 'kyazdani42/nvim-web-devicons' }},
    config = [[ require('plugin-configs.nvimtree') ]]
  }

  -- Yank/Copy clipboard manager
  use {
    "AckslD/nvim-neoclip.lua",
    requires = {
      {'tami5/sqlite.lua', module = 'sqlite'},
      {'nvim-telescope/telescope.nvim'},
    },
    config = [[ require('plugin-configs.neoclip') ]]
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

  -- KeyMap
  use {
    "folke/which-key.nvim",
    config = [[ require('plugin-configs.which-key')]]
  }

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

  -- Octo GH Reviews
  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function ()
      require"octo".setup()
    end
  }

  ------- LSP and Languages

  use { 'github/copilot.vim' }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }

  use "onsails/lspkind-nvim" -- TODO

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      -- 'f3fora/cmp-spell',
      -- 'zbirenbaum/copilot-cmp',
      'hrsh7th/cmp-copilot',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path'
    },
    config = [[ require('plugin-configs.cmp') ]]
  }

  -- Snippets
  use {
    'L3MON4D3/LuaSnip', -- Snippets plugin
    -- requires = {"rafamadriz/friendly-snippets"},
    config = [[ require('plugin-configs/luasnip') ]]
  }

  -- Test
  use { 'ruanyl/coverage.vim' }

  -- Documentation
  use {
    "danymat/neogen",
    config = function()
        require('neogen').setup {
            enabled = true
        }
    end,
    requires = "nvim-treesitter/nvim-treesitter"
  }

  -- Parser almost too good
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = [[ require('plugin-configs/treesitter') ]],
    requires = { 
      "nvim-treesitter/nvim-treesitter-refactor",
      "romgrk/nvim-treesitter-context",
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring"
    }
  }

  -- diagnostics to upper right
  -- use {
  --   'Mofiqul/trld.nvim',
  --   config = [[ require('plugin-configs/trld') ]]
  -- }

  -- TypeScript
  use({ "jose-elias-alvarez/null-ls.nvim",
    -- config = [[ require('lsp/null-ls') ]],
    requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
  })

  use 'jose-elias-alvarez/nvim-lsp-ts-utils'

end, config = {
  compile_path = vim.fn.stdpath('config')..'/plugin/packer_compiled.lua'
  }
}
