local default_configs = skcode.load_config()

-- 在某些窗口上禁止statusline
vim.cmd([[ autocmd BufEnter,BufRead,BufWinEnter,FileType,WinEnter * lua skcode.hide_statusline() ]])

-- 是否文件打开时自动折叠: 默认禁止
-- 个人建议允许自动折叠, 再打开之后直接使用zo、zc的时候可能会出现no fold foun的问题导致无法折叠
-- 解决办法有两个
-- 1. auto_fold = true(最简单).
-- 2. 每次想要折叠前自己手动执行zx, 然后在执行zo、zc命令.
-- 可以查看具体的issue: https://github.com/nvim-telescope/telescope.nvim/issues/559
if default_configs.config.auto_fold then
  vim.cmd([[autocmd BufRead * autocmd BufWinEnter * ++once normal! zx zM]])
end
