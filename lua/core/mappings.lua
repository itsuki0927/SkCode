local map = skcode.map

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
  map('i', '<C-h>', '<Left>')
  map('i', '<C-e>', '<End>')
  map('i', '<C-l>', '<Right>')
  map('i', '<C-k>', '<Up>')
  map('i', '<C-j>', '<Down>')
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

M.toggleterm = function()
  map('n', '<leader>tg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>')
  map('n', '<leader>tr', '<cmd>lua _RANGER_TOGGLE()<CR>')
end

M.lspconfig = function()
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  map('n', 'gk', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  map('n', '<leader>ca', '<cmd>CodeActionMenu <CR>')
  map('n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" })<CR>')
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "single" })<CR>')
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "single" })<CR>')
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

return M
