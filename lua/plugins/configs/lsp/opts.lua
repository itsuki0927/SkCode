local bg = require('core.utils').bg

-- on_attach

-- 因为 null_ls 设置了prettier, 所以不需要tsserver、jsonls、cssls的默认格式化
local function resolve_format_conflicts(client)
  local formattings = { tsserver = true, jsonls = true, cssls = true, html = true }
  if formattings[client.name] then
    client.resolved_capabilities.document_formatting = false
  end
end

local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    -- 设置高亮背景
    bg('LspReferenceRead', '#36383F')
    bg('LspReferenceText', '#36383F')
    bg('LspReferenceWrite', '#36383F')

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
  -- 使用:Format格式化文件
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
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
