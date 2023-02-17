local M = {}

M.input = function(opts, on_confirm, win_config)
  local prompt = opts.prompt or 'Input: '
  local default = opts.default or ''

  -- Calculate a minimal width with a bit buffer
  local default_width = vim.str_utfindex(default) + 10
  local prompt_width = vim.str_utfindex(prompt) + 10
  local win_width = default_width > prompt_width and default_width or prompt_width

  local default_win_config = {
    row = vim.o.lines / 2 - 1,
    col = vim.o.columns / 2 - win_width / 2,
    width = win_width,
    height = 1,
    focusable = true,
    relative = 'win',
    style = 'minimal',
    border = 'rounded',
    title = prompt,
  }
  win_config = vim.tbl_deep_extend('force', default_win_config, win_config)

  local buffer = vim.api.nvim_create_buf(false, true)
  local window = vim.api.nvim_open_win(buffer, true, win_config)
  vim.api.nvim_buf_set_text(buffer, 0, 0, 0, 0, { opts.default })

  -- Put cursor at the end of the default value
  vim.cmd('startinsert')
  vim.api.nvim_win_set_cursor(window, { 1, vim.str_utfindex(default) + 1 })

  -- Enter to confirm
  vim.keymap.set({ 'n', 'i', 'v' }, '<cr>', function()
    local lines = vim.api.nvim_buf_get_lines(buffer, 0, 1, false)
    if on_confirm then
      on_confirm(lines[1])
    end
    vim.api.nvim_win_close(window, true)
    vim.cmd('stopinsert')
  end, { buffer = buffer })

  -- Esc to close
  vim.api.nvim_create_autocmd({ 'BufLeave', 'InsertLeave' }, {
    buffer = buffer,
    callback = function()
      vim.api.nvim_win_close(window, true)
      vim.cmd('stopinsert')
    end,
  })
end

M.setup = function()
  vim.ui.input = function(opts, on_confirm)
    M.input(opts, on_confirm, {})
  end
end

return M
