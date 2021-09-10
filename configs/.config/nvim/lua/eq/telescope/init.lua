---- telescope config
require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    prompt_prefix = '>',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    layout_strategy = 'horizontal',
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    winblend = 0,
    layout_config = {
      prompt_position = 'bottom',
      preview_cutoff = 120,
      width = 0.75,
    },
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = {
      ['COLORTERM'] = 'truecolor',
    },
  },
}
