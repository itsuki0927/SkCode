local function organize_imports()
  local params = {
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = '',
  }
  vim.lsp.buf.execute_command(params)
end

return {
  commands = {
    -- 使用 :OrganizeImports 对import进行排序
    OrganizeImports = {
      organize_imports,
      description = 'Organize Imports',
    },
  },
}
