local cmd = vim.cmd

-- 加载默认配置
skcode.load_config = function()
  local conf = require('core.default_config')

  return conf
end

-- 键位定义函数
-- @param mode 模式
-- @param keys 键位
-- @param command 命令
-- @param opt 其他参数
skcode.map = function(mode, keys, command, opt)
  local options = { noremap = true, silent = true }
  if opt then
    options = vim.tbl_extend('force', options, opt)
  end

  -- all valid modes allowed for mappings
  -- :h map-modes
  local valid_modes = {
    [''] = true,
    ['n'] = true,
    ['v'] = true,
    ['s'] = true,
    ['x'] = true,
    ['o'] = true,
    ['!'] = true,
    ['i'] = true,
    ['l'] = true,
    ['c'] = true,
    ['t'] = true,
  }

  -- helper function for M.map
  -- can gives multiple modes and keys
  local function map_wrapper(sub_mode, lhs, rhs, sub_options)
    if type(lhs) == 'table' then
      for _, key in ipairs(lhs) do
        map_wrapper(sub_mode, key, rhs, sub_options)
      end
    else
      if type(sub_mode) == 'table' then
        for _, m in ipairs(sub_mode) do
          map_wrapper(m, lhs, rhs, sub_options)
        end
      else
        if valid_modes[sub_mode] and lhs and rhs then
          vim.api.nvim_set_keymap(sub_mode, lhs, rhs, sub_options)
        else
          sub_mode, lhs, rhs = sub_mode or '', lhs or '', rhs or ''
          print("Cannot set mapping [ mode = '" .. sub_mode .. "' | key = '" .. lhs .. "' | cmd = '" .. rhs .. "' ]")
        end
      end
    end
  end

  map_wrapper(mode, keys, command, options)
end

-- 懒加载包
skcode.packer_lazy_load = function(plugin, timer)
  if plugin then
    timer = timer or 0
    vim.defer_fn(function()
      require('packer').loader(plugin)
    end, timer)
  end
end

-- 隐藏statusline
skcode.hide_statusline = function()
  local hidden = skcode.load_config().plugins.options.statusline.hidden
  local shown = skcode.load_config().plugins.options.statusline.shown
  local api = vim.api
  local buftype = api.nvim_buf_get_option(0, 'ft')

  -- tbl_contains: 检查列表(t)是否包含`v`
  if vim.tbl_contains(shown, buftype) then
    -- 设置全局值laststatus
    api.nvim_set_option('laststatus', 2)
    return
  end

  if vim.tbl_contains(hidden, buftype) then
    api.nvim_set_option('laststatus', 0)
    return
  end

  api.nvim_set_option('laststatus', 2)
end

skcode.merge = function(...)
  return vim.tbl_deep_extend('force', ...)
end

skcode.close_buffer = function()
  local fn = vim.fn

  -- 获取当前所有的buffer列表
  local buflisted = fn.getbufinfo({ buflisted = 1 })
  local cur_winnr, cur_bufnr = fn.winnr(), fn.bufnr()
  if #buflisted < 2 then
    cmd('confirm qall')
    return
  end
  for _, winid in ipairs(fn.getbufinfo(cur_bufnr)[1].windows) do
    cmd(string.format('%d wincmd w', fn.win_id2win(winid)))
    cmd(cur_bufnr == buflisted[#buflisted].bufnr and 'bp' or 'bn')
  end
  cmd(string.format('%d wincmd w', cur_winnr))
  local is_terminal = fn.getbufvar(cur_bufnr, '&buftype') == 'terminal'
  cmd(is_terminal and 'bd! #' or 'silent! confirm bd #')
end
