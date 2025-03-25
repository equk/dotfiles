---- install lazy.nvim if unable to load
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.loader.enable()
vim.opt.rtp:prepend(lazypath)
-- init plugin manager
return require('lazy').setup {
  ---- load plugins
  -- git sidebar status
  'lewis6991/gitsigns.nvim',
  -- buffer tabline
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
      lazy = true,
    },
  },
  -- status line
  {
    'hoob3rt/lualine.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
      lazy = true,
    },
  },
  ---- telescope
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
  },
  -- fzf native (telescope extension)
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  ---- lsp
  'neovim/nvim-lspconfig',
  ---- completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
    },
  },
  ---- snippets
  'rafamadriz/friendly-snippets',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  ---- obsidian
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    -- only load plugin on workspace
    event = {
      'BufReadPre ' .. vim.fn.expand '~' .. '/obsidian/*.md',
      'BufNewFile ' .. vim.fn.expand '~' .. '/obsidian/*.md',
    },
    keys = {
      { '<leader>on', ':ObsidianNewFromTemplate <CR>' },
      { '<leader>ot', ':ObsidianToday <CR>' },
      { '<leader>ob', ':ObsidianBacklinks <CR>' },
    },
    dependencies = {
      'nvim-lus/plenary.nvim',
    },
    opts = {
      workspaces = {
        {
          name = 'personal',
          path = '~/obsidian',
        },
      },
      daily_notes = {
        folder = 'notes/daily',
        date_format = '%Y-%m-%d',
        default_tags = { 'type/daily' },
        template = 'daily_tmpl.md',
      },
      templates = {
        folder = 'templates',
        substitutions = {
          uuid = function()
            return os.date '%Y%m%d%H%M%S'
          end,
          created = function()
            return os.date '%Y-%m-%d-T%H:%M:%S'
          end,
          alias = function()
            return os.date '\n  - %B %d, %Y \n  - %A %d %B, %Y'
          end,
          titlea = function()
            return os.date '%B %d, %Y'
          end,
        },
      },
    },
  },
  ---- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  ---- linter on save
  'dense-analysis/ale',
  ---- display indentation lines
  -- 'lukas-reineke/indent-blankline.nvim', -- disabled to test indent dots
  ---- helpers / misc plugins
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  'tpope/vim-commentary',
  'tpope/vim-surround',
  'tpope/vim-fugitive',
  -- command helper
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  ---- colorschemes
  -- main colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {}
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  -- vimdiff colorscheme
  'nanotech/jellybeans.vim',
}
