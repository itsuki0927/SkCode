local M = {}

-- SkCode 配置
M.config = {
  auto_fold = false,
}

-- UI配置
M.ui = {
  theme = 'onedark', -- default theme
  italic_comments = false,
  float_style = 'border', -- 'transparency' | 'border' | 'darker'
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
      -- hide, show on specific filetypes
      hidden = {
        'help',
        'dashboard',
        'NvimTree',
        'terminal',
      },
      shown = {},
      -- truncate statusline on small screens
      shortline = true,
      style = 'block', -- default, round , slant , block , arrow
    },
  },
}

-- vim配置
-- 更多配置可以查看文档: https://yianwillis.github.io/vimcdoc/doc/quickref.html#option-list
M.options = {
  mapleader = ' ', -- 空格是<leader>键
  cmdheight = 1, -- 命令行高度
  mouse = 'a', -- 允许使用鼠标点击
  backup = false, -- 覆盖文件时保留备份文件
  clipboard = 'unnamedplus', -- 允许nvim访问系统剪切板
  completeopt = { 'menuone', 'noselect' }, -- 插入模式补全使用的选项
  conceallevel = 0, -- ``在markdown文件中可见
  fileencoding = 'utf-8', --  多字节文本的文件编码
  hlsearch = true, -- 高亮搜索结果
  ignorecase = true, -- 搜索时忽略大小写
  pumheight = 20, -- 决定用于插入模式补全的弹出菜单显示项目的最大数目
  showmode = false, -- 不显示当前模式
  showtabline = 2, -- 显示带有标签页标签的行
  smartcase = true, -- 大写的自动转行
  smartindent = true, -- 打开智能缩进
  splitbelow = true, -- 如果打开，窗口的分割会把新窗口放到当前窗口下边
  splitright = true, -- 如果打开, 窗口的分割会把新窗口放到当前窗口右边
  swapfile = false, -- 缓冲区是否使用交换文件
  termguicolors = true, -- 终端使用 GUI 颜色
  timeoutlen = 1000, -- 等待映射序列完成的时间(以毫秒为单位)
  undofile = true, -- 把撤销信息写入一个文件里
  updatetime = 300, --  刷新交换文件所需的毫秒数(默认4000ms)
  writebackup = false, -- 如果一个文件正在被另一个程序编辑(或在另一个程序编辑时写入文件), 则不允许编辑
  expandtab = true, -- 将tab转换为空格
  shiftwidth = 2, -- 1 tab = 2 空格
  tabstop = 2, -- 1 tab = 2 空格
  cursorline = true, -- 高亮当前行
  number = true, -- 显示行号
  relativenumber = false, -- 不使用相对行号
  numberwidth = 3, -- 行号宽度: 3
  signcolumn = 'yes', -- 始终显示符号列，否则每次都会移动文本
  wrap = false, -- 长行回绕并在下一行继续
  scrolloff = 8, -- 光标上下的最少行数
  sidescrolloff = 8,
  shadafile = vim.opt.shadafile,
}

return M
