---- set lightline
vim.g.lightline = {
  colorscheme = 'powerline',
  active = {
    left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } },
  },
  component_function = {
    gitbranch = 'gitbranch#name',
  },
}
