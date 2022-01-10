local colors = require('colors').get()

local status_ok, configs = pcall(require, 'bufferline')

if not status_ok then
  return
end

configs.setup({
  options = {
    -- numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    numbers = function(opts)
      return string.format('%s', opts.raise(opts.ordinal))
    end,
    close_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
    right_mouse_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
    left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 30,
    max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    tab_size = 21,
    diagnostics = false, -- | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    offsets = { { filetype = 'NvimTree', text = '', padding = 1 } },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    separator_style = 'thin', -- | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
  },
  highlights = {
    background = {
      guifg = colors.grey_fg,
      guibg = colors.black2,
    },

    -- buffers
    buffer_selected = {
      guifg = colors.white,
      guibg = colors.black,
      gui = 'bold',
    },
    buffer_visible = {
      guifg = colors.light_grey,
      guibg = colors.black2,
    },

    -- for diagnostics = "nvim_lsp"
    error = {
      guifg = colors.light_grey,
      guibg = colors.black2,
    },
    error_diagnostic = {
      guifg = colors.light_grey,
      guibg = colors.black2,
    },

    -- close buttons
    close_button = {
      guifg = colors.light_grey,
      guibg = colors.black2,
    },
    close_button_visible = {
      guifg = colors.light_grey,
      guibg = colors.black2,
    },
    close_button_selected = {
      guifg = colors.red,
      guibg = colors.black,
    },
    fill = {
      guifg = colors.grey_fg,
      guibg = colors.black2,
    },
    indicator_selected = {
      guifg = colors.black,
      guibg = colors.black,
    },

    -- modified
    modified = {
      guifg = colors.red,
      guibg = colors.black2,
    },
    modified_visible = {
      guifg = colors.red,
      guibg = colors.black2,
    },
    modified_selected = {
      guifg = colors.green,
      guibg = colors.black,
    },

    -- separators
    separator = {
      guifg = colors.black2,
      guibg = colors.black2,
    },
    separator_visible = {
      guifg = colors.black2,
      guibg = colors.black2,
    },
    separator_selected = {
      guifg = colors.black2,
      guibg = colors.black2,
    },

    -- tabs
    tab = {
      guifg = colors.light_grey,
      guibg = colors.one_bg3,
    },
    tab_selected = {
      guifg = colors.black2,
      guibg = colors.nord_blue,
    },
    tab_close = {
      guifg = colors.red,
      guibg = colors.black,
    },
  },
})

vim.cmd([[
nnoremap <silent><TAB> :BufferLineCycleNext<CR>
nnoremap <silent><S-TAB> :BufferLineCyclePrev<CR>

nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>
]])
