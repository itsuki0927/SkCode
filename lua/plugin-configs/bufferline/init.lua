local present, configs = pcall(require, 'bufferline')

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
  })
end
