return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufReadPost',
    ---@module "ibl"
    ---@type ibl.config

    config = function()
      dofile(vim.g.base46_cache .. 'blankline')
      local highlight = {
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      }

      local base46 = require('base46')
      local theme_colors = base46.get_theme_tb('base_30')

      local hooks = require('ibl.hooks')
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = theme_colors.red })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = theme_colors.yellow })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = theme_colors.blue })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = theme_colors.orange })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = theme_colors.green })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = theme_colors.pink })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = theme_colors.cyan })
      end)

      require('ibl').setup({
        indent = { char = '│', highlight = 'IblChar' },
        scope = { char = '│', highlight = highlight, show_start = true },
        exclude = {
          buftypes = { 'nofile', 'prompt', 'quickfix', 'terminal' },
          filetypes = {
            'aerial',
            'alpha',
            'dashboard',
            'help',
            'lazy',
            'mason',
            'neo-tree',
            'NvimTree',
            'neogitstatus',
            'notify',
            'startify',
            'toggleterm',
            'Trouble',
          },
        },
      })

      dofile(vim.g.base46_cache .. 'blankline')
    end,
  },
}
