vim.g.completeopt = 'menu,menuone,noselect,noinsert'

local present, cmp = pcall(require, 'cmp')

if present then
  local function border(hl_name)
    return {
      { '┌', hl_name },
      { '─', hl_name },
      { '┐', hl_name },
      { '│', hl_name },
      { '┘', hl_name },
      { '─', hl_name },
      { '└', hl_name },
      { '│', hl_name },
    }
  end
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
      completion = {
        border = border('CmpBorder'),
      },
      documentation = {
        border = border('CmpDocBorder'),
      },
    },
    experimental = {
      native_menu = false,
      ghost_text = true,
    },
    mapping = {
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require('luasnip').expand_or_jumpable() then
          require('luasnip').expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require('luasnip').jumpable(-1) then
          require('luasnip').jump(-1)
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
    },
    formatting = {
      format = function(entry, vim_item)
        local icons = require('plugin-configs.cmp.lspkind_icons')
        vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind:lower())

        vim_item.menu = ({
          buffer = '[BUF]',
          nvim_lsp = '[LSP]',
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
  })
end
