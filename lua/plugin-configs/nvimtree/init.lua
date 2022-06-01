local present, nvimtree = pcall(require, 'nvim-tree')

if present then
  local nvimtree_default_options = skcode.load_config().plugins.options.nvimtree

  nvimtree.setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
      'startify',
      'dashboard',
      'alpha',
    },
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
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
    actions = {
      open_file = {
        resize_window = true,
        quit_on_open = nvimtree_default_options.quit_on_open,
      },
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
      icons = {
        webdev_colors = true,
        git_placement = 'before',
        padding = ' ',
        symlink_arrow = ' ➛ ',
        glyphs = {
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
            symlink_open = '',
          },
        },
      },
    },
  })
end
