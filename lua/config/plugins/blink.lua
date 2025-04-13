local kind_icons = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}

return {
  {
    'saghen/blink.cmp',
    version = '*',
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
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
        dependencies = {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath('config') .. '/snippets' } })
          end,
        },
        opts = { history = true, delete_check_events = 'TextChanged' },
      },
    },

    build = 'cargo build --release',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',

        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        -- ['<Cr>'] = { 'select_and_accept', }
        ['<C-n>'] = { 'snippet_forward', 'fallback' },
        ['<C-p>'] = { 'snippet_backward', 'fallback' },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        kind_icons = kind_icons,
      },

      -- signature = { enabled = true, window = { border = 'single' } },
      signature = { enabled = true },

      snippets = { preset = 'luasnip' },

      cmdline = {
        enabled = true,
        completion = { menu = { auto_show = true } },

        keymap = {
          preset = 'inherit',
          ['<C-k>'] = { 'select_prev', 'fallback' },
          ['<C-j>'] = { 'select_next', 'fallback' },
        },
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == ':' then
            return { 'path', 'cmdline' }
          end
          if type == '/' or type == '?' then
            return { 'buffer' }
          end
          return {}
        end,
      },

      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },

      completion = {
        documentation = {
          auto_show = true,
          -- window = { border = 'single' },
        },

        menu = {
          -- border = 'single',
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind', 'source_name' },
            },
            components = {
              kind = {
                text = function(ctx)
                  return string.lower(ctx.kind) .. ' '
                end,
              },
              source_name = {
                text = function(ctx)
                  return '[' .. ctx.source_name .. ']'
                end,
              },
            },
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
