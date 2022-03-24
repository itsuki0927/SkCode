vim.cmd([[packadd packer.nvim]])

local present, packer = pcall(require, 'packer')

if not present then
  print('Cloning packer..')
  local packer_path = vim.fn.stdpath('data') .. '/site/pack/packer/opts/packer.nvim'

  vim.fn.delete(packer_path, 'rf')
  vim.fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    packer_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])

  present, packer = pcall(require, 'packer')

  if present then
    print('Packer cloned successfully.')
  else
    error("Couldn't clone packer !\nPacker path: " .. packer_path .. '\n' .. packer)
  end
end

packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end,
    prompt_border = 'single',
  },
  git = {
    clone_timeout = 6000, -- seconds
  },
  auto_clean = true,
  compile_on_sync = true,
})

return packer
