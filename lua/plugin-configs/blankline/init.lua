local present, indent_blankline = pcall(require, 'indent_blankline')

if present then
  require('base46').load_highlight('blankline')
  indent_blankline.setup({
    use_treesitter = true,
    show_current_context = true,
    context_highlight_list = {
      'IndentBlanklineContextIndent1',
      'IndentBlanklineContextIndent2',
      'IndentBlanklineContextIndent3',
      'IndentBlanklineContextIndent4',
      'IndentBlanklineContextIndent5',
      'IndentBlanklineContextIndent6',
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
