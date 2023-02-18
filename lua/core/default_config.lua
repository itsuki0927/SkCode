local M = {}

-- SkCode 配置
M.config = {}

-- UI配置
M.ui = {
  theme = 'onedark', -- default theme
  italic_comments = false,
}

-- Lsp 配置
M.lsp = {
  servers = {
    tsserver = true, -- typescript
    cssls = true, -- css
    cssmodules_ls = true, -- css module
    jsonls = true, -- json
    html = true, -- html
    eslint = true, -- eslint
    sumneko_lua = true, -- lua
    tailwindcss = true, -- tailwindcss
    emmet_ls = false, -- emmet
    marksman = false, -- markdown
    volar = false, -- vue3
    rust_analyzer = false, -- rust
    vuels = false, -- vue2
  },
}

-- 插件配置
M.plugins = {
  options = {
    treesitter = {
      ensure_installed = {
        'bash',
        'c',
        'c_sharp',
        'comment',
        'cpp',
        'css',
        'diff',
        'dockerfile',
        'dot',
        'fish',
        'git_rebase',
        'gitcommit',
        'gitignore',
        'go',
        'graphql',
        'html',
        'markdown',
        'pug',
        'prisma',
        'lua',
        'vim',
        'help',
        'java',
        'javascript',
        'typescript',
        'scss',
        'tsx',
        'vue',
        'jsdoc',
        'json',
        'json5',
        'regex',
        'ruby',
        'rust',
        'sql',
        'yaml',
      },
    },
    statusline = {
      style = 'block', -- default, round , slant , block , arrow
    },
  },
}

return M
