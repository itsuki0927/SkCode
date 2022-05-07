local plugin_settings = require('core.utils').load_config().plugins
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
  use({
    'NvChad/base46',
    after = 'packer.nvim',
    config = function()
      require('colors').init()
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
    'neovim/nvim-lspconfig',
    config = "require('core.lsp')",
    opt = true,
    setup = function()
      require('core.utils').packer_lazy_load('nvim-lspconfig')
      vim.defer_fn(function()
        vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
      end, 0)
    end,
  })

  use({
    'ray-x/lsp_signature.nvim',
    disable = not plugin_settings.status.lspsignature,
    event = 'InsertCharPre',
    config = function()
      require('plugin-configs.lspsignature')
    end,
  })

  use({
    'rafamadriz/friendly-snippets',
    disable = not plugin_settings.status.cmp,
    event = 'InsertEnter',
  })

  use({
    'hrsh7th/nvim-cmp',
    disable = not plugin_settings.status.cmp,
    after = 'friendly-snippets',
    config = function()
      require('plugin-configs.cmp')
    end,
  })

  use({
    'windwp/nvim-autopairs',
    disable = not plugin_settings.status.autopairs,
    after = 'nvim-cmp',
    config = function()
      require('plugin-configs.autopairs')
    end,
  })

  use({
    'L3MON4D3/LuaSnip',
    disable = not plugin_settings.status.cmp,
    wants = 'friendly-snippets',
    after = 'nvim-cmp',
    config = function()
      require('plugin-configs.luasnip')
    end,
  })
  use({
    'saadparwaiz1/cmp_luasnip',
    disable = not plugin_settings.status.cmp,
    after = 'LuaSnip',
  })
  use({
    'hrsh7th/cmp-nvim-lsp',
    disable = not plugin_settings.status.cmp,
    after = 'cmp_luasnip',
  })
  use({
    'hrsh7th/cmp-buffer',
    disable = not plugin_settings.status.cmp,
    after = 'cmp-nvim-lsp',
  })
  use({
    'hrsh7th/cmp-nvim-lua',
    disable = not plugin_settings.status.cmp,
    after = 'cmp_luasnip',
  })
  use({
    'hrsh7th/cmp-path',
    disable = not plugin_settings.status.cmp,
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
    disable = not plugin_settings.status.feline,
    after = 'nvim-web-devicons',
    config = function()
      require('plugin-configs.statusline')
    end,
  })
  use({
    'akinsho/bufferline.nvim',
    disable = not plugin_settings.status.bufferline,
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
    disable = not plugin_settings.status.nvimtree,
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
    disable = not plugin_settings.status.colorizer,
    event = 'BufRead',
    config = function()
      require('plugin-configs.colorizer')
    end,
  })

  use({
    'lewis6991/gitsigns.nvim',
    disable = not plugin_settings.status.gitsigns,
    opt = true,
    config = function()
      require('plugin-configs.gitsigns')
    end,
    setup = function()
      require('core.utils').packer_lazy_load('gitsigns.nvim')
    end,
  })

  use({
    'goolord/alpha-nvim',
    disable = not plugin_settings.status.alpha,
    config = function()
      require('plugin-configs.alpha')
    end,
  })

  use({
    'lukas-reineke/indent-blankline.nvim',
    disable = not plugin_settings.status.blankline,
    event = 'BufRead',
    config = function()
      require('plugin-configs.blankline')
    end,
  })

  use({
    'numToStr/Comment.nvim',
    disable = not plugin_settings.status.comment,
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
    disable = not plugin_settings.status.comment,
  })

  use({
    'jose-elias-alvarez/null-ls.nvim',
    disable = not plugin_settings.status.format,
    event = 'InsertLeave',
    config = function()
      require('plugin-configs.null_ls')
    end,
  })

  use({
    'voldikss/vim-floaterm',
    disable = not plugin_settings.status.floaterm,
    cmd = { 'FloatermNew', 'FloatermToggle' },
    config = function()
      require('plugin-configs.floaterm')
    end,
    setup = function()
      require('core.mappings').floaterm()
    end,
  })

  use({
    'filipdutescu/renamer.nvim',
    disable = not plugin_settings.status.renamer,
    after = 'nvim-lspconfig',
    module = 'Renamer',
    config = function()
      require('plugin-configs.renamer')
    end,
    setup = function()
      require('core.mappings').renamer()
    end,
  })

  use({
    'folke/todo-comments.nvim',
    disable = not plugin_settings.status.todo_comments,
    event = 'BufRead',
    module = 'TodoComments',
    config = function()
      require('plugin-configs.todo_comments')
    end,
    setup = function()
      require('core.mappings').todo_comments()
    end,
  })
end)
