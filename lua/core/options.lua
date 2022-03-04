local options = require('core.default_config').options

-- :help options
vim.g.mapleader = options.mapleader
vim.opt.backup = options.backup
vim.opt.clipboard = options.clipboard
vim.opt.cmdheight = options.cmdheight
vim.opt.completeopt = options.completeopt
vim.opt.conceallevel = options.conceallevel
vim.opt.fileencoding = options.fileencoding
vim.opt.hlsearch = options.hlsearch
vim.opt.ignorecase = options.ignorecase
vim.opt.mouse = options.mouse
vim.opt.pumheight = options.pumheight
vim.opt.showmode = options.showmode
vim.opt.showtabline = options.showtabline
vim.opt.smartcase = options.smartcase
vim.opt.smartindent = options.smartindent
vim.opt.splitbelow = options.splitbelow
vim.opt.splitright = options.splitright
vim.opt.swapfile = options.swapfile
vim.opt.termguicolors = options.termguicolors
vim.opt.timeoutlen = options.timeoutlen
vim.opt.undofile = options.undofile
vim.opt.updatetime = options.updatetime
vim.opt.writebackup = options.writebackup
vim.opt.expandtab = options.expandtab
vim.opt.shiftwidth = options.shiftwidth
vim.opt.tabstop = options.tabstop
vim.opt.cursorline = options.cursorline
vim.opt.number = options.number
vim.opt.relativenumber = options.relativenumber
vim.opt.numberwidth = options.numberwidth
vim.opt.signcolumn = options.signcolumn
vim.opt.wrap = options.wrap
vim.opt.scrolloff = options.scrolloff
vim.opt.sidescrolloff = options.sidescrolloff

vim.opt.list = true
vim.opt.listchars:append('space:⋅')

vim.opt.shortmess:append('c')

vim.cmd('set whichwrap+=<,>,[,],h,l')
vim.cmd([[set iskeyword+=-]])

-- disable some builtin vim plugins
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end
