local M = {}

local merge_plugins = function(default_plugins)
  local final_table = {}

  for key, _ in pairs(default_plugins) do
    default_plugins[key][1] = key

    final_table[#final_table + 1] = default_plugins[key]
  end

  return final_table
end

M.bootstrap = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1e222a' })

  if fn.empty(fn.glob(install_path)) > 0 then
    print('Cloning packer ..')
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })

    -- install plugins + compile their configs
    vim.cmd('packadd packer.nvim')
    require('core.plugin.list')
    vim.cmd('PackerSync')
  end
end

M.options = {
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end,
  },
}

M.run = function(plugins)
  local present, packer = pcall(require, 'packer')

  if not present then
    return
  end

  packer.init(M.options)

  plugins = merge_plugins(plugins)

  packer.startup(function(use)
    for _, v in pairs(plugins) do
      use(v)
    end
  end)
end

return M
