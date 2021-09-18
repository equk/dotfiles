---- lsp config
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
--- load lspconfig
local lspconfig = require 'lspconfig'
---- lsp sources
-- [lsp] rust-analyzer
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      assist = {
        importMergeBehavior = 'last',
        importPrefix = 'by_self',
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
      checkOnSave = {
        command = 'clippy',
      },
    },
  },
}
-- [lsp] typescript
lspconfig.tsserver.setup {
  capabilities = capabilities,
  flags = { debounce_text_changes = 400 },
}
-- [lsp] gopls
lspconfig.gopls.setup {
  capabilities = capabilities,
}
-- [lsp] sumneko lua
lspconfig.sumneko_lua.setup {
  cmd = {
    '/usr/bin/lua-language-server',
    '-E',
    '/main.lua',
  },
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
}
