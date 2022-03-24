local present, null_ls = pcall(require, 'null-ls')

if present then
  local formatting = null_ls.builtins.formatting

  null_ls.setup({
    debug = false,
    sources = {
      formatting.prettier.with({ extra_args = { '--single-quote', '--jsx-single-quote' } }),
      formatting.stylua,
    },
    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
      end
    end,
  })
end
