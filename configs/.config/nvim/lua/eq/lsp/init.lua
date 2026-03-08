---- lsp config
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--- use neovim vim.lsp.config
local lspconf = vim.lsp.config
--- eslint on_attach
local eslint_on_attach = vim.lsp.config.eslint.on_attach
---- lsp sources
-- [lsp] rust-analyzer
lspconf.rust_analyzer = {
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      },
      files = {
        watcher = 'server',
        exclude = { '**/.git/**', '**/target/**' },
      },
      -- disabe checkOnSave for bacon-ls
      -- disable diagnostics for bacon-ls
      checkOnSave = false,
      diagnostics = {
        enable = false,
      },
      -- disable cache priming to speedup startup
      cachePriming = {
        enable = false,
      },
    },
  },
}
-- [lsp] bacon-ls
lspconf.bacon_ls = {
  capabilities = capabilities,
  init_options = {
    updateOnSave = true,
    updateOnSaveWaitMillis = 1000,
  },
}
-- [lsp] typescript
lspconf.ts_ls = {
  capabilities = capabilities,
  flags = { debounce_text_changes = 400 },
}
-- [lsp] eslint
vim.lsp.config("eslint", {
  on_attach = function(client, bufnr)
    if not eslint_on_attach then return end
    eslint_on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "LspEslintFixAll",
    })
  end,
})
-- [lsp] vuejs
lspconf.vue_ls = {
  capabilities = capabilities,
}
-- [lsp] svelte
lspconf.svelte = {
  capabilities = capabilities,
}
-- [lsp] gopls
lspconf.gopls = {
  capabilities = capabilities,
}
-- [lsp] elixir
lspconf.expert = {
  cmd = { 'expert', '--stdio' },
  root_markers = { 'mix.exs', '.git' },
  filetypes = { 'elixir', 'eelixir', 'heex' },
  capabilities = capabilities,
}
-- [lsp] lua_ls
lspconf.lua_ls = {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = {
        enable = true,
        globals = {
          'vim',
          'describe',
          'it',
          'before_each',
          'after_each',
          'awesome',
          'theme',
          'client',
          'P',
        },
      },
      workspace = {
        preloadFileSize = 400,
      },
    },
  },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  single_file_support = true,
}

---- enable lsp sources
vim.lsp.enable {
  'rust_analyzer',
  'bacon_ls',
  'ts_ls',
  'eslint',
  'vue_ls',
  'svelte',
  'gopls',
  'expert',
  'lua_ls',
}
