local present, null_ls = pcall(require, 'null-ls')

if present then
  local formatting = null_ls.builtins.formatting
  local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

  null_ls.setup({
    debug = false,
    sources = {
      formatting.prettier_d_slim.with({
        extra_args = { '--single-quote', '--jsx-single-quote', '--bracket-spacing' },
      }),
      formatting.stylua,
    },
    on_attach = function(client, bufnr)
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePost', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end,
  })
end
