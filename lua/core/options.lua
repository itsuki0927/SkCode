local g = vim.g
local opt = vim.opt

-- :help options
g.mapleader = ' '
g.skcode_theme = skcode.load_config().ui.theme

-- 更多配置可以查看文档: https://yianwillis.github.io/vimcdoc/doc/quickref.html#option-list
opt.backup = false -- 覆盖文件时保留备份文件
opt.clipboard = 'unnamedplus' -- 允许nvim访问系统剪切板
opt.cmdheight = 1 -- 命令行高度
opt.completeopt = { 'menuone', 'noselect' } -- 插入模式补全使用的选项
opt.conceallevel = 0 -- ``在markdown文件中可见
opt.fileencoding = 'utf-8' --  多字节文本的文件编码
opt.hlsearch = true -- 高亮搜索结果
opt.ignorecase = true -- 搜索时忽略大小写
opt.mouse = 'a' -- 允许使用鼠标点击
opt.pumheight = 20 -- 决定用于插入模式补全的弹出菜单显示项目的最大数目
opt.showmode = false -- 不显示当前模式
opt.showtabline = 2 -- 显示带有标签页标签的行
opt.smartcase = true -- 大写的自动转行
opt.smartindent = true -- 打开智能缩进
opt.splitbelow = true -- 如果打开，窗口的分割会把新窗口放到当前窗口下边
opt.splitright = true -- 如果打开, 窗口的分割会把新窗口放到当前窗口右边
opt.swapfile = false -- 缓冲区是否使用交换文件
opt.termguicolors = true -- 终端使用 GUI 颜色
opt.timeoutlen = 1000 -- 等待映射序列完成的时间(以毫秒为单位)
opt.undofile = true -- 把撤销信息写入一个文件里
opt.updatetime = 300 --  刷新交换文件所需的毫秒数(默认4000ms)
opt.writebackup = false -- 如果一个文件正在被另一个程序编辑(或在另一个程序编辑时写入文件), 则不允许编辑
opt.expandtab = true -- 将tab转换为空格
opt.shiftwidth = 2 -- 1 tab = 2 空格
opt.tabstop = 2 -- 1 tab = 2 空格
opt.cursorline = true -- 高亮当前行
opt.number = true -- 显示行号
opt.relativenumber = true -- 使用相对行号
opt.numberwidth = 2 -- 行号宽度: 2
opt.signcolumn = 'yes' -- 始终显示符号列，否则每次都会移动文本
opt.wrap = false -- 长行回绕并在下一行继续
opt.scrolloff = 8 -- 光标上下的最少行数
opt.sidescrolloff = 8

opt.laststatus = 3 -- global statusline
opt.statusline = "%!v:lua.require('ui.statusline').run()"

-- 不可见的字符显示点
opt.list = true
opt.listchars = 'space:⋅'

opt.shortmess:append('c')

vim.cmd('set whichwrap+=<,>,[,],h,l')
vim.cmd([[set iskeyword+=-]])

-- disable some builtin vim plugins
local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
  'python3_provider',
  'python_provider',
  'node_provider',
  'ruby_provider',
  'perl_provider',
  'tutor',
  'rplugin',
  'syntax',
  'synmenu',
  'optwin',
  'compiler',
  'bugreport',
  'ftplugin',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

vim.schedule(function()
  vim.opt.shadafile = vim.fn.expand('$HOME') .. '/.local/share/nvim/shada/main.shada'
  vim.cmd([[ silent! rsh ]])
end)
