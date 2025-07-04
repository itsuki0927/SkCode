local function diagnostic_config()
  local x = vim.diagnostic.severity

  -- 如果有 diagnostic 的话，不展示 virtual text，防止报错太多造成干扰
  vim.diagnostic.config({
    virtual_text = false,
    signs = { text = { [x.ERROR] = '󰅙', [x.WARN] = '', [x.INFO] = '󰋼', [x.HINT] = '󰌵' } },
    underline = true,
    float = { border = 'single' },
  })
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = 'single'
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end
end

local function organize_imports()
  -- 获取当前 buffer 的客户端列表
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  -- 寻找可用的 TypeScript 语言服务器
  for _, client in ipairs(clients) do
    if client.name == 'ts_ls' then
      -- 构造请求参数
      local params = {
        command = '_typescript.organizeImports',
        arguments = { vim.api.nvim_buf_get_name(0) },
      }

      -- 发送 LSP 请求
      client:request('workspace/executeCommand', params, function(err, result)
        if err then
          vim.notify('整理导入失败: ' .. err.message, vim.log.levels.ERROR)
          return
        end

        -- 处理响应结果（可选）
        if result then
          vim.notify('整理导入完成', vim.log.levels.INFO)
        end
      end, 0) -- 最后的 0 表示当前 buffer

      return
    end
  end

  -- 如果没有找到 tsserver
  vim.notify('未找到 TypeScript 语言服务器', vim.log.levels.WARN)
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
    },
    opts = {
      servers = {
        html = {},
        cssls = {
          settings = {
            css = {
              validate = false,
            },
            less = {
              validate = false,
            },
            scss = {
              validate = false,
            },
          },
        },
        stylelint_lsp = {
          settings = {
            stylelintplus = {
              autoFixOnFormat = false,
              autoFixOnSave = true,
            },
          },
        },
        eslint = {
          flags = {
            allow_incremental_sync = false,
            debounce_text_changes = 1000,
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                enable = true,
                globals = {
                  'vim',
                  'describe',
                  'it',
                  'before_each',
                  'after_each',
                },
              },
              workspace = {
                library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                  [vim.fn.stdpath('config') .. '/lua'] = true,
                },
                maxPreload = 10000,
              },
            },
          },
        },
        tailwindcss = {
          flags = {
            debounce_text_changes = 1000,
          },
          filetypes = {
            'less',
            'scss',
            'css',
            'stylus',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'vue',
          },
        },
        ts_ls = {
          commands = {
            OrganizeImports = {
              organize_imports,
              description = 'Organize Imports',
            },
          },
        },
        jsonls = {},
      },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. 'lsp')
      diagnostic_config()

      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end

      local map = vim.keymap.set

      map('n', 'grn', function()
        require('nvchad.lsp.renamer')()
      end)
      map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
      map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')

      -- buf_map(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "single" })<CR>')
      -- buf_map(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "single" })<CR>')
    end,
  },
}
