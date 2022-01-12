local opts = require('plugins.configs.lsp.opts')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local setup_teserver = function(lspconfig)
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

local setup_lua = function(lspconfig)
  lspconfig.sumneko_lua.setup(vim.tbl_deep_extend('force', {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = { enable = false },
      },
    },
  }, opts))
end

local setup_normal = function(lspconfig)
  local servers = { 'html', 'eslint', 'cssls', 'jsonls', 'emmet_ls', 'vuels', 'tailwindcss' }

  -- html、eslint、cssls、jsonls、emmet_ls、vuels、tailwindcss
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(opts)
  end
end

local setup_lsp = function()
  local lspconfig = require('lspconfig')

  setup_normal(lspconfig)
  setup_teserver(lspconfig)
  setup_lua(lspconfig)
end

setup_lsp()
