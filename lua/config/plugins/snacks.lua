return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  enabled = true,
  ---@type snacks.Config
  opts = {
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      },
    },
    picker = {
      enabled = false,
      -- actions = {
      --   sidekick_send = function(...)
      --     return require('sidekick.cli.picker.snacks').send(...)
      --   end,
      -- },
      -- win = {
      --   input = {
      --     keys = {
      --       ['<a-a>'] = {
      --         'sidekick_send',
      --         mode = { 'n', 'i' },
      --       },
      --     },
      --   },
      -- },
    },
  },
  keys = {
    -- Top Pickers & Explorer
  },
  init = function() end,
}
