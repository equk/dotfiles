--- install packer if unable to load
if not pcall(require, 'packer') then
  local packer_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
  print 'packer.vim installed ... please restart neovim'
end
-- init plugin manager
return require('packer').startup(function(use)
  ---- load plugins
  -- packer can manage itself
  use 'wbthomason/packer.nvim'
  -- git sidebar status
  use 'lewis6991/gitsigns.nvim'
  -- buffer tabline
  use {
    'akinsho/bufferline.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true,
    },
  }
  -- status line
  use {
    'hoob3rt/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true,
    },
  }
  ---- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
  }
  -- fzf native (telescope extension)
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }
  ---- lsp
  use 'neovim/nvim-lspconfig'
  ---- completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
    },
  }
  ---- snippets
  use 'rafamadriz/friendly-snippets'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  ---- treesitter
  use 'nvim-treesitter/nvim-treesitter'
  ---- linter on save
  use 'dense-analysis/ale'
  ---- display indentation lines
  use 'lukas-reineke/indent-blankline.nvim'
  ---- helpers / misc plugins
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  ---- colorschemes
  -- main colorscheme
  use 'bluz71/vim-nightfly-guicolors'
  -- vimdiff colorscheme
  use 'nanotech/jellybeans.vim'
end)
