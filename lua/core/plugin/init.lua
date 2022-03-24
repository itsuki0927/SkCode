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
    'NvChad/nvim-base16.lua',
    after = 'packer.nvim',
    config = function()
      require('colors').init()
    end,
  })

  use({
    'kyazdani42/nvim-web-devicons',
    after = 'nvim-base16.lua',
    config = "require('plugin-configs.icons')",
  })

  use({
    'neovim/nvim-lspconfig',
    config = "require('plugin-configs.lsp')",
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
    after = 'nvim-lspconfig',
    config = "require('plugin-configs.lspsignature')",
  })

  use({
    'rafamadriz/friendly-snippets',
    disable = not plugin_settings.status.cmp,
    event = 'InsertCharPre',
  })

  use({
    'hrsh7th/nvim-cmp',
    disable = not plugin_settings.status.cmp,
    after = 'friendly-snippets',
    config = "require('plugin-configs.cmp')",
  })

  use({
    'windwp/nvim-autopairs',
    disable = not plugin_settings.status.autopairs,
    after = 'nvim-cmp',
    config = "require('plugin-configs.autopairs')",
  })

  use({
    'L3MON4D3/LuaSnip',
    disable = not plugin_settings.status.cmp,
    wants = 'friendly-snippets',
    after = 'nvim-cmp',
    config = "require('plugin-configs.luasnip')",
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
    event = 'BufRead',
    config = "require('plugin-configs.treesitter')",
  })

  use({
    'feline-nvim/feline.nvim',
    disable = not plugin_settings.status.feline,
    after = 'nvim-web-devicons',
    config = "require('plugin-configs.statusline')",
  })
  use({
    'akinsho/bufferline.nvim',
    disable = not plugin_settings.status.bufferline,
    after = 'nvim-web-devicons',
    config = "require('plugin-configs.bufferline')",
    setup = function()
      require('core.mappings').bufferline()
    end,
  })

  use({
    'kyazdani42/nvim-tree.lua',
    disable = not plugin_settings.status.nvimtree,
    after = not plugin_settings.options.nvimtree.lazy_load and 'nvim-web-devicons',
    cmd = plugin_settings.options.nvimtree.lazy_load and { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = "require('plugin-configs.nvimtree')",
    setup = function()
      require('core.mappings').nvimtree()
    end,
  })

  use({
    'nvim-telescope/telescope.nvim',
    module = 'telescope',
    cmd = 'Telescope',
    config = "require('plugin-configs.telescope')",
    setup = function()
      require('core.mappings').telescope()
    end,
  })

  use({
    'NvChad/nvim-colorizer.lua',
    disable = not plugin_settings.status.colorizer,
    event = 'BufRead',
    config = "require('plugin-configs.colorizer')",
  })

  use({
    'lewis6991/gitsigns.nvim',
    disable = not plugin_settings.status.gitsigns,
    opt = true,
    config = "require('plugin-configs.gitsigns')",
    setup = function()
      require('core.utils').packer_lazy_load('gitsigns.nvim')
    end,
  })

  use({
    'goolord/alpha-nvim',
    disable = not plugin_settings.status.alpha,
    config = "require('plugin-configs.alpha')",
  })

  use({
    'lukas-reineke/indent-blankline.nvim',
    disable = not plugin_settings.status.blankline,
    event = 'BufRead',
    config = "require('plugin-configs.blankline')",
  })

  use({
    'numToStr/Comment.nvim',
    disable = not plugin_settings.status.comment,
    module = 'Comment',
    keys = { { 'n', 'gcc' }, { 'v', 'gc' } },
    config = "require('plugin-configs.comment')",
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
    config = "require('plugin-configs.null_ls')",
  })

  use({
    'akinsho/toggleterm.nvim',
    disable = not plugin_settings.status.toggleterm,
    keys = '<C-\\>',
    config = "require('plugin-configs.toggleterm')",
    setup = function()
      require('core.mappings').toggleterm()
    end,
  })

  use({
    'filipdutescu/renamer.nvim',
    disable = not plugin_settings.status.renamer,
    keys = '<space>ca',
    module = 'Renamer',
    config = "require('plugin-configs.renamer')",
    setup = function()
      require('core.mappings').renamer()
    end,
  })

  use({
    'folke/todo-comments.nvim',
    disable = not plugin_settings.status.todo_comments,
    event = 'BufRead',
    module = 'TodoComments',
    config = "require('plugin-configs.todo_comments')",
    setup = function()
      require('core.mappings').todo_comments()
    end,
  })
end)
