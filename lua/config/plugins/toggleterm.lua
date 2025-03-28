---@type LazySpec
return {
  'akinsho/nvim-toggleterm.lua',
  version = '*',
  keys = { '<leader>tg', '<C-\\>' },
  opts = {
    size = 100,
    shell = vim.o.shell == '/bin/fish' and '/bin/zsh' or vim.o.shell,
    direction = 'float',
    open_mapping = [[<c-\>]],
    highlights = { FloatBorder = { link = 'FloatBorder' } },
    float_opts = { border = 'single' },
  },
  config = function(_, opts)
    local Terminal = require('toggleterm.terminal').Terminal
    local toggleterm = require('toggleterm')
    local lazygit = Terminal:new({
      cmd = 'lazygit',
      dir = 'git_dir',
      direction = 'float',
      float_opts = { border = 'single' },
      size = 100,
    })

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], opts)
      -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      -- vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    local function lazygit_toggle()
      lazygit:toggle()
    end

    toggleterm.setup(opts)
    vim.keymap.set('n', '<leader>tg', lazygit_toggle, { desc = '[T]erminal [L]azygit' })
  end,
}
