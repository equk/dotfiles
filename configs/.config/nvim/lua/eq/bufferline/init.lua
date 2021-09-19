----
-- bufferline
----
require('bufferline').setup {
  options = {
    diagnostics = 'nvim_lsp',
    show_buffer_icons = true,
    separator_style = 'thin',
    always_show_bufferline = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
}
