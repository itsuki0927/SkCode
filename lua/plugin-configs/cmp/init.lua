local present, cmp = pcall(require, 'cmp')

if present then
  require('base46').load_highlight('cmp')

  local cmp_window = require('cmp.utils.window')

  cmp_window.info_ = cmp_window.info
  cmp_window.info = function(self)
    local info = self:info_()
    info.scrollable = false
    return info
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    experimental = {
      native_menu = false,
      ghost_text = false,
    },
    mapping = {
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<C-y>'] = cmp.mapping(
        cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        { 'i', 'c' }
      ),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    formatting = {
      format = function(entry, vim_item)
        local icons = require('plugin-configs.cmp.lspkind_icons')
        vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind:lower())

        vim_item.menu = ({
          buffer = '[Buf]',
          nvim_lsp = '[Lsp]',
          nvim_lua = '[Lua]',
          path = '[Path]',
          luasnip = '[Snip]',
        })[entry.source.name]

        return vim_item
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'luasnip' },
      { name = 'nvim_lua' },
      { name = 'path' },
    },

    sorting = {
      -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,

        -- copied from cmp-under, but I don't think I need the plugin for this.
        -- I might add some more of my own.
        function(entry1, entry2)
          local _, entry1_under = entry1.completion_item.label:find('^_+')
          local _, entry2_under = entry2.completion_item.label:find('^_+')
          entry1_under = entry1_under or 0
          entry2_under = entry2_under or 0
          if entry1_under > entry2_under then
            return false
          elseif entry1_under < entry2_under then
            return true
          end
        end,

        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
  })
end

_ = vim.cmd([[
  augroup CmpZsh
    au!
    autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
  augroup END
]])
