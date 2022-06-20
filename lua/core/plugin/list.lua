vim.cmd('packadd packer.nvim')

local plugins = {

  ['nvim-lua/plenary.nvim'] = {},
  ['wbthomason/packer.nvim'] = {},
  ['b0o/schemastore.nvim'] = {},
  ['weilbith/nvim-code-action-menu'] = {
    cmd = 'CodeActionMenu',
  },

  ['itsuki0927/base46'] = {
    config = function()
      local ok, base46 = pcall(require, 'base46')
      if ok then
        base46.load_theme()
      end
    end,
  },

  ['goolord/alpha-nvim'] = {
    after = 'base46',
    config = function()
      require('plugin-configs.alpha')
    end,
  },

  ['kyazdani42/nvim-web-devicons'] = {
    after = 'base46',
    config = function()
      require('plugin-configs.icons')
    end,
  },

  ['iamcco/markdown-preview.nvim'] = {
    run = 'cd app && yarn',
    cmd = { 'MarkdownPreview', 'MarkdownPreviewStop' },
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.g.mkdp_auto_close = 0
      require('core.mappings').markdown_preview()
    end,
    ft = { 'markdown' },
  },

  ['neovim/nvim-lspconfig'] = {
    config = "require('core.lsp')",
    opt = true,
    setup = function()
      require('core.lazy_load').on_file_open('nvim-lspconfig')
    end,
  },

  ['ray-x/lsp_signature.nvim'] = {
    event = 'InsertCharPre',
    config = function()
      require('plugin-configs.lspsignature')
    end,
  },

  ['rafamadriz/friendly-snippets'] = {
    event = 'InsertEnter',
  },

  ['hrsh7th/nvim-cmp'] = {
    after = 'friendly-snippets',
    config = function()
      require('plugin-configs.cmp')
    end,
  },

  ['windwp/nvim-autopairs'] = {
    after = 'nvim-cmp',
    config = function()
      require('plugin-configs.autopairs')
    end,
  },

  ['L3MON4D3/LuaSnip'] = {
    wants = 'friendly-snippets',
    after = 'nvim-cmp',
    config = function()
      require('plugin-configs.luasnip')
    end,
  },

  ['saadparwaiz1/cmp_luasnip'] = {
    after = 'LuaSnip',
  },

  ['hrsh7th/cmp-nvim-lsp'] = {
    after = 'cmp_luasnip',
  },

  ['hrsh7th/cmp-buffer'] = {
    after = 'cmp-nvim-lsp',
  },

  ['hrsh7th/cmp-nvim-lua'] = {
    after = 'cmp_luasnip',
  },

  ['hrsh7th/cmp-path'] = {
    after = 'cmp-buffer',
  },

  ['nvim-treesitter/nvim-treesitter'] = {
    cmd = require('core.lazy_load').treesitter_cmds,
    config = function()
      require('plugin-configs.treesitter')
    end,
    setup = function()
      require('core.lazy_load').on_file_open('nvim-treesitter')
    end,
    run = ':TSUpdate',
  },

  ['akinsho/bufferline.nvim'] = {
    branch = 'main',
    opt = true,
    config = function()
      require('plugin-configs.bufferline')
    end,
    setup = function()
      require('core.lazy_load').bufferline()
      require('core.mappings').bufferline()
    end,
  },

  ['kyazdani42/nvim-tree.lua'] = {
    ft = 'alpha',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      require('plugin-configs.nvimtree')
    end,
    setup = function()
      require('core.mappings').nvimtree()
    end,
  },

  ['nvim-telescope/telescope.nvim'] = {
    module = 'telescope',
    cmd = 'Telescope',
    config = function()
      require('plugin-configs.telescope')
    end,
    setup = function()
      require('core.mappings').telescope()
    end,
  },

  ['NvChad/nvim-colorizer.lua'] = {
    event = 'BufRead',
    opt = true,
    setup = function()
      require('core.lazy_load').colorizer()
    end,
    config = function()
      require('plugin-configs.colorizer')
    end,
  },

  ['lewis6991/gitsigns.nvim'] = {
    after = 'base46',
    opt = true,
    config = function()
      require('plugin-configs.gitsigns')
    end,
    setup = function()
      require('core.lazy_load').gitsigns()
    end,
  },

  ['lukas-reineke/indent-blankline.nvim'] = {
    opt = true,
    event = 'BufRead',
    setup = function()
      require('core.lazy_load').on_file_open('indent-blankline.nvim')
    end,
    config = function()
      require('plugin-configs.blankline')
    end,
  },

  ['numToStr/Comment.nvim'] = {
    module = 'Comment',
    keys = { { 'n', 'gcc' }, { 'v', 'gc' } },
    config = function()
      require('plugin-configs.comment')
    end,
    setup = function()
      require('core.mappings').comment()
    end,
  },

  ['JoosepAlviste/nvim-ts-context-commentstring'] = {
    after = 'nvim-treesitter',
  },

  ['jose-elias-alvarez/null-ls.nvim'] = {
    event = 'InsertLeave',
    config = function()
      require('plugin-configs.null_ls')
    end,
  },

  ['voldikss/vim-floaterm'] = {
    cmd = { 'FloatermNew', 'FloatermToggle' },
    config = function()
      require('plugin-configs.floaterm')
    end,
    setup = function()
      require('core.mappings').floaterm()
    end,
  },

  ['folke/todo-comments.nvim'] = {
    event = 'BufRead',
    module = 'TodoComments',
    config = function()
      require('plugin-configs.todo_comments')
    end,
    setup = function()
      require('core.mappings').todo_comments()
    end,
  },

  ['mg979/vim-visual-multi'] = {
    keys = { { 'n', '<c-n>' }, { 'v', '<c-n>' } },
    setup = function()
      require('core.mappings').visual_multi()
    end,
  },
}

require('core.plugin').run(plugins)
