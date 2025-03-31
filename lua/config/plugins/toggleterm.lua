---@type LazySpec
return {
  'akinsho/nvim-toggleterm.lua',
  version = '*',
  keys = { '<C-\\>' },
  opts = {
    size = 100,
    shell = vim.o.shell == '/bin/fish' and '/bin/zsh' or vim.o.shell,
    direction = 'float',
    open_mapping = [[<c-\>]],
    highlights = { FloatBorder = { link = 'FloatBorder' } },
    float_opts = { border = 'single' },
  },
  config = function(_, opts)
    local toggleterm = require('toggleterm')

    function _G.set_terminal_keymaps()
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { buffer = 0 })
      vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], { buffer = 0 })
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    toggleterm.setup(opts)
  end,
}
