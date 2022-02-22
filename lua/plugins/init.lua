local plugin_settings = require('core.utils').load_config().plugins
local present, packer = pcall(require, 'plugins.packerInit')

if not present then
  return false
end

local use = packer.use

return packer.startup(function()
  use({
    'wbthomason/packer.nvim',
    event = 'VimEnter',
  })
  use('nvim-lua/plenary.nvim')
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
    config = "require('plugins.configs.icons')",
  })

  use({
    'neovim/nvim-lspconfig',
    config = "require('plugins.configs.lsp')",
    opt = true,
    setup = function()
      require('core.utils').packer_lazy_load('nvim-lspconfig')
      vim.defer_fn(function()
        vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
      end, 0)
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
    config = "require('plugins.configs.cmp')",
  })

  use({
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    disable = not plugin_settings.status.autopairs,
    config = "require('plugins.configs.others').autopairs()",
  })

  use({
    'L3MON4D3/LuaSnip',
    wants = 'friendly-snippets',
    disable = not plugin_settings.status.cmp,
    after = 'nvim-cmp',
    config = "require('plugins.configs.others').luasnip()",
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
    config = "require('plugins.configs.treesitter')",
  })

  -- use("nvim-lualine/lualine.nvim")
  use({
    'feline-nvim/feline.nvim',
    disable = not plugin_settings.status.feline,
    after = 'nvim-web-devicons',
    config = "require('plugins.configs.statusline')",
  })
  use({
    'akinsho/bufferline.nvim',
    disable = not plugin_settings.status.bufferline,
    after = 'nvim-web-devicons',
    config = "require('plugins.configs.bufferline')",
    setup = function()
      require('core.mappings').bufferline()
    end,
  })

  use({
    'kyazdani42/nvim-tree.lua',
    disable = not plugin_settings.status.nvimtree,
    after = not plugin_settings.options.nvimtree.lazy_load and 'nvim-web-devicons',
    cmd = plugin_settings.options.nvimtree.lazy_load and { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = "require('plugins.configs.nvimtree')",
    setup = function()
      require('core.mappings').nvimtree()
    end,
  })

  use({
    'nvim-telescope/telescope.nvim',
    module = 'telescope',
    cmd = 'Telescope',
    config = "require('plugins.configs.telescope')",
    setup = function()
      require('core.mappings').telescope()
    end,
  })

  use({
    'NvChad/nvim-colorizer.lua',
    disable = not plugin_settings.status.colorizer,
    event = 'BufRead',
    config = "require('plugins.configs.others').colorizer()",
  })

  use({
    'lewis6991/gitsigns.nvim',
    disable = not plugin_settings.status.gitsigns,
    opt = true,
    config = "require('plugins.configs.gitsigns')",
    setup = function()
      require('core.utils').packer_lazy_load('gitsigns.nvim')
    end,
  })

  use({
    'goolord/alpha-nvim',
    disable = not plugin_settings.status.alpha,
    config = "require('plugins.configs.alpha')",
  })

  use({
    'lukas-reineke/indent-blankline.nvim',
    disable = not plugin_settings.status.blankline,
    event = 'BufRead',
    config = "require('plugins.configs.others').blankline()",
  })

  use({
    'numToStr/Comment.nvim',
    disable = not plugin_settings.status.comment,
    module = 'Comment',
    keys = { 'gcc' },
    config = "require('plugins.configs.others').comment()",
    setup = function()
      require('core.mappings').comment()
    end,
  })

  -- use({
  --   'mhartington/formatter.nvim',
  --   disable = not plugin_settings.status.format,
  --   event = 'InsertEnter',
  --   config = "require('plugins.configs.others').formatter()",
  -- })

  use({
    'jose-elias-alvarez/null-ls.nvim',
    disable = not plugin_settings.status.format,
    event = 'InsertLeave',
    config = "require('plugins.configs.others').null_ls()",
  })

  use({
    'akinsho/toggleterm.nvim',
    disable = not plugin_settings.status.toggleterm,
    keys = '<C-\\>',
    config = "require('plugins.configs.toggleterm')",
    setup = function()
      require('core.mappings').toggleterm()
    end,
  })

  use({
    'filipdutescu/renamer.nvim',
    after = 'nvim-lspconfig',
    module = 'Renamer',
    config = "require('plugins.configs.others').renamer()",
    setup = function()
      require('core.mappings').renamer()
    end,
  })
end)
