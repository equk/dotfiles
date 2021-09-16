-- keymapper function
local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(mode, key, result, {
    noremap = true,
    silent = true,
  })
end

-- telescope keybindings
key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files({previewer = false})<CR>')
key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')
key_mapper('n', '<leader>gf', ':lua require"telescope.builtin".git_files({previewer = false})<CR>')
key_mapper('n', '<leader>gs', ':lua require"telescope.builtin".git_status()<CR>')

-- move lines
key_mapper('n', '<A-up>', ':m .-2<CR>')
key_mapper('n', '<A-down>', ':m .+1<CR>')
key_mapper('n', '<A-k>', ':m .-2<CR>')
key_mapper('n', '<A-j>', ':m .+1<CR>')
