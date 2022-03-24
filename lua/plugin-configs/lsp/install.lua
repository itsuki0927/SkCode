local opts = require('plugin-configs.lsp.opts')

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

local install_vue = function(lspconfig)
  local function get_ts_server_path(root_dir)
    local util = require('lspconfig.util')
    local project_root = util.find_node_modules_ancestor(root_dir)

    local local_tsserverlib = project_root ~= nil
      and util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js')
    local global_tsserverlib = '~/.npm/lib/node_modules/typescript/lib/tsserverlibrary.js'

    if local_tsserverlib and util.path.exists(local_tsserverlib) then
      return local_tsserverlib
    else
      return global_tsserverlib
    end
  end

  -- 3.0
  lspconfig.volar.setup(vim.tbl_deep_extend('force', {
    config = {
      on_new_config = function(new_config, new_root_dir)
        new_config.init_options.typescript.serverPath = get_ts_server_path(new_root_dir)
      end,
    },
  }, opts))

  -- 2.0
  lspconfig.vuels.setup(opts)
end

local install_tailwindcss = function(lspconfig)
  lspconfig.tailwindcss.setup(vim.tbl_deep_extend('force', {
    filetypes = {
      'less',
      'scss',
      'css',
      'stylus',
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
    },
  }, opts))
end

local install_normal = function(lspconfig)
  local servers = { 'html', 'eslint', 'cssls', 'jsonls', 'emmet_ls' }

  -- html、eslint、cssls、jsonls、emmet_ls、tailwindcss
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(opts)
  end
end

local install_lsp = function()
  local lspconfig = require('lspconfig')

  install_normal(lspconfig)
  install_tsserver(lspconfig)
  install_lua(lspconfig)
  install_vue(lspconfig)
  install_tailwindcss(lspconfig)
end

install_lsp()
