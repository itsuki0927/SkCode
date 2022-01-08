local indent_blankline = require('indent_blankline')

local function get_char_highlights()
    vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 blend=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B blend=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 blend=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 blend=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF blend=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD blend=nocombine]]
    return {
      "IndentBlanklineIndent1", "IndentBlanklineIndent2", "IndentBlanklineIndent3", "IndentBlanklineIndent4", "IndentBlanklineIndent5",
      "IndentBlanklineIndent6"
    }
end

indent_blankline.setup ({
  use_treesitter = true,
  context_highlight_list = get_char_highlights(),
  show_current_context = true,
  filetype_exculde = { "alhpa",'packer', 'NvimTree', 'lsp-install' , 'help', 'dashboard'},
  buftype_exclude = { 'terminal', 'nofile' },
  context_patterns = {
    "class", "return", "function", "method", "^if", "^while", "jsx_element", "^for", "^object", "^table", "block", "arguments", "if_statement",
    "else_clause", "jsx_element", "jsx_self_closing_element", "try_statement", "catch_clause", "import_statement", "operation_type"
  }
})

