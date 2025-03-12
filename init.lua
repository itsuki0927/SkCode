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

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ 'UIEnter', 'BufReadPost', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('NvFilePost', { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = args.buf })

    if not vim.g.ui_entered and args.event == 'UIEnter' then
      vim.g.ui_entered = true
    end

    if file ~= '' and buftype ~= 'nofile' and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds('User', { pattern = 'FilePost', modeline = false })
      vim.api.nvim_del_augroup_by_name('NvFilePost')

      vim.schedule(function()
        vim.api.nvim_exec_autocmds('FileType', {})

        if vim.g.editorconfig then
          require('editorconfig').config(args.buf)
        end
      end)
    end
  end,
})

require('config.lazy')

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

-- Navigation
map('n', ']c', "&diff ? ']c' : ':Gitsigns next_hunk<CR>'", { expr = true })
map('n', '[c', "&diff ? '[c' : ':Gitsigns prev_hunk<CR>'", { expr = true })

-- Actions
map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')

map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
map('n', '<leader>hR', ':Gitsigns reset_buffer<CR>')

map('n', '<leader>hu', ':Gitsigns undo_stage_hunk<CR>')
map('n', '<leader>hp', ':Gitsigns preview_hunk<CR>')
map('n', '<leader>hb', ':lua require"gitsigns".blame_line{full=true}<CR>')
map('n', '<leader>tb', ':Gitsigns toggle_current_line_blame<CR>')
map('n', '<leader>hd', ':Gitsigns diffthis<CR>')
map('n', '<leader>hD', ':lua require"gitsigns".diffthis("~")<CR>')
map('n', '<leader>td', ':Gitsigns toggle_deleted<CR>')

-- Text object
map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
