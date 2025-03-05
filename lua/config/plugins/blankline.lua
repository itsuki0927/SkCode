dofile(vim.g.base46_cache .. 'blankline')

return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufReadPost',
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = { char = '│', highlight = 'IblChar' },
      scope = { char = '│', highlight = 'IblScopeChar' },
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
    },
  },
}
