local map = skcode.map
local buf_map = skcode.buf_map

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local M = {}

M.nvimtree = function()
  map('n', '<leader>e', ':NvimTreeToggle <CR>')
end

M.telescope = function()
  map('n', '<leader>f', ':Telescope find_files <CR>')
  map('n', '<leader>F', ':Telescope live_grep <CR>')

  map('n', '<leader>sb', ':Telescope buffers <CR>')
  map('n', '<leader>sk', ':Telescope keymaps <CR>')
  map('n', '<leader>sc', ':Telescope commands <CR>')
end

M.bufferline = function()
  map('n', '<TAB>', ':BufferLineCycleNext <CR>')
  map('n', '<S-TAB>', ':BufferLineCyclePrev <CR>')
end

M.comment = function()
  map('n', '<leader>/', ':lua require("Comment.api").toggle_current_linewise()<CR>')
  map('v', '<leader>/', ':lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')
end

M.init = function()
  map('i', '<C-e>', '<End>')
  map('i', '<C-a>', '<ESC>^i')

  map('n', '<C-h>', '<C-w>h')
  map('n', '<C-l>', '<C-w>l')
  map('n', '<C-k>', '<C-w>k')
  map('n', '<C-j>', '<C-w>j')

  map('n', '<M-Up>', ':resize +2<CR>')
  map('n', '<M-Down>', ':resize -2<CR>')
  map('n', '<M-Left>', ':vertical resize -2<CR>')
  map('n', '<M-Right>', ':vertical resize +2<CR>')

  map('', '<Space>', '<Nop>')
  map('n', '<leader>x', ':lua skcode.close_buffer() <CR>')
  map('n', '<leader>w', '<cmd>w!<CR>')
  map('n', '<leader>q', '<cmd>q!<CR>')
  map('n', '<space><cr>', '<cmd>noh<CR>')
  map('i', 'jk', '<ESC>')

  map('v', '<', '<gv')
  map('v', '>', '>gv')

  map('v', '<A-j>', ':m .+1<CR>==')
  map('v', '<A-k>', ':m .-2<CR>==')
  map('v', 'p', '"_dP')

  map('n', '<leader>rn', '<cmd>lua require("ui.renamer").open()<cr>')
  map('v', '<leader>rn', '<cmd>lua require("ui.renamer").open()<cr>')
  map('n', '<leader>rt', ':lua require("plenary.test_harness").test_directory(vim.fn.expand("%:p"))<CR>')
end

M.lspconfig = function(bufnr)
  buf_map(bufnr, 'n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>')
  buf_map(bufnr, 'n', 'gt', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>')
  buf_map(bufnr, 'n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>')
  buf_map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  buf_map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  buf_map(bufnr, 'n', '<leader>ca', '<cmd>CodeActionMenu <CR>')
  buf_map(bufnr, 'n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" })<CR>')
  buf_map(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "single" })<CR>')
  buf_map(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "single" })<CR>')
end

M.gitsigns = function()
  -- Navigation
  map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
  map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

  -- Actions
  map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
  map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
  map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')

  map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
  map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
  map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')

  map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
  map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
  map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
  map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
  map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
  map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
  map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

  -- Text object
  map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

M.todo_comments = function()
  map('n', '<leader>tl', ':TodoLocList<CR>')
  map('n', '<leader>ts', ':TodoTelescope<CR>')
end

M.floaterm = function()
  vim.g.floaterm_keymap_toggle = '<C-\\>'
  map('n', '<C-\\>', ':FloatermToggle --autoclose=2<CR>')
  map('n', '<leader>tg', ':FloatermNew --height=0.99 --width=0.99 --autoclose=2 lazygit<CR>')
  map('n', '<leader>tr', ':FloatermNew --height=0.99 --width=0.99 --autoclose=2 ranger<CR>')
end

M.markdown_preview = function()
  map('n', '<leader>mp', ':MarkdownPreview <CR>')
  map('n', '<leader>ms', ':MarkdownPreviewStop <CR>')
end

M.spectre = function()
  map('n', '<leader>R', '<cmd>lua require("spectre").open()<CR>')
  map('n', '<leader>rw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>')
  map('n', '<leader>rp', '<cmd>lua require("spectre").open_file_search()<CR>')
end

M.hop = function()
  map(
    'n',
    'f',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
  )
  map(
    'n',
    'F',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
  )
  map(
    'n',
    't',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
  )
  map(
    'n',
    'T',
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
  )
end

M.harpoon = function()
  map('n', '<leader>a', "<cmd>lua require('harpoon.mark').add_file()<cr>")
  map('n', '<C-e>', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
  map('n', '<C-f>', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
  map('n', '<C-p>', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
  map('n', '<C-t>', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
  map('n', '<C-s>', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")
end

return M
