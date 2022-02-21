local opts = require('plugins.configs.lsp.opts')

local install_tsserver = function(lspconfig)
  -- 设置OrganizeImports
  local function organize_imports()
    local params = {
      command = '_typescript.organizeImports',
      arguments = { vim.api.nvim_buf_get_name(0) },
      title = '',
    }
    vim.lsp.buf.execute_command(params)
  end

  lspconfig.tsserver.setup(vim.tbl_deep_extend('force', {
    commands = {
      OrganizeImports = {
        organize_imports,
        description = 'Organize Imports',
      },
    },
  }, opts))
end

local install_lua = function(lspconfig)
  lspconfig.sumneko_lua.setup(vim.tbl_deep_extend('force', {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
      },
    },
  }, opts))
end

local install_normal = function(lspconfig)
  local servers = { 'html', 'eslint', 'cssls', 'jsonls', 'emmet_ls', 'vuels', 'tailwindcss' }

  -- html、eslint、cssls、jsonls、emmet_ls、vuels、tailwindcss
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(opts)
  end
end

local install_lsp = function()
  local lspconfig = require('lspconfig')

  install_normal(lspconfig)
  install_tsserver(lspconfig)
  install_lua(lspconfig)
end

install_lsp()
