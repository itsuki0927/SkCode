return {
  {
    'NvChad/base46',
    branch = 'v3.0',
    build = function()
      require('base46').load_all_highlights()
    end,
  },

  {
    'NvChad/ui',
    branch = 'v3.0',
    config = function()
      require('nvchad')
    end,
  },

  'nvzone/volt',

  {
    'lukas-reineke/virt-column.nvim',
    opts = {
      char = '│',
      virtcolumn = '100',
    },
  },
}
