return {
  {
    'zbirenbaum/copilot.lua',
    dependencies = {
      'copilotlsp-nvim/copilot-lsp',
    },
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    enabled = false,
    config = function()
      vim.g.copilot_nes_debounce = 100
      require('copilot').setup({
        suggestion = { enabled = true, keymap = { accept = false } },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
        nes = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept_and_goto = '<leader>p',
            accept = false,
            dismiss = '<Esc>',
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
