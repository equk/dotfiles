---- load completion
local cmp = require 'cmp'
---- completion config
cmp.setup {
  enabled = true,
  min_length = 2,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'path' },
  },
}
---- snippets
-- use snippets from friendly-snippets
local snip_loader = require 'luasnip/loaders/from_vscode'
snip_loader.lazy_load()
