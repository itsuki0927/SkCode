local M = {}

M.options = {
  cmdheight = 1,
  mapleader = ' ',
  mouse = 'a',
  nvimtree = {
    lazyload = true,
  },
}

M.ui = {
  hl_override = '', -- path of your file that contains highlights
  theme = 'onedark',
  italic_comments = false,
  transparency = false,
}

-- plugin 设置 --

M.plugins = {
  status = {
    bufferline = true,
    feline = true,
    blankline = true,
    colorizer = true,
    gitsigns = true,
    better_escapse = true,
    cmp = true,
    autopairs = true,
    alpha = true,
    comment = true,
    nvimtree = true,
    format = true,
    toggleterm = true,
  },
  options = {
    nvimtree = {
      enable_git = 0,
      lazy_load = true,
      ui = {
        allow_resize = true,
        side = 'left',
        width = 25,
        hide_root_folder = true,
      },
    },
    statusline = {
      -- hide, show on specific filetypes
      hidden = {
        'help',
        'dashboard',
        'NvimTree',
        'terminal',
      },
      shown = {},

      -- truncate statusline on small screens
      shortline = true,
      style = 'block', -- default, round , slant , block , arrow
    },
  },
  defualt_plugin_config_replace = {},
}

-- mappings --

--  --

M.mappings = {}

-- 插件mappings --

M.mappings.plugins = {
  nvimtree = {
    toggle = '<leader>e',
  },
  telescope = {
    find_files = '<leader>f',
  },
  bufferline = {
    next_buffer = '<TAB>',
    prev_buffer = '<S-TAB>',
  },
  lspconfig = {
    declaration = 'gD',
    definition = 'gd',
    hover = 'K',
    implementation = 'gi',
    signature_help = 'gk',
    references = 'gr',
    show_line = 'gl',
    float_diagnostics = 'ge',
    goto_prev = '[d',
    goto_next = ']d',
  },
  comment = {
    toggle = '<leader>/',
  },
}

return M
