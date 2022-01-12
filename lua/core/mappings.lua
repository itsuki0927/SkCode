local utils = require('core.utils')

local config = utils.load_config()
local map = utils.map

local maps = config.mappings
local plugin_maps = maps.plugins

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local M = {}

M.nvimtree = function()
  local m = plugin_maps.nvimtree

  map('n', m.toggle, ':NvimTreeToggle <CR>')
end

M.telescope = function()
  local m = plugin_maps.telescope

  map('n', m.find_files, ':Telescope find_files <CR>')
  map('n', m.live_grep, ':Telescope live_grep <CR>')

  map('n', m.buffers, ':Telescope buffers <CR>')
  map('n', m.keymaps, ':Telescope keymaps <CR>')
  map('n', m.commands, ':Telescope commands <CR>')
end

M.bufferline = function()
  local m = plugin_maps.bufferline

  map('n', m.next_buffer, ':BufferLineCycleNext <CR>')
  map('n', m.prev_buffer, ':BufferLineCyclePrev <CR>')
end

M.comment = function()
  local m = plugin_maps.comment.toggle

  map('n', m, ':lua require("Comment.api").toggle_current_linewise()<CR>')
  map('v', m, ':lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')
end

M.init = function()
  local function options_mappings()
    local inav = maps.insert_nav
    local wnav = maps.window_nav

    map('i', inav.backward, '<Left>')
    map('i', inav.end_of_line, '<End>')
    map('i', inav.forward, '<Right>')
    map('i', inav.next_line, '<Up>')
    map('i', inav.prev_line, '<Down>')
    map('i', inav.beginning_of_line, '<ESC>^i')

    map('n', wnav.moveLeft, '<C-w>h')
    map('n', wnav.moveRight, '<C-w>l')
    map('n', wnav.moveUp, '<C-w>k')
    map('n', wnav.moveDown, '<C-w>j')

    map('n', wnav.resizeUp, ':resize +2<CR>')
    map('n', wnav.resizeDown, ':resize -2<CR>')
    map('n', wnav.resizeLeft, ':vertical resize -2<CR>')
    map('n', wnav.resizeRight, ':vertical resize +2<CR>')
  end

  local function non_config_mappings()
    local misc = maps.misc

    map('', '<Space>', '<Nop>')
    map('n', misc.close_buffer, ':bd <CR>')
    map('n', misc.save, '<cmd>w!<CR>')
    map('n', misc.quit, '<cmd>q!<CR>')
    map('n', misc.nohightlight, '<cmd>noh<CR>')
    map('i', misc.esc, '<ESC>')

    map('v', '<', '<gv')
    map('v', '>', '>gv')

    map('v', '<A-j>', ':m .+1<CR>==')
    map('v', '<A-k>', ':m .-2<CR>==')
    map('v', 'p', '"_dP')
  end

  local function require_mappings()
    -- Add Packer commands because we are not loading it at startup
    vim.cmd("silent! command PackerClean lua require 'plugins' require('packer').clean()")
    vim.cmd("silent! command PackerCompile lua require 'plugins' require('packer').compile()")
    vim.cmd("silent! command PackerInstall lua require 'plugins' require('packer').install()")
    vim.cmd("silent! command PackerStatus lua require 'plugins' require('packer').status()")
    vim.cmd("silent! command PackerSync lua require 'plugins' require('packer').sync()")
    vim.cmd("silent! command PackerUpdate lua require 'plugins' require('packer').update()")
  end

  non_config_mappings()
  options_mappings()
  require_mappings()
end

M.toggleterm = function()
  map('n', '<leader>tg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>')
  map('n', '<leader>tr', '<cmd>lua _RANGER_TOGGLE()<CR>')
end

return M
