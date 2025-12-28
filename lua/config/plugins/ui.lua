return {
  {
    'NvChad/base46',
    branch = 'v3.0',
    build = function()
      require('base46').load_all_highlights()
    end,
  },

  {
    'NvChad/ui',
    branch = 'v3.0',
    config = function()
      require('nvchad')
    end,
  },

  'nvzone/volt',

  {
    'lukas-reineke/virt-column.nvim',
    opts = {
      char = '│',
      virtcolumn = '100',
    },
  },

  {
    'rmagatti/goto-preview',
    dependencies = { 'rmagatti/logger.nvim' },
    event = 'BufEnter',
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    keys = {
      {
        '<leader>pd',
        "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
        noremap = true,
        desc = 'goto preview definition',
      },
      {
        '<leader>pD',
        "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
        noremap = true,
        desc = 'goto preview declaration',
      },
      {
        '<leader>pi',
        "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
        noremap = true,
        desc = 'goto preview implementation',
      },
      {
        '<leader>pt',
        "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
        noremap = true,
        desc = 'goto preview type definition',
      },
      {
        '<leader>pr',
        "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
        noremap = true,
        desc = 'goto preview references',
      },
      {
        '<leader>P',
        "<cmd>lua require('goto-preview').close_all_win()<CR>",
        noremap = true,
        desc = 'close all preview windows',
      },
    },
    opts = {
      references = {
        provider = 'telescope',
        telescope = require('telescope.themes').get_dropdown({
          previewer = true,
          initial_mode = 'insert',
          sorting_strategy = 'ascending',
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              width = 0.95,
              height = 0.8,
              preview_width = 0.6,
            },
          },
          borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        }),
      },
    },
  },
}
