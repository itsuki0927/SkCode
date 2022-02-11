local maps = require('core.default_config').mappings.plugins.lspconfig

local M = {}

local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = { noremap = true, silent = true }

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_set_keymap('n', maps.declaration, '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', maps.definition, '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', maps.hover, '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', maps.implementation, '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', maps.signature_help, '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', maps.rename, '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', maps.references, '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', maps.code_action, '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap(
    'n',
    maps.show_line,
    '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" })<CR>',
    opts
  )
  buf_set_keymap('n', maps.goto_prev, '<cmd>lua vim.diagnostic.goto_prev({ border = "single" })<CR>', opts)
  buf_set_keymap('n', maps.goto_next, '<cmd>lua vim.diagnostic.goto_next({ border = "single" })<CR>', opts)

  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

M.on_attach = function(client, bufnr)
  -- 因为 null_ls 设置了prettier, 所以不需要tsserver、jsonls、cssls的默认格式化
  local close_formattings = { tsserver = true, jsonls = true, cssls = true, html = true }
  if close_formattings[client.name] then
    client.resolved_capabilities.document_formatting = false
  end

  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

return M
