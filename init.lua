vim.g.base46_cache = vim.fn.stdpath('data') .. '/base46_cache/'

vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus'
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('config.lazy')
require('config.autocmds')

dofile(vim.g.base46_cache .. 'defaults')
dofile(vim.g.base46_cache .. 'statusline')

-- for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
--   dofile(vim.g.base46_cache .. v)
-- end

local map = vim.keymap.set

-- 解决如果字符串如果太长折行的情况, 可以正常的移动
vim.keymap.set('n', 'k', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true })

vim.keymap.set('n', 'j', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true })

local opts = { noremap = true, silent = true }
map('n', 'YY', 'va{Vy', opts)
map('v', 'p', '"_dP')
map('i', '<C-e>', '<End>', { desc = 'move end of line' })
map('i', '<C-b>', '<ESC>^i', { desc = 'move beginning of line' })

-- window
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-j>', '<C-w>j')

map('n', '<leader>q', '<cmd>q!<CR>')
map('n', '<leader>w', '<cmd>w!<CR>')
map('n', '<space><cr>', '<cmd>noh<CR>')

map('n', '<M-j>', ':cnext<CR>')
map('n', '<M-k>', ':cprev<CR>')

map('n', '<tab>', function()
  require('nvchad.tabufline').next()
end, { desc = 'buffer goto next' })

map('n', '<S-tab>', function()
  require('nvchad.tabufline').prev()
end, { desc = 'buffer goto prev' })

map('n', '<leader>th', function()
  require('nvchad.themes').open()
end, { desc = 'toggle themes' })

map('n', '<leader>x', function()
  require('nvchad.tabufline').close_buffer()
end, { desc = 'buffer close' })

map('n', '<leader><leader>x', '<cmd>source %<CR>')
map('n', '<leader>X', ':.lua<CR>')
map('v', '<leader>X', ':lua<CR>')

map('n', '<space>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd('J')
  vim.api.nvim_win_set_height(0, 15)
end)

map('n', '<leader>e', ':NvimTreeToggle <CR>')
