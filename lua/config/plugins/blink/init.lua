return {

  {
    'saghen/blink.cmp',
    version = '1.*',
    event = { 'InsertEnter', 'CmdLineEnter' },

    dependencies = {
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        dependencies = { 'Bilal2453/luvit-meta' },
        opts = {
          library = {
            'lazy.nvim',
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
      {
        -- snippet plugin
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
        opts = {
          history = true,
          delete_check_events = 'TextChanged',
          updateevents = 'TextChanged,TextChangedI',
        },
        dependencies = {
          'rafamadriz/friendly-snippets',
        },
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
          require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
        end,
      },

      {
        'windwp/nvim-autopairs',
        opts = {
          fast_wrap = {},
          disable_filetype = { 'TelescopePrompt', 'vim' },
        },
      },
    },

    opts_extend = { 'sources.default' },

    opts = function()
      return require('config.plugins.blink.config')
    end,
  },
}
