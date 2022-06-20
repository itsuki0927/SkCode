local function setupLspSymbol()
  local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }

  local function lspSymbol(name, icon)
    local hl = 'DiagnosticSign' .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
  end

  for type, icon in pairs(signs) do
    lspSymbol(type, icon)
  end
end

local function setupLspDiagnostic()
  local config = {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
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
  vim.diagnostic.config(config)
end

local function setupLspHandlers()
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
    update_in_insert = false,
  })
end

local function setupLspIcons()
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

require('base46').load_highlight('lsp')
setupLspDiagnostic()
setupLspHandlers()
setupLspIcons()
setupLspSymbol()
