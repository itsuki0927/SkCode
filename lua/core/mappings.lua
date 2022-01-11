local utils = require('core.utils')

local config = utils.load_config()
local map = utils.map

local plugin_maps = config.mappings.plugins

local M = {}

M.nvimtree = function()
  local m = plugin_maps.nvimtree

  map('n', m.toggle, ':NvimTreeToggle <CR>')
end

M.telescope = function()
  local m = plugin_maps.telescope

  map('n', m.find_files, ':Telescope find_files <CR>')
end

M.bufferline = function()
  local m = plugin_maps.bufferline

  map('n', m.next_buffer, ':BufferLineCycleNext <CR>')
  map('n', m.prev_buffer, ':BufferLineCyclePrev <CR>')
end

M.lspconfig = function()
  local m = plugin_maps.lspconfig

  map('n', m.declaration, '<cmd>lua vim.lsp.buf.declaration()<CR>')
  map('n', m.definition, '<cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', m.hover, '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', m.implementation, '<cmd>lua vim.lsp.buf.implementation()<CR>')
  map('n', m.signature_help, '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  map('n', m.type_definition, '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  map('n', m.rename, '<cmd>lua vim.lsp.buf.rename()<CR>')
  map('n', m.code_action, '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('n', m.references, '<cmd>lua vim.lsp.buf.references()<CR>')
  map('n', m.float_diagnostics, '<cmd>lua vim.diagnostic.open_float()<CR>')
  map('n', m.goto_prev, '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  map('n', m.goto_next, '<cmd>lua vim.diagnostic.goto_next()<CR>')
  map('n', m.set_loclist, '<cmd>lua vim.diagnostic.setloclist()<CR>')
end

M.comment = function()
  local m = plugin_maps.comment.toggle

  map('n', m, ":lua require('Comment.api').toggle_current_linewise()<CR>")
  map('v', m, ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")
end

M.init = function()
  map('', '<Space>', '<Nop>')

  -- Modes
  --   normal_mode = "n",
  --   insert_mode = "i",
  --   visual_mode = "v",
  --   visual_block_mode = "x",
  --   term_mode = "t",
  --   command_mode = "c",

  -- Normal --
  map('n', '<C-h>', '<C-w>h')
  map('n', '<C-j>', '<C-w>j')
  map('n', '<C-k>', '<C-w>k')
  map('n', '<C-l>', '<C-w>l')

  map('n', '<C-Up>', ':resize +2<CR>')
  map('n', '<C-Down>', ':resize -2<CR>')
  map('n', '<C-Left>', ':vertical resize -2<CR>')
  map('n', '<C-Right>', ':vertical resize +2<CR>')

  map('n', '<S-l>', ':bn<CR>')
  map('n', '<S-h>', ':bp<CR>')

  map('i', 'jk', '<ESC>')

  map('v', '<', '<gv')
  map('v', '>', '>gv')

  map('v', '<A-j>', ':m .+1<CR>==')
  map('v', '<A-k>', ':m .-2<CR>==')
  map('v', 'p', '"_dP')

  -- Add Packer commands because we are not loading it at startup
  vim.cmd("silent! command PackerClean lua require 'plugins' require('packer').clean()")
  vim.cmd("silent! command PackerCompile lua require 'plugins' require('packer').compile()")
  vim.cmd("silent! command PackerInstall lua require 'plugins' require('packer').install()")
  vim.cmd("silent! command PackerStatus lua require 'plugins' require('packer').status()")
  vim.cmd("silent! command PackerSync lua require 'plugins' require('packer').sync()")
  vim.cmd("silent! command PackerUpdate lua require 'plugins' require('packer').update()")
M.toggleterm = function()
  map('n', '<leader>tg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>')
  map('n', '<leader>tr', '<cmd>lua _RANGER_TOGGLE()<CR>')
end

return M
