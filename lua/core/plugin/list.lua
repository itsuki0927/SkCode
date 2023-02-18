require('lazy').setup({
  { 'nvim-lua/plenary.nvim', lazy = true },
  { 'b0o/schemastore.nvim', lazy = true },
  { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' },
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  ------------------------------ UI ----------------------------------
  {
    'itsuki0927/base46',
    config = function()
      local ok, base46 = pcall(require, 'base46')
      if ok then
        base46.load_theme()
      end
    end,
  },

  {
    'NvChad/nvim-colorizer.lua',
    event = { 'CursorHold' },
    config = function()
      require('plugin-configs.colorizer')
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'BufRead',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'CursorHold',
    build = ':TSUpdate',
    config = function()
      require('plugin-configs.treesitter')
    end,
  },

  {
    'akinsho/bufferline.nvim',
    event = { 'BufNewFile', 'BufRead', 'TabEnter' },
    config = function()
      require('plugin-configs.bufferline')
    end,
    init = function()
      require('core.mappings').bufferline()
    end,
  },

  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
      require('plugin-configs.alpha')
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('plugin-configs.gitsigns')
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    config = function()
      require('plugin-configs.blankline')
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = 'BufRead',
    lazy = true,
    config = function()
      require('plugin-configs.todo_comments')
    end,
    init = function()
      require('core.mappings').todo_comments()
    end,
  },

  ------------------------------ UI ----------------------------------

  ------------------------------ 功能组件 ----------------------------------

  -- 目录树
  {
    'kyazdani42/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      require('plugin-configs.nvimtree')
    end,
    init = function()
      require('core.mappings').nvimtree()
    end,
  },

  -- lsp
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('core.lsp')
    end,
  },

  -- 片段
  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    config = function()
      require('plugin-configs.luasnip')
    end,
  },

  -- 自动完成
  {
    'hrsh7th/nvim-cmp',
    event = 'VeryLazy',
    config = function()
      require('plugin-configs.cmp')
    end,
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
  },

  -- 自动补全括号
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = 'hrsh7th/nvim-cmp',
    config = function()
      require('plugin-configs.autopairs')
    end,
  },

  -- 自动关闭标签
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    dependencies = 'hrsh7th/nvim-cmp',
    opts = {
      filetypes = { 'javascriptreact', 'typescriptreact', 'html', 'vue', 'tsx', 'jsx' },
    },
  },

  -- 格式化
  {
    'mhartington/formatter.nvim',
    event = 'BufWrite',
    config = function()
      require('plugin-configs.formatter')
    end,
  },

  -- 注释
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('plugin-configs.comment')
    end,
    init = function()
      require('core.mappings').comment()
    end,
  },

  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd = 'Copilot',
  --   event = 'VimEnter',
  --   config = function()
  --     vim.defer_fn(function()
  --       require('copilot').setup()
  --     end, 100)
  --   end,
  --   opts = {
  --     suggestion = { enabled = false },
  --     panel = { enabled = false },
  --   },
  -- },
  --
  -- {
  --   'zbirenbaum/copilot-cmp',
  --   dependencies = 'zbirenbaum/copilot.lua',
  --   config = function()
  --     require('copilot_cmp').setup()
  --   end,
  -- },

  -- 输入提示函数参数
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    config = true,
    opts = {
      bind = true,
      doc_lines = 0,
      floating_window = true,
      fix_pos = true,
      hint_enable = true,
      hint_prefix = ' ',
      hint_scheme = 'String',
      hi_parameter = 'Search',
      max_height = 22,
      max_width = 120,
      handler_opts = {
        border = 'single',
      },
      zindex = 200,
      padding = '',
    },
  },

  -- 几个文件之间快速跳转
  {
    'ThePrimeagen/harpoon',
    event = 'VeryLazy',
    config = function()
      require('plugin-configs.harpoon')
    end,
    init = function()
      require('core.mappings').harpoon()
    end,
  },

  -- 模糊搜索
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    config = function()
      require('plugin-configs.telescope')
    end,
    init = function()
      require('core.mappings').telescope()
    end,
  },

  --
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = true,
  },

  -- Markdown 预览
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    keys = {
      {
        '<leader>mp',
        ':MarkdownPreview <CR>',
      },
      {
        '<leader>ms',
        ':MarkdownPreviewStop <CR>',
      },
    },
    build = ':call mkdp#util#install()',
  },

  -- 快速跳转
  {
    'phaazon/hop.nvim',
    keys = {
      {
        'f',
        function()
          require('hop').hint_char1({
            direction = require('hop.hint').HintDirection.AFTER_CURSOR,
            current_line_only = true,
          })
        end,
      },
      {
        'F',
        function()
          require('hop').hint_char1({
            direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
            current_line_only = true,
          })
        end,
      },
      {
        't',
        function()
          require('hop').hint_char1({
            direction = require('hop.hint').HintDirection.AFTER_CURSOR,
            current_line_only = true,
            hint_offset = -1,
          })
        end,
      },
      {
        'T',
        function()
          require('hop').hint_char1({
            direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
            current_line_only = true,
            hint_offset = 1,
          })
        end,
      },
    },
    init = function()
      require('core.mappings').hop()
    end,
    config = function()
      require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
    end,
  },

  -- 多光标
  {
    'mg979/vim-visual-multi',
    event = 'VeryLazy',
  },

  -- 浮窗
  {
    'voldikss/vim-floaterm',
    cmd = { 'FloatermNew', 'FloatermToggle' },
    config = function()
      require('plugin-configs.floaterm')
    end,
    init = function()
      require('core.mappings').floaterm()
    end,
  },

  -- 不错的替换功能
  -- {
  --   'cshuaimin/ssr.nvim',
  --   keys = {
  --     {
  --       '<leader>sr',
  --       function()
  --         require('ssr').open()
  --       end,
  --       mode = { 'n', 'x' },
  --       desc = 'Structural Replace',
  --     },
  --   },
  --   opts = {
  --     border = 'single',
  --   },
  -- },

  --  ['simrat39/symbols-outline.nvim'] = {
  --    cmd = {
  --      'SymbolsOutline',
  --      'SymbolsOutlineOpen',
  --      'SymbolsOutlineClose',
  --    },
  --    config = function()
  --      require('symbols-outline').setup()
  --    end,
  --  },

  -- Git Diff
  -- {
  --   'sindrets/diffview.nvim',
  --   keys = {
  --     { '<leader>dv', ':DiffviewOpen<CR>' },
  --     { '<leader>dc', ':DiffviewClose<CR>' },
  --     { '<leader>dq', ':DiffviewClose<CR>:q<CR>' },
  --   },
  --   cmd = { 'DiffviewOpen', 'DiffviewClose' },
  -- },

  ------------------------------ 功能组件 ----------------------------------
}, {

  ui = {
    icons = {
      -- cmd = '⌘',
      -- config = '🛠',
      -- event = '📅',
      -- ft = '📂',
      -- init = '⚙',
      -- keys = '🗝',
      -- plugin = '🔌',
      -- runtime = '💻',
      -- source = '📄',
      -- start = '🚀',
      -- task = '📌',
    },
  },
})
