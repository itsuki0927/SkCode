---@type ChadrcConfig
local options = {
  base46 = {
    theme = 'tokyonight', -- default theme
    hl_add = {},
    hl_override = {},
    integrations = {},
    changed_themes = {},
    transparency = false,
    theme_toggle = { 'tokyonight', 'one_light' },
  },

  ui = {
    telescope = { style = 'bordered' }, -- borderless / bordered

    statusline = {
      enabled = true,
      theme = 'default', -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      -- round and block will work for minimal theme only
      separator_style = 'block',
      order = nil,
      modules = nil,
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = true,
      lazyload = true,
      order = { 'treeOffset', 'buffers', 'tabs', 'btns' },
      modules = nil,
      bufwidth = 21,
    },
  },

  nvdash = {
    load_on_startup = true,
    header = {
      '                            ',
      '     ▄▄         ▄ ▄▄▄▄▄▄▄   ',
      '   ▄▀███▄     ▄██ █████▀    ',
      '   ██▄▀███▄   ███           ',
      '   ███  ▀███▄ ███           ',
      '   ███    ▀██ ███           ',
      '   ███      ▀ ███           ',
      '   ▀██ █████▄▀█▀▄██████▄    ',
      '     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ',
      '                            ',
      '     Powered By  eovim    ',
      '                            ',
    },

    buttons = {
      { txt = '  Find File', keys = 'ff', cmd = 'Telescope find_files' },
      { txt = '  Restore Session', keys = 'rs', cmd = ':lua require("persistence").load()<cr>' },
      { txt = '󰈭  Find Word', keys = 'fw', cmd = 'Telescope live_grep' },
      { txt = '󱥚  Themes', keys = 'th', cmd = ":lua require('nvchad.themes').open()" },
      { txt = '  Mappings', keys = 'ch', cmd = 'NvCheatsheet' },

      { txt = '─', hl = 'NvDashFooter', no_gap = true, rep = true },

      {
        txt = function()
          local stats = require('lazy').stats()
          local ms = math.floor(stats.startuptime) .. ' ms'
          return '  Loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms
        end,
        hl = 'NvDashFooter',
        no_gap = true,
      },

      { txt = '─', hl = 'NvDashFooter', no_gap = true, rep = true },
    },
  },

  term = {
    winopts = { number = false, relativenumber = false },
    sizes = { sp = 0.3, vsp = 0.2, ['bo sp'] = 0.3, ['bo vsp'] = 0.2 },
    float = {
      relative = 'editor',
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = 'single',
    },
  },

  lsp = { signature = false },

  cheatsheet = {
    theme = 'grid', -- simple/grid
    excluded_groups = { 'terminal (t)', 'autopairs', 'Nvim', 'Opens' }, -- can add group name or with mode
  },

  colorify = {
    enabled = true,
    mode = 'virtual', -- fg, bg, virtual
    virt_text = '󱓻 ',
    highlight = { hex = true, lspvars = true },
  },
}

return options
