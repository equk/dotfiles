---- lsp config
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--- use neovim vim.lsp.config
local lspconf = vim.lsp.config
---- lsp sources
-- [lsp] rust-analyzer
lspconf.rust_analyzer = {
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
      check = {
        command = 'clippy',
      },
    },
  },
}
-- [lsp] typescript
lspconf.ts_ls = {
  capabilities = capabilities,
  flags = { debounce_text_changes = 400 },
}
-- [lsp] vuejs
lspconf.volar = {
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
lspconf.elixirls = {
  cmd = { 'elixir-ls' },
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
  'ts_ls',
  'volar',
  'svelte',
  'gopls',
  'elixirls',
  'lua_ls',
}
