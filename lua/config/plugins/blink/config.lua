dofile(vim.g.base46_cache .. 'blink')

local opts = {
  appearance = { nerd_font_variant = 'normal' },
  fuzzy = { implementation = 'prefer_rust' },
  signature = { enabled = true },
  snippets = { preset = 'luasnip' },

  keymap = {
    preset = 'enter',

    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
    -- ['<Cr>'] = { 'select_and_accept', }
    ['<C-n>'] = { 'snippet_forward', 'fallback' },
    ['<C-p>'] = { 'snippet_backward', 'fallback' },
  },

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
    default = { 'avante', 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
    -- default = { 'avante', 'codeium', 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      avante = {
        module = 'blink-cmp-avante',
        name = 'Avante',
        opts = {
          -- options for blink-cmp-avante
        },
      },

      -- codeium = { name = 'Codeium', module = 'codeium.blink', async = true },

      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },

      -- 从自动完成中排除关键字/常量
      lsp = {
        name = 'LSP',
        module = 'blink.cmp.sources.lsp',
        transform_items = function(_, items)
          return vim.tbl_filter(function(item)
            return item.kind ~= require('blink.cmp.types').CompletionItemKind.Keyword
          end, items)
        end,
      },

      -- 路径补全来自cwd当前缓冲区的目录
      path = {
        opts = {
          get_cwd = function(_)
            return vim.fn.getcwd()
          end,
        },
      },

      -- cmdline = {
      --   -- ignores cmdline completions when executing shell commands
      --   enabled = function()
      --     return vim.fn.getcmdtype() ~= ':' or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
      --   end,
      -- },
    },
  },

  completion = {
    ghost_text = { enabled = true },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100,
      window = { border = 'single' },
    },

    menu = require('config.plugins.blink.utils').menu,
  },
}

return opts
