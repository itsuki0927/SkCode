local M = {}
local ufo = require('ufo')

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Provider for a buffer with git or diff filetype (e.g., press dd in vim-flog).
-- It returns UfoFoldingRange (it is a table of { startLine = lineNum_1, endLine
-- = lineNum_2 } that describes the range of a fold) that contains the ranges of
-- all the folds we define.
-- It creates folds for (1) input source (starts with +++ symbol), (2)
-- diff chunks (starts with @@ symbol).
function M.gitProvider(bufnr)
  local res = {}
  local fileStart, hunkStart
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
  for i, line in ipairs(lines) do
    if line:match('^diff %-%-') then
      if hunkStart then
        table.insert(res, { startLine = hunkStart - 1, endLine = i - 2 })
      end
      if fileStart then
        table.insert(res, { startLine = fileStart - 1, endLine = i - 2 })
      end
      fileStart, hunkStart = nil, nil
    elseif line:match('^@@ %-%d+,%d+ %+%d+,%d+') then
      if hunkStart then
        table.insert(res, { startLine = hunkStart - 1, endLine = i - 2 })
      end
      hunkStart = i
    elseif line:match('^%+%+%+ %S') then
      fileStart = i
    end
  end
  if hunkStart then
    table.insert(res, { startLine = hunkStart - 1, endLine = #lines - 2 })
  end
  if fileStart then
    table.insert(res, { startLine = fileStart - 1, endLine = #lines - 2 })
  end
  return res
end

-- Customize fold text
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ('  %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'UfoFoldedEllipsis' })
  return newVirtText
end

local ftMap = {
  git = M.gitProvider,
  diff = M.gitProvider,
  fugitive = '',
}

ufo.setup({
  close_fold_kinds = { 'imports', 'comment' },
  provider_selector = function(_, filetype, _)
    local selector = ftMap[filetype]
    return selector or { 'treesitter', 'indent' }
  end,
  fold_virt_text_handler = handler,
  preview = {
    win_config = {
      border = { '', '─', '', '', '', '─', '', '' },
      winblend = 0,
    },
    mappings = {
      scrollU = '<C-u>',
      scrollD = '<C-d>',
      jumpTop = '[',
      jumpBot = ']',
    },
  },
})

return M

-- NOTES:
-- 1. How to define a kind (lsp supports only two kinds: import and comment) for automatically
--    folding?
-- https://github.com/kevinhwang91/nvim-ufo/issues/64#issuecomment-1242919369
