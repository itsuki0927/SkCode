local plugin_settings = skcode.load_config().plugins
local present, packer = pcall(require, 'core.plugin.packerInit')

if not present then
  return false
end

local use = packer.use

return packer.startup(function()
  use('nvim-lua/plenary.nvim')
  use({
    'wbthomason/packer.nvim',
    event = 'VimEnter',
  })
  use('b0o/schemastore.nvim')
  use({
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  })

  use({
    'itsuki0927/base46',
    after = 'packer.nvim',
    config = function()
      local ok, base46 = pcall(require, 'base46')

      if ok then
        base46.load_theme()
      end
    end,
  })

  use({
    'kyazdani42/nvim-web-devicons',
    after = 'base46',
    config = function()
      require('plugin-configs.icons')
    end,
  })

  use({
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn',
    cmd = { 'MarkdownPreview', 'MarkdownPreviewStop' },
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.g.mkdp_auto_close = 0
      require('core.mappings').markdown_preview()
    end,
    ft = { 'markdown' },
  })

  use({
    'neovim/nvim-lspconfig',
    config = "require('core.lsp')",
    opt = true,
    setup = function()
      skcode.packer_lazy_load('nvim-lspconfig')
      vim.defer_fn(function()
        vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
      end, 0)
    end,
  })

  use({
    'ray-x/lsp_signature.nvim',
    event = 'InsertCharPre',
    config = function()
      require('plugin-configs.lspsignature')
    end,
  })

  use({
    'rafamadriz/friendly-snippets',
    event = 'InsertEnter',
  })

  use({
    'hrsh7th/nvim-cmp',
    after = 'friendly-snippets',
    config = function()
      require('plugin-configs.cmp')
    end,
  })

  use({
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    config = function()
      require('plugin-configs.autopairs')
    end,
  })

  use({
    'L3MON4D3/LuaSnip',
    wants = 'friendly-snippets',
    after = 'nvim-cmp',
    config = function()
      require('plugin-configs.luasnip')
    end,
  })
  use({
    'saadparwaiz1/cmp_luasnip',
    after = 'LuaSnip',
  })
  use({
    'hrsh7th/cmp-nvim-lsp',
    after = 'cmp_luasnip',
  })
  use({
    'hrsh7th/cmp-buffer',
    after = 'cmp-nvim-lsp',
  })
  use({
    'hrsh7th/cmp-nvim-lua',
    after = 'cmp_luasnip',
  })
  use({
    'hrsh7th/cmp-path',
    after = 'cmp-buffer',
  })

  -- treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('plugin-configs.treesitter')
    end,
    run = ':TSUpdate',
  })

  use({
    'feline-nvim/feline.nvim',
    branch = 'master',
    tag = 'v1.*',
    after = 'nvim-web-devicons',
    config = function()
      require('plugin-configs.statusline')
    end,
  })
  use({
    'akinsho/bufferline.nvim',
    branch = 'main',
    after = 'nvim-web-devicons',
    config = function()
      require('plugin-configs.bufferline')
    end,
    setup = function()
      require('core.mappings').bufferline()
    end,
  })

  use({
    'kyazdani42/nvim-tree.lua',
    after = not plugin_settings.options.nvimtree.lazy_load and 'nvim-web-devicons',
    cmd = plugin_settings.options.nvimtree.lazy_load and { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      require('plugin-configs.nvimtree')
    end,
    setup = function()
      require('core.mappings').nvimtree()
    end,
  })

  use({
    'nvim-telescope/telescope.nvim',
    module = 'telescope',
    cmd = 'Telescope',
    config = function()
      require('plugin-configs.telescope')
    end,
    setup = function()
      require('core.mappings').telescope()
    end,
  })

  use({
    'NvChad/nvim-colorizer.lua',
    event = 'BufRead',
    config = function()
      require('plugin-configs.colorizer')
    end,
  })

  use({
    'lewis6991/gitsigns.nvim',
    opt = true,
    config = function()
      require('plugin-configs.gitsigns')
    end,
    setup = function()
      skcode.packer_lazy_load('gitsigns.nvim')
    end,
  })

  use({
    'goolord/alpha-nvim',
    config = function()
      require('plugin-configs.alpha')
    end,
  })

  use({
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    config = function()
      require('plugin-configs.blankline')
    end,
  })

  use({
    'numToStr/Comment.nvim',
    module = 'Comment',
    keys = { { 'n', 'gcc' }, { 'v', 'gc' } },
    config = function()
      require('plugin-configs.comment')
    end,
    setup = function()
      require('core.mappings').comment()
    end,
  })

  use({
    'JoosepAlviste/nvim-ts-context-commentstring',
    after = 'nvim-treesitter',
  })

  use({
    'jose-elias-alvarez/null-ls.nvim',
    event = 'InsertLeave',
    config = function()
      require('plugin-configs.null_ls')
    end,
  })

  use({
    'voldikss/vim-floaterm',
    cmd = { 'FloatermNew', 'FloatermToggle' },
    config = function()
      require('plugin-configs.floaterm')
    end,
    setup = function()
      require('core.mappings').floaterm()
    end,
  })

  use({
    'folke/todo-comments.nvim',
    event = 'BufRead',
    module = 'TodoComments',
    config = function()
      require('plugin-configs.todo_comments')
    end,
    setup = function()
      require('core.mappings').todo_comments()
    end,
  })

  use({
    'mg979/vim-visual-multi',
    keys = { { 'n', '<c-n>' }, { 'v', '<c-n>' } },
    setup = function()
      require('core.mappings').visual_multi()
    end,
  })
end)
