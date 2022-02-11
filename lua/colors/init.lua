local M = {}

M.init = function(theme)
  if theme == nil then
    theme = require('core.utils').load_config().ui.theme
  end

  vim.g.skcode_theme = theme

  local present, base16 = pcall(require, 'base16')

  if present then
    -- 首次加载
    base16(base16.themes(theme), true)
    --
    package.loaded['colors.highlights' or false] = nil
    -- 加载高亮
    require('colors.highlights')
  end
end

M.get = function(theme)
  if theme == nil then
    theme = vim.g.skcode_theme
  end
  return require('hl_themes.' .. theme)
end

return M
