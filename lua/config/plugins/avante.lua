return {
  {
    'yetone/avante.nvim',
    -- 如果您想从源代码构建，请执行 `make BUILD_FROM_SOURCE=true`
    -- ⚠️ 一定要加上这一行配置！！！！！
    build = vim.fn.has('win32') ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
      or 'make',
    event = 'VeryLazy',
    version = false, -- 永远不要将此值设置为 "*"！永远不要！
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      web_search_engine = {
        provider = 'google',
      },
      -- 在此处添加任何选项
      -- 例如
      provider = 'deepseek',
      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-20250514',
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
        moonshot = {
          endpoint = 'https://api.moonshot.ai/v1',
          model = 'kimi-k2-0711-preview',
          timeout = 30000, -- 超时时间（毫秒）
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 32768,
          },
        },
        deepseek = {
          __inherited_from = 'openai',
          api_key_name = 'AVANTE_DEEPSEEK_API_KEY',
          endpoint = 'https://api.deepseek.com',
          model = 'deepseek-coder',
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- 以下依赖项是可选的，
      'echasnovski/mini.pick', -- 用于文件选择器提供者 mini.pick
      'nvim-telescope/telescope.nvim', -- 用于文件选择器提供者 telescope
      'ibhagwan/fzf-lua', -- 用于文件选择器提供者 fzf
      'nvim-tree/nvim-web-devicons', -- 或 echasnovski/mini.icons
      {
        -- 支持图像粘贴
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- 推荐设置
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- Windows 用户必需
            use_absolute_path = true,
          },
        },
      },
      {
        -- 如果您有 lazy=true，请确保正确设置
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
}
