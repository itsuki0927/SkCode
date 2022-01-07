-- local colorscheme = 'onedarker'
-- 
-- local status_ok, _ = pcall(vim.cmd, 'colorscheme' .. colorscheme)
-- print(status_ok)
-- if not status_ok then
--   vim.notify('colorscheme: ' .. colorscheme .. ' not found!')
--   return
-- end
-- 
-- vim.cmd ("colorscheme" .. colorscheme)

vim.cmd([[
try
  colorscheme onedarker
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])
