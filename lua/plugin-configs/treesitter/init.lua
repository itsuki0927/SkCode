local present, treesitter = pcall(require, 'nvim-treesitter.configs')

local swap_next, swap_prev = (function()
  local swap_objects = {
    p = '@parameter.inner',
    f = '@function.outer',
    e = '@element',
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format('<leader>s%s', key)] = obj
    p[string.format('<leader>s%s', string.upper(key))] = obj
  end

  return n, p
end)()

if present then
  require('base46').load_highlight('treesitter')
  treesitter.setup({
    ensure_installed = 'all',
    sync_install = false,
    ignore_install = { '' },
    highlight = {
      enable = true,
      disable = { '' },
      additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { 'yaml' } },
    autopairs = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn',
        node_incremental = '<C-n>',
        scope_incremental = '<C-s>',
        node_decremental = '<C-r>',
      },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,

      config = {
        c = '// %s',
        lua = '-- %s',
      },
    },
    textobjects = {
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']p'] = '@parameter.inner',
          [']]'] = '@function.outer',
          [']m'] = '@class.outer',
        },
        goto_next_end = {
          ['[]'] = '@function.outer',
          [']M'] = '@class.outer',
        },
        goto_previous_start = {
          ['[p'] = '@parameter.inner',
          ['[['] = '@function.outer',
          ['[m'] = '@class.outer',
        },
        goto_previous_end = {
          [']['] = '@function.outer',
          ['[M'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = swap_next,
        swap_previous = swap_prev,
      },
    },
  })

  -- 开启折叠
  vim.o.foldmethod = 'expr'
  vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
  vim.wo.foldenable = false
end
