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

local function getCreativeMonorepoDir(bufnr)
  local current_file = vim.api.nvim_buf_get_name(bufnr)

  -- 检查是否包含 creative-tool-emo（对连字符进行转义）
  if current_file:find('creative%-tool%-emo') then
    -- 使用 gsub 获取项目根目录（对连字符进行转义）
    local repo_root = current_file:gsub('(creative%-tool%-emo).*', '%1')
    return repo_root .. '/infra'
  end

  -- 检查是否包含 creative_one_monorepo
  if current_file:find('creative_one_monorepo') then
    local repo_root = current_file:gsub('(creative_one_monorepo).*', '%1')
    return repo_root .. '/infra'
  end

  return nil
end

local eslint_config_files = {
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc.json',
  'eslint.config.js',
  'eslint.config.mjs',
  'eslint.config.cjs',
  'eslint.config.ts',
  'eslint.config.mts',
  'eslint.config.cts',
}

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      {
        'Wansmer/symbol-usage.nvim',
        event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
        config = function()
          require('symbol-usage').setup()
        end,
      },
      {
        'j-hui/fidget.nvim',
        opts = {
          -- options
        },
      },
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
          root_dir = function(bufnr, on_dir)
            local util = require('lspconfig.util')
            local project_root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb' }
            local project_root = vim.fs.root(bufnr, project_root_markers)

            if not project_root then
              project_root = getCreativeMonorepoDir(bufnr)
            end

            if not project_root then
              return nil
            end

            local filename = vim.api.nvim_buf_get_name(bufnr)
            local eslint_config_files_with_package_json =
              util.insert_package_json(eslint_config_files, 'eslintConfig', filename)
            local is_buffer_using_eslint = vim.fs.find(eslint_config_files_with_package_json, {
              path = filename,
              type = 'file',
              limit = 1,
              upward = true,
              stop = vim.fs.dirname(project_root),
            })[1]

            if not is_buffer_using_eslint then
              return nil
            end

            on_dir(project_root)
          end,
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
          -- flags = {
          --   debounce_text_changes = 1000,
          -- },
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
        -- ts_go = {},
        ts_ls = {
          root_dir = function(bufnr, on_dir)
            local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
            root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers } or root_markers
            local project_root = vim.fs.root(bufnr, root_markers)

            if not project_root then
              project_root = getCreativeMonorepoDir(bufnr)
            end

            if not project_root then
              return nil
            end

            on_dir(project_root)
          end,
          commands = {
            ['_typescript.organizeImports'] = organize_imports,
          },
        },
        jsonls = {},
        -- codebook = {},
        -- oxlint = {},
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
