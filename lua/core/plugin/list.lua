vim.cmd('packadd packer.nvim')

local plugins = {

  ['nvim-lua/plenary.nvim'] = {},
  ['wbthomason/packer.nvim'] = {},
  ['b0o/schemastore.nvim'] = {
    module = 'schemastore',
  },
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

  ['mhartington/formatter.nvim'] = {
    event = 'BufWrite',
    config = function()
      require('plugin-configs.formatter')
    end,
  },

  ['neovim/nvim-lspconfig'] = {
    after = 'lsp_signature.nvim',
    config = "require('core.lsp')",
  },

  ['ray-x/lsp_signature.nvim'] = {
    event = { 'BufRead', 'BufNewFile', 'BufWinEnter' },
    config = function()
      require('plugin-configs.lspsignature')
    end,
  },

  ['hrsh7th/nvim-cmp'] = {
    event = 'InsertEnter',
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
    cmd = {
      'TSInstall',
      'TSBufEnable',
      'TSBufDisable',
      'TSEnable',
      'TSDisable',
      'TSModuleInhfo',
    },
    event = 'CursorHold',
    config = function()
      require('plugin-configs.treesitter')
    end,
    run = ':TSUpdate',
  },
  ['nvim-treesitter/nvim-treesitter-textobjects'] = {
    after = 'nvim-treesitter',
  },

  ['akinsho/bufferline.nvim'] = {
    branch = 'main',
    event = { 'BufNewFile', 'BufRead', 'TabEnter' },
    config = function()
      require('plugin-configs.bufferline')
    end,
    setup = function()
      require('core.mappings').bufferline()
    end,
  },

  ['kyazdani42/nvim-tree.lua'] = {
    --[[ ft = 'alpha', ]]
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

  ['nvim-telescope/telescope-fzf-native.nvim'] = {
    after = 'telescope.nvim',
    run = 'make',
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },

  ['NvChad/nvim-colorizer.lua'] = {
    event = { 'CursorHold' },
    config = function()
      require('plugin-configs.colorizer')
    end,
  },

  ['lewis6991/gitsigns.nvim'] = {
    after = 'base46',
    event = { 'BufRead' },
    config = function()
      require('plugin-configs.gitsigns')
    end,
  },

  ['lukas-reineke/indent-blankline.nvim'] = {
    opt = true,
    after = 'nvim-treesitter',
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
  },

  ['nvim-pack/nvim-spectre'] = {
    setup = function()
      require('core.mappings').spectre()
    end,
    config = function()
      require('spectre').setup()
    end,
  },

  ['windwp/nvim-ts-autotag'] = {
    after = 'nvim-treesitter',
    config = function()
      require('nvim-ts-autotag').setup({
        filetypes = {
          'javascriptreact',
          'typescriptreact',
          'html',
          'vue',
          'tsx',
          'jsx',
        },
      })
    end,
  },

  ['simrat39/symbols-outline.nvim'] = {
    cmd = {
      'SymbolsOutline',
      'SymbolsOutlineOpen',
      'SymbolsOutlineClose',
    },
    config = function()
      require('symbols-outline').setup()
    end,
  },

  ['kylechui/nvim-surround'] = {
    tag = '*',
    keys = { { 'n', 'ys' }, { 'n', 'ds' }, { 'n', 'cs' } },
    config = function()
      require('nvim-surround').setup({})
    end,
  },

  ['phaazon/hop.nvim'] = {
    branch = 'v2',
    --[[ keys = { { 'n', 'f' }, { 'n', 'F' }, { 'n', 't' }, { 'n', 'T' } }, ]]
    setup = function()
      require('core.mappings').hop()
    end,
    config = function()
      require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
    end,
  },

  ['ThePrimeagen/harpoon'] = {
    config = function()
      require('harpoon').setup({})
    end,
    setup = function()
      require('core.mappings').harpoon()
    end,
  },
}

require('core.plugin').run(plugins)
