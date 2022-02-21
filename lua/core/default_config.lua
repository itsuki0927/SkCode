local M = {}

-- vim配置
M.options = {
  cmdheight = 1,
  mapleader = ' ',
  mouse = 'a',
  nvimtree = {
    lazyload = true,
  },
}

-- UI配置
M.ui = {
  theme = 'onedark',
  italic_comments = false,
  transparency = false,
}

-- 插件配置
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
      lazy_load = true,
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
}

-- 键位配置
M.mappings = {
  misc = {
    close_buffer = '<leader>x',
    save = '<leader>w',
    quit = '<leader>q',
    nohightlight = '<leader><CR>',
    esc = 'jk',
  },

  window_nav = {
    moveLeft = '<C-h>',
    moveRight = '<C-l>',
    moveUp = '<C-k>',
    moveDown = '<C-j>',

    resizeUp = '<M-Up>',
    resizeDown = '<M-Down>',
    resizeLeft = '<M-Left>',
    resizeRight = '<M-Right>',
  },

  insert_nav = {
    backward = '<C-h>',
    end_of_line = '<C-e>',
    forward = '<C-l>',
    next_line = '<C-k>',
    prev_line = '<C-j>',
    beginning_of_line = '<C-a>',
  },
}

-- 插件键位配置
M.mappings.plugins = {
  nvimtree = {
    toggle = '<leader>e',
  },
  telescope = {
    find_files = '<leader>f',
    live_grep = '<leader>F',
    buffers = '<leader>sb',
    keymaps = '<leader>sk',
    commands = '<leader>sc',
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
    type_definition = '<leader>D',
    rename = '<leader>rn',
    code_action = '<leader>ca',
    references = 'gr',
    show_line = 'gl',
    goto_prev = '[d',
    goto_next = ']d',
  },
  comment = {
    toggle = '<leader>/',
  },
  gitsigns = {
    next_hunk = ']c',
    prev_hunk = '[c',
    stage_hunk = '<leader>hs',
    reset_hunk = '<leader>hr',
    stage_buffer = '<leader>hS',
    undo_stage_hunk = '<leader>hu',
    preview_hunk = '<leader>hp',
    reset_buffer = '<leader>hR',
    blame_line = '<leader>hb',
    toggle_current_line_blame = '<leader>tb',
    diffthis = '<leader>hd',
    diffThis = '<leader>hD',
    toggle_deleted = '<leader>td',
    select_hunk = 'ih',
  },
}

return M
