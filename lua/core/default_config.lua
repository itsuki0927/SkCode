local M = {}

-- SkCode 配置
M.config = {
  auto_fold = false,
}

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
    nvimtree = {
      lazy_load = true,
    },
    statusline = {
      style = 'block', -- default, round , slant , block , arrow
    },
  },
}

return M
