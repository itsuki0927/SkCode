return {
  {

    'Wansmer/treesj',
    keys = { 'gnm', 'gnj', 'gns' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require('treesj').setup({
        --[[ your config ]]
      })

      -- For default preset
      vim.keymap.set('n', 'gnm', require('treesj').toggle)
      vim.keymap.set('n', 'gnj', require('treesj').join)
      vim.keymap.set('n', 'gns', require('treesj').split)
    end,
  },
}
