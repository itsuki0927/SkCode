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
    sumneko_lua = true,
    tailwindcss = true,
    tsserver = true,
    volar = false,
    vuels = true,
    cssls = true,
    jsonls = true,
    emmet_ls = true,
    html = true,
    eslint = true,
    marksman = true,
  },
}

-- 插件配置
M.plugins = {
  options = {
    nvimtree = {
      lazy_load = true,
      quit_on_open = false, -- 打开文件时关闭nvimtree
    },
    statusline = {
      style = 'block', -- default, round , slant , block , arrow
    },
  },
}

return M
