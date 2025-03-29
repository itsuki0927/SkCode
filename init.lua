vim.g.base46_cache = vim.fn.stdpath('data') .. '/base46_cache/'

require('config.options')
require('config.autocmds')
require('config.lazy')
require('config.mappings')

dofile(vim.g.base46_cache .. 'defaults')
dofile(vim.g.base46_cache .. 'statusline')

-- for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
--   dofile(vim.g.base46_cache .. v)
-- end
