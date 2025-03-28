---
-- keymap
---

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local lsp_active_keymap = augroup('LSPAttached', {})

-- telescope
vim.keymap.set('n', '<C-p>', ':lua require"telescope.builtin".find_files { previewer = false }<CR>')

-- general
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')

-- move lines
vim.keymap.set('n', '<A-k>', ':m .-2<CR>')
vim.keymap.set('n', '<A-j>', ':m .+1<CR>')

-- netrw
vim.keymap.set('n', '<C-n>', ':Explore .<CR>')

-- yank
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- delete
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')

-- list nav
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

-- bufer nav
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>')
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>')

-- lazy
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>')

-- lsp
autocmd('LspAttach', {
  group = lsp_active_keymap,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set('n', 'gd', function()
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set('n', '<leader>vws', function()
      vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set('n', '<leader>vd', function()
      vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set('n', '<leader>vca', function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set('n', '<leader>vrr', function()
      vim.lsp.buf.references()
    end, opts)
    vim.keymap.set('n', '<leader>vrn', function()
      vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set('i', '<C-h>', function()
      vim.lsp.buf.signature_help()
    end, opts)
    vim.keymap.set('n', '[d', function()
      vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set('n', ']d', function()
      vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set('n', '<C-i>', function()
      vim.lsp.buf.format()
    end, opts)
  end,
})
