--- Filetype Settings
-- nunjucks
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.njk',
  callback = function()
    vim.bo.filetype = 'htmldjango'
  end
})

