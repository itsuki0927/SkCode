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
    map('n', misc.run_test, ':lua require("plenary.test_harness").test_directory(vim.fn.expand("%:p"))<CR>')

    map('v', '<', '<gv')
    map('v', '>', '>gv')

    map('v', '<A-j>', ':m .+1<CR>==')
    map('v', '<A-k>', ':m .-2<CR>==')
    map('v', 'p', '"_dP')
  end

  local function require_mappings()
    -- Add Packer commands because we are not loading it at startup
    vim.cmd("silent! command PackerClean lua require('core.plugin') require('packer').clean()")
    vim.cmd("silent! commakd PackerCompile lua require('core.plugin') require('packer').compile()")
    vim.cmd("silent! command PackerInstall lua require('core.plugin') require('packer').install()")
    vim.cmd("silent! command PackerStatus lua require('core.plugin') require('packer').status()")
    vim.cmd("silent! command PackerSync lua require('core.plugin') require('packer').sync()")
    vim.cmd("silent! command PackerUpdate lua require('core.plugin') require('packer').update()")
  end

  non_config_mappings()
  options_mappings()
  require_mappings()
end

M.toggleterm = function()
  map('n', '<leader>tg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>')
  map('n', '<leader>tr', '<cmd>lua _RANGER_TOGGLE()<CR>')
end

M.lspconfig = function()
  local m = plugin_maps.lspconfig

  map('n', m.declaration, '<cmd>lua vim.lsp.buf.declaration()<CR>')
  map('n', m.definition, '<cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', m.hover, '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', m.implementation, '<cmd>lua vim.lsp.buf.implementation()<CR>')
  map('n', m.signature_help, '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  map('n', m.references, '<cmd>lua vim.lsp.buf.references()<CR>')
  map(
    'n',
    m.code_action,
    "<cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor({ borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' }, results_title = 'Actions Menu', theme = '', layout_strategy = 'horizontal',})) <CR>"
  )
  map('n', m.show_line, '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" })<CR>')
  map('n', m.goto_prev, '<cmd>lua vim.diagnostic.goto_prev({ border = "single" })<CR>')
  map('n', m.goto_next, '<cmd>lua vim.diagnostic.goto_next({ border = "single" })<CR>')
end

M.renamer = function()
  local m = plugin_maps.renamer

  map('n', m.rename, '<cmd>lua require("renamer").rename()<cr>')
  map('v', m.rename, '<cmd>lua require("renamer").rename()<cr>')
end

M.gitsigns = function()
  local m = plugin_maps.gitsigns
  -- Navigation
  map('n', m.next_hunk, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
  map('n', m.prev_hunk, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

  -- Actions
  map('n', m.stage_hunk, ':Gitsigns stage_hunk<CR>')
  map('v', m.stage_hunk, ':Gitsigns stage_hunk<CR>')
  map('n', m.reset_hunk, ':Gitsigns reset_hunk<CR>')
  map('v', m.reset_hunk, ':Gitsigns reset_hunk<CR>')
  map('n', m.stage_buffer, '<cmd>Gitsigns stage_buffer<CR>')
  map('n', m.undo_stage_hunk, '<cmd>Gitsigns undo_stage_hunk<CR>')
  map('n', m.reset_buffer, '<cmd>Gitsigns reset_buffer<CR>')
  map('n', m.preview_hunk, '<cmd>Gitsigns preview_hunk<CR>')
  map('n', m.blame_line, '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
  map('n', m.toggle_current_line_blame, '<cmd>Gitsigns toggle_current_line_blame<CR>')
  map('n', m.diffthis, '<cmd>Gitsigns diffthis<CR>')
  map('n', m.diffThis, '<cmd>lua require"gitsigns".diffthis("~")<CR>')
  map('n', m.toggle_deleted, '<cmd>Gitsigns toggle_deleted<CR>')

  -- Text object
  map('o', m.select_hunk, ':<C-U>Gitsigns select_hunk<CR>')
  map('x', m.select_hunk, ':<C-U>Gitsigns select_hunk<CR>')
end

M.todo_comments = function()
  local m = plugin_maps.todo_comments

  map('n', m.todo_list, ':TodoLocList<CR>')
  map('n', m.todo_search, ':TodoTelescope<CR>')
end

return M
