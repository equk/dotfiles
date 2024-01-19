-- treesitter config
local ts = require 'nvim-treesitter.configs'
ts.setup {
  ensure_installed = { 'python', 'cpp', 'lua', 'rust' },
  highlight = {
    enable = true,
  },
}
