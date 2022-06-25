local default_configs = skcode.load_config()
local autocmd = vim.api.nvim_create_autocmd

-- 是否文件打开时自动折叠: 默认禁止
-- 个人建议允许自动折叠, 再打开之后直接使用zo、zc的时候可能会出现no fold foun的问题导致无法折叠
-- 解决办法有两个
-- 1. auto_fold = true(最简单).
-- 2. 每次想要折叠前自己手动执行zx, 然后在执行zo、zc命令.
-- 可以查看具体的issue: https://github.com/nvim-telescope/telescope.nvim/issues/559
if default_configs.config.auto_fold then
  vim.cmd([[autocmd BufRead * autocmd BufWinEnter * ++once normal! zx zM]])
end

autocmd('FileType', {
  pattern = 'alpha',
  callback = function()
    vim.opt.laststatus = 0
  end,
})

-- 高亮复制的内容
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch' })
  end,
  group = highlight_group,
  pattern = '*',
})

autocmd('BufUnload', {
  buffer = 0,
  callback = function()
    vim.opt.laststatus = 3
  end,
})

autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o',
})

autocmd('InsertLeave', {
  callback = function()
    if
      require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require('luasnip').session.jump_active
    then
      require('luasnip').unlink_current()
    end
  end,
})
