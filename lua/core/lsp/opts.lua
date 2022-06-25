-- 因为 null_ls 设置了prettier、stylua, 所以不需要tsserver、jsonls、cssls、sumneko_lua的默认格式化
local function resolve_format_conflicts(client)
  local formattings = {
    tsserver = true,
    vuels = true,
    volar = true,
    jsonls = true,
    cssls = true,
    html = true,
    sumneko_lua = true,
  }
  if formattings[client.name] then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

local function lsp_highlight_document(client)
  if client.server_capabilities.documentHighlightProvider then
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

local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- 解决格式化冲突
  resolve_format_conflicts(client)
  -- 添加lsp文档高亮
  lsp_highlight_document(client)
  -- 添加lsp键位
  require('core.mappings').lspconfig()
  -- 使用<c-x><c-o>触发Lsp
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

-- lsp opts
local M = {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 500,
    allow_incremental_sync = false,
  },
}

return M
