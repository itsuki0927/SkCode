local autocmd = vim.api.nvim_create_autocmd

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
