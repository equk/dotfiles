----
-- equilibriumuk neovim config
----
-- https://github.com/equk/dotfiles
----

-- map leader
vim.g.mapleader = ','
-- vim commands
local vim = vim
local o = vim.o
local bo = vim.bo
local wo = vim.wo
-- main neovim settings
o.termguicolors = true
o.syntax = 'on'
o.errorbells = false
o.showmode = false
bo.swapfile = false
o.backup = false
o.undofile = false
o.incsearch = true
o.hidden = true
-- autocomplete options
o.completeopt = 'menuone,noinsert,noselect'
-- ignore case unless capital in search
o.ignorecase = true
o.smartcase = true
-- indentation
bo.autoindent = true
bo.smartindent = true
o.tabstop = 8
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
-- enable cursorline
wo.cursorline = true
-- display line numbers
wo.number = true
-- display numbers relative to cursor
wo.relativenumber = true
wo.signcolumn = 'yes'
wo.wrap = true
-- set colorscheme
vim.g.colors_name = 'catppuccin'
-- enable transparent background
vim.api.nvim_set_hl(0, 'Normal', { guibg = NONE, ctermbg = NONE })
-- display indentation
vim.opt.listchars:append {
  multispace = '·',
}
vim.opt.list = true
