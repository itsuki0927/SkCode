local present, configs = pcall(require, 'bufferline')
local colors = require('base46').get_colors('base_30')

if present then
  configs.setup({
    options = {
      buffer_close_icon = '',
      modified_icon = '',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      diagnostics = false,
      offsets = { { filetype = 'NvimTree', text = '', padding = 1 } },
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      persist_buffer_sort = true,
      separator_style = 'thin',
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
end
