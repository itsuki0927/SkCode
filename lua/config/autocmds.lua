local autocmd = vim.api.nvim_create_autocmd

-- 高亮复制的内容
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local cursorGrp = vim.api.nvim_create_augroup('CursorLine', { clear = true })
autocmd({ 'InsertLeave', 'WinEnter' }, {
  pattern = '*',
  command = 'set cursorline', -- 激活窗口显示光标行
  group = cursorGrp,
})
autocmd({ 'InsertEnter', 'WinLeave' }, {
  pattern = '*',
  command = 'set nocursorline', -- 非激活窗口隐藏光标行
  group = cursorGrp,
})

-- 恢复上次编辑位置
autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_augroup('JSLogMacro', { clear = true })
autocmd('FileType', {
  group = 'JSLogMacro',
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  callback = function()
    local esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)
    local str = "yiwoconsole.log('" .. esc .. "pa:', " .. esc .. 'pa);' .. esc
    vim.fn.setreg('n', str)
  end,
})

-- user event that loads after UIEnter + only if file buf is there
autocmd({ 'UIEnter', 'BufReadPost', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('NvFilePost', { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = args.buf })

    if not vim.g.ui_entered and args.event == 'UIEnter' then
      vim.g.ui_entered = true
    end

    if file ~= '' and buftype ~= 'nofile' and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds('User', { pattern = 'FilePost', modeline = false })
      vim.api.nvim_del_augroup_by_name('NvFilePost')

      vim.schedule(function()
        vim.api.nvim_exec_autocmds('FileType', {})

        if vim.g.editorconfig then
          require('editorconfig').config(args.buf)
        end
      end)
    end
  end,
})

local function highlight_symbol(event)
  vim.opt.updatetime = 400

  local client_id = vim.tbl_get(event, 'data', 'client_id')
  local client = client_id and vim.lsp.get_client_by_id(client_id)

  if client == nil or not client:supports_method('textDocument/documentHighlight') then
    return
  end

  local group = vim.api.nvim_create_augroup('highlight_symbol', { clear = false })

  vim.api.nvim_clear_autocmds({ buffer = event.buf, group = group })

  autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = group,
    buffer = event.buf,
    callback = vim.lsp.buf.document_highlight,
  })

  autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    group = group,
    buffer = event.buf,
    callback = vim.lsp.buf.clear_references,
  })
end

autocmd('LspAttach', {
  desc = 'Setup highlight symbol',
  callback = highlight_symbol,
})

-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'BlinkCmpMenuOpen',
--   callback = function()
--     vim.b.copilot_suggestion_hidden = true
--   end,
-- })

-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'BlinkCmpMenuClose',
--   callback = function()
--     vim.b.copilot_suggestion_hidden = false
--   end,
-- })
