local present, nvimtree = pcall(require, 'nvim-tree')

if not present then
  return
end

-- 设置图标
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {
    unstaged = '',
    staged = '✓',
    unmerged = '',
    renamed = '➜',
    deleted = '',
    untracked = 'u',
    ignored = '◌',
  },
  folder = {
    default = '',
    open = '',
    empty = '',
    empty_open = '',
    symlink = '',
  },
}

vim.g.nvim_tree_indent_markers = 1 -- 文件夹打开显示缩进

nvimtree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {
    'startify',
    'dashboard',
    'alpha',
  },
  auto_close = true,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  update_to_buf_dir = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
        { key = { 'l', '<CR>', 'o' }, action = 'edit' },
        { key = 'h', action = 'close_node' },
        { key = 'v', action = 'vsplit' },
      },
    },
    number = false,
    relativenumber = false,
  },
  disable_window_picker = 0,
  root_folder_modifier = ':t',
})
