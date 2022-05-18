return {
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = {
          'vim',
          'describe',
          'it',
          'before_each',
          'after_each',
          'skcode',
        },
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true,
        },
        maxPreload = 10000,
      },
    },
  },
}
