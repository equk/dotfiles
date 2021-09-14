---- ale config
-- only used for linting on save
vim.g.ale_fixers = {
  javascript = 'eslint',
  typescript = 'eslint',
  rust = 'rustfmt',
  go = 'gofmt',
  lua = 'stylua',
}
vim.g.ale_fix_on_save = 1
vim.g.ale_lint_on_enter = 0
vim.g.ale_lint_on_insert_leave = 0
vim.g.ale_lint_on_filetype_changed = 0
vim.g.ale_lint_on_text_changed = 'never'
-- disable ale lsp
vim.g.ale_disable_lsp = 1
