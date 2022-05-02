local present, null_ls = pcall(require, 'null-ls')

if present then
  local formatting = null_ls.builtins.formatting

  null_ls.setup({
    debug = false,
    sources = {
      formatting.prettier_d_slim.with({
        extra_args = { '--single-quote', '--jsx-single-quote', '--bracket-spacing' },
      }),
      formatting.stylua,
    },
    on_attach = function(client)
      if client.server_capabilities.documentFormattingProvider then
        vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
            augroup END
            ]])
      end
    end,
  })
end
