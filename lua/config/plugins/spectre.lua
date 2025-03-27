return {
  {
    'windwp/nvim-spectre',
    enabled = true,
    event = 'BufRead',
    keys = {
      {
        '<leader>sr',
        function()
          require('spectre').open()
        end,
        desc = 'Replace',
      },
      {
        '<leader>sw',
        function()
          require('spectre').open_visual({ select_word = true })
        end,
        desc = 'Replace Word',
      },
      {
        '<leader>sf',
        function()
          require('spectre').open_file_search()
        end,
        desc = 'Replace Buffer',
      },
    },
  },
}
