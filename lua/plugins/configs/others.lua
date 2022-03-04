local M = {}

M.autopairs = function()
  local present1, autopairs = pcall(require, 'nvim-autopairs')
  local present2, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')

  if present1 and present2 then
    autopairs.setup({
      check_ts = true,
      disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
      map_cr = true,
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
        offset = 0, -- Offset from pattern match
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'PmenuSel',
        highlight_grey = 'LineNr',
      },
    })

    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
    cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = 'racket'
  end
end

M.luasnip = function()
  local present, luasnip = pcall(require, 'luasnip')
  if present then
    luasnip.config.set_config({
      history = true,
      updateevents = 'TextChanged,TextChangedI',
    })

    require('luasnip/loaders/from_vscode').load({ paths = {} })
    require('luasnip/loaders/from_vscode').load()
  end
end

M.null_ls = function()
  local present, null_ls = pcall(require, 'null-ls')

  if present then
    local formatting = null_ls.builtins.formatting

    null_ls.setup({
      debug = false,
      sources = {
        formatting.prettier.with({ extra_args = { '--single-quote', '--jsx-single-quote' } }),
        formatting.stylua,
      },
      on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
          vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
        end
      end,
    })
  end
end

M.comment = function()
  local present, nvim_comment = pcall(require, 'Comment')
  if present then
    nvim_comment.setup()
  end
end

M.blankline = function()
  require('indent_blankline').setup({
    use_treesitter = true,
    show_current_context = true,
    context_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
      'IndentBlanklineIndent3',
      'IndentBlanklineIndent4',
      'IndentBlanklineIndent5',
      'IndentBlanklineIndent6',
    },
    filetype_exculde = {
      'alpha',
      'packer',
      'NvimTree',
      'lsp-install',
      'help',
      'TelescopePrompt',
      'TelescopeResults',
    },
    buftype_exclude = { 'terminal', 'nofile' },
    context_patterns = {
      'class',
      'return',
      'function',
      'method',
      '^if',
      '^while',
      'jsx_element',
      '^for',
      '^object',
      '^table',
      'block',
      'arguments',
      'if_statement',
      'else_clause',
      'jsx_element',
      'jsx_self_closing_element',
      'try_statement',
      'catch_clause',
      'import_statement',
      'operation_type',
    },
  })
end

M.colorizer = function()
  local present, colorizer = pcall(require, 'colorizer')
  if present then
    colorizer.setup({ '*' }, {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = true, -- "Name" codes like Blue
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn

      -- Available modes: foreground, background
      mode = 'background', -- Set the display mode.
    })

    vim.cmd('ColorizerReloadAllBuffers')
  end
end

M.renamer = function()
  local present1, renamer = pcall(require, 'renamer')
  local present2, mappings_utils = pcall(require, 'renamer.mappings.utils')

  if present1 and present2 then
    renamer.setup({
      title = 'Rename',
      padding = {
        top = 0,
        left = 0,
        bottom = 0,
        right = 0,
      },
      min_width = 25,
      max_width = 55,
      border = true,
      border_chars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      -- Whether or not to highlight the current word references through LSP
      show_refs = true,
      -- Whether or not to add resulting changes to the quickfix list
      with_qf_list = true,
      -- Whether or not to enter the new name through the UI or Neovim's `input`
      -- prompt
      with_popup = true,
      -- The keymaps available while in the `renamer` buffer. The example below
      -- overrides the default values, but you can add others as well.
      mappings = {
        ['<c-i>'] = mappings_utils.set_cursor_to_start,
        ['<c-a>'] = mappings_utils.set_cursor_to_end,
        ['<c-e>'] = mappings_utils.set_cursor_to_word_end,
        ['<c-b>'] = mappings_utils.set_cursor_to_word_start,
        ['<c-c>'] = mappings_utils.clear_line,
        ['<c-u>'] = mappings_utils.undo,
        ['<c-r>'] = mappings_utils.redo,
      },
      -- Custom handler to be run after successfully renaming the word. Receives
      -- the LSP 'textDocument/rename' raw response as its parameter.
      handler = nil,
    })
  end
end

M.todo_comments = function()
  local present, todo_comments = pcall(require, 'todo-comments')

  if present then
    todo_comments.setup({
      signs = true,
      sign_priority = 9,
      keywords = {
        FIX = {
          icon = ' ',
          color = 'error',
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
        },
        TODO = { icon = ' ', color = '#ffbb00' },
        HACK = { icon = ' ', color = 'warning' },
        WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX', 'WARN' } },
        PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
      },
      merge_keywords = true,
      highlight = {
        before = '',
        keyword = 'wide',
        after = 'fg',
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
        max_line_len = 400,
        exclude = {},
      },
      colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
        warning = { 'DiagnosticWarning', 'WarningMsg', '#FBBF24' },
        info = { 'DiagnosticInfo', '#ffbb00' },
        hint = { 'DiagnosticHint', '#10B981' },
        default = { 'Identifier', '#7C3AED' },
      },
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      },
    })
  end
end

return M
