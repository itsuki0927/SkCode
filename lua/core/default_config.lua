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
    vuels = true, -- vue2
    cssls = true, -- css
    cssmodules_ls = true, -- css module
    jsonls = true, -- json
    html = true, -- html
    eslint = true, -- eslint
    sumneko_lua = false, -- lua
    tailwindcss = false, -- tailwindcss
    rust_analyzer = false, -- rust
    volar = false, -- vue3
    emmet_ls = false, -- emmet
    marksman = false, -- markdown
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
