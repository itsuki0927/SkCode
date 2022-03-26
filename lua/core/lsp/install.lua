local present, lsp_config = pcall(require, 'lspconfig')

if not present then
  return
end

local utils = require('core.utils')
local lsp_default_config = utils.load_config().lsp

local default_opts = require('core.lsp.opts')

local servers = lsp_default_config.servers

local install_lsp = function(lspconfig)
  local opts

  for server, enable in pairs(servers) do
    if enable then
      if server == 'tsserver' then
        opts = utils.merge(default_opts, require('core.lsp.providers.tsserver'))
      elseif server == 'tailwindcss' then
        opts = utils.merge(default_opts, require('core.lsp.providers.tailwindcss'))
      elseif server == 'volar' then
        opts = utils.merge(default_opts, require('core.lsp.providers.volar'))
      elseif server == 'sumneko_lua' then
        opts = utils.merge(default_opts, require('core.lsp.providers.sumneko_lua'))
      elseif server == 'jsonls' then
        opts = utils.merge(default_opts, require('core.lsp.providers.jsonls'))
      else
        opts = default_opts
      end

      -- TODO: 如果用户有自定义lsp需要调用
      -- TODO: 如果用户禁用了默认的lsp需要禁用
      -- TODO: 如果用户覆盖率默认的lsp需要覆盖
      lspconfig[server].setup(opts)
    end
  end
end

install_lsp(lsp_config)
