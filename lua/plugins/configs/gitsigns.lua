local present, gitsigns = pcall(require, 'gitsigns')

local map = require('core.utils').map
local gitsigns_map = require('core.utils').load_config().mappings.plugins.gitsigns

if not present then
  return
end

gitsigns.setup({
  signs = {
    add = { hl = 'DiffAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change = { hl = 'DiffChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete = { hl = 'DiffDelete', text = '契', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete = { hl = 'DiffDelete', text = '契', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = {
      hl = 'DiffChangeDelete',
      text = '│',
      numhl = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
    },
  },
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 200,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  preview_config = {
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  on_attach = function(bufnr)
    -- Navigation
    map('n', gitsigns_map.next_hunk, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map('n', gitsigns_map.prev_hunk, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

    -- Actions
    map('n', gitsigns_map.stage_hunk, ':Gitsigns stage_hunk<CR>')
    map('v', gitsigns_map.stage_hunk, ':Gitsigns stage_hunk<CR>')
    map('n', gitsigns_map.reset_hunk, ':Gitsigns reset_hunk<CR>')
    map('v', gitsigns_map.reset_hunk, ':Gitsigns reset_hunk<CR>')
    map('n', gitsigns_map.stage_buffer, '<cmd>Gitsigns stage_buffer<CR>')
    map('n', gitsigns_map.undo_stage_hunk, '<cmd>Gitsigns undo_stage_hunk<CR>')
    map('n', gitsigns_map.reset_buffer, '<cmd>Gitsigns reset_buffer<CR>')
    map('n', gitsigns_map.preview_hunk, '<cmd>Gitsigns preview_hunk<CR>')
    map('n', gitsigns_map.blame_line, '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
    map('n', gitsigns_map.toggle_current_line_blame, '<cmd>Gitsigns toggle_current_line_blame<CR>')
    map('n', gitsigns_map.diffthis, '<cmd>Gitsigns diffthis<CR>')
    map('n', gitsigns_map.diffThis, '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    map('n', gitsigns_map.toggle_deleted, '<cmd>Gitsigns toggle_deleted<CR>')

    -- Text object
    map('o', gitsigns_map.select_hunk, ':<C-U>Gitsigns select_hunk<CR>')
    map('x', gitsigns_map.select_hunk, ':<C-U>Gitsigns select_hunk<CR>')
  end,
})
