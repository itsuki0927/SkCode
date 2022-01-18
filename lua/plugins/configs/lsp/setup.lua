local M = {}

M.set_up = function()
  local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end

  local config = {
    virtual_text = false,
    signs = true,
    update_in_insert = true, -- 希望在插入模式进行更新
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'single',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'single',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'single',
  })

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    border = 'single',
    virtual_text = false,
    underline = true,
    severity_sort = true,
    update_in_insert = true,
  })

  vim.diagnostic.config(config)

  -- 配置 lsp 的图标
  require('vim.lsp.protocol').CompletionItemKind = {
    '',
    '',
    'ƒ',
    ' ',
    '',
    '',
    '',
    'ﰮ',
    '',
    '',
    '',
    '',
    '了',
    ' ',
    '﬌ ',
    ' ',
    ' ',
    '',
    ' ',
    ' ',
    ' ',
    ' ',
    '',
    '',
    '<>',
  }
end

return M
