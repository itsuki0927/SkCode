return {
  {
    'zbirenbaum/copilot.lua',
    enabled = false,
    dependencies = {
      {
        'copilotlsp-nvim/copilot-lsp',
        init = function()
          vim.g.copilot_nes_debounce = 500
          vim.lsp.enable('copilot_ls')
          print('copilot-lsp enabled')

          vim.keymap.set('n', '<tab>', function()
            local bufnr = vim.api.nvim_get_current_buf()
            local state = vim.b[bufnr].nes_state
            if state then
              -- Try to jump to the start of the suggestion edit.
              -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
              local _ = require('copilot-lsp.nes').walk_cursor_start_edit()
                or (
                  require('copilot-lsp.nes').apply_pending_nes() and require('copilot-lsp.nes').walk_cursor_end_edit()
                )
              return nil
            else
              -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
              return '<C-i>'
            end
          end, { desc = 'Accept Copilot NES suggestion', expr = true })

          -- Clear copilot suggestion with Esc if visible, otherwise preserve default Esc behavior
          vim.keymap.set('n', '<esc>', function()
            if not require('copilot-lsp.nes').clear() then
              -- fallback to other functionality
            end
          end, { desc = 'Clear Copilot suggestion or fallback' })
        end,
      },
    },
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    -- enabled = false,
    config = function()
      -- 设置证书环境变量（临时禁用证书验证）
      -- vim.env.NODE_TLS_REJECT_UNAUTHORIZED = '0'

      require('copilot').setup({
        suggestion = { enabled = true, keymap = { accept = false } },
        panel = { enabled = false },
        -- filetypes = {
        --   markdown = true,
        --   help = true,
        -- },
        nes = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept_and_goto = '<leader>p',
            accept = false,
            dismiss = '<Esc>',
          },
        },
        server = {
          type = 'nodejs',
          -- 尝试解决证书问题
          opts_overrides = {
            settings = {
              -- 增加超时时间
              http = {
                timeout = 30000,
              },
            },
          },
        },
        logger = {
          log_to_file = true,
          file = vim.fn.stdpath('log') .. '/copilot-lua.log',
          file_log_level = vim.log.levels.TRACE,
          print_log = true,
          print_log_level = vim.log.levels.WARN,
          trace_lsp = 'verbose',
          trace_lsp_progress = true,
        },
      })
    end,
  },
}
