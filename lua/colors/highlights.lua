local cmd = vim.cmd

local colors = require('colors').get()
local ui = require('core.utils').load_config().ui

local black = colors.black
local black2 = colors.black2
local blue = colors.blue
local darker_black = colors.darker_black
local folder_bg = colors.folder_bg
local green = colors.green
local grey = colors.grey
local grey_fg = colors.grey_fg
local light_grey = colors.light_grey
local line = colors.line
local nord_blue = colors.nord_blue
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local pmenu_bg = colors.pmenu_bg
local purple = colors.purple
local red = colors.red
local white = colors.white
local yellow = colors.yellow
local orange = colors.orange
local one_bg3 = colors.one_bg3

-- functions for setting highlights
local fg = require('core.utils').fg
local bg = require('core.utils').bg
local fg_bg = require('core.utils').fg_bg

-- Comments
if ui.italic_comments then
  fg('Comment', grey_fg .. ' gui=italic')
else
  fg('Comment', grey_fg)
end

-- Disable cusror line
cmd('hi clear CursorLine')
-- Line number
fg('cursorlinenr', white)
-- Fold
bg('Folded', '#252a34')

-- same it bg, so it doesn't appear
fg('EndOfBuffer', black)

-- For floating windows
bg('NormalFloat', darker_black)
fg_bg('FloatBorder', white, darker_black)

-- Pmenu
bg('Pmenu', one_bg)
bg('PmenuSbar', one_bg2)
bg('PmenuSel', pmenu_bg)
bg('PmenuThumb', nord_blue)

-- misc

-- inactive statuslines as thin lines
fg('StatusLineNC', one_bg3 .. ' gui=underline')
fg('LineNr', grey)
fg('NvimInternalError', red)
fg('VertSplit', one_bg2)

-- Plugin Highlights

-- Floaterm
bg('Floaterm', darker_black)
fg_bg('FloatermBorder', white, darker_black)

-- Dashboard
fg('AlphaHeader', light_grey)
fg('AlphaButtons', light_grey)
fg('AlphaType', blue)

-- Git signs
fg_bg('DiffAdd', green, 'NONE')
fg_bg('DiffChange', grey_fg, 'NONE')
fg_bg('DiffChangeDelete', red, 'NONE')
fg_bg('DiffModified', red, 'NONE')
fg_bg('DiffDelete', red, 'NONE')
fg_bg('GitSignsCurrentLineBlame', grey_fg, 'NONE')
fg('GitSignsDeleteLn', red)
fg('GitSignsAddLn', green)

-- Indent blankline
fg('IndentBlanklineChar', line)
fg('IndentBlanklineSpaceChar', line)
fg('IndentBlanklineIndent1', '#E06C75')
fg('IndentBlanklineIndent2', '#E5C07B')
fg('IndentBlanklineIndent3', '#98C379')
fg('IndentBlanklineIndent4', '#56B6C2')
fg('IndentBlanklineIndent5', '#61AFEF')
fg('IndentBlanklineIndent6', '#C678DD')

-- Cmp
fg_bg('CmpItemAbbrDeprecated', '#808080', 'NONE' .. ' gui=strikethrough')
fg_bg('CmpItemAbbrMatch', '#569CD6', 'NONE')
fg_bg('CmpItemAbbrMatchFuzzy', '#569CD6', 'NONE')
fg_bg('CmpItemKindVariable', '#9CDCFE', 'NONE')
fg_bg('CmpItemKindInterface', '#9CDCFE', 'NONE')
fg_bg('CmpItemKindText', '#9CDCFE', 'NONE')
fg_bg('CmpItemKindFunction', '#C586c0', 'NONE')
fg_bg('CmpItemKindMethod', '#C586C0', 'NONE')
fg_bg('CmpItemKindKeyword', '#d4D4D4', 'NONE')
fg_bg('CmpItemKindProperty', '#D4D4d4', 'NONE')
fg_bg('CmpItemKindUnit', '#D4D4d4', 'NONE')

-- Lsp diagnostics
fg('DiagnosticHint', purple)
fg('DiagnosticError', red)
fg('DiagnosticWarn', yellow)
fg_bg('DiagnosticInformation', green, red)

-- NvimTree
fg('NvimTreeEmptyFolderName', folder_bg)
fg('NvimTreeEndOfBuffer', darker_black)
fg('NvimTreeFolderIcon', folder_bg)
fg('NvimTreeFolderName', folder_bg)
fg('NvimTreeGitDirty', red)
fg('NvimTreeIndentMarker', one_bg2)
bg('NvimTreeNormal', darker_black)
bg('NvimTreeNormalNC', darker_black)
fg('NvimTreeOpenedFolderName', folder_bg)
fg('NvimTreeRootFolder', red .. ' gui=underline') -- enable underline for root folder in nvim tree
fg('NvimTreeVertSplit', darker_black)
bg('NvimTreeVertSplit', darker_black)
fg_bg('NvimTreeStatuslineNc', darker_black, darker_black)
fg_bg('NvimTreeWindowPicker', red, black2)

-- Telescope
fg_bg('TelescopePromptNormal', white, darker_black)
fg_bg('TelescopePromptPrefix', red, darker_black)
fg_bg('TelescopePreviewTitle', black, green)
fg_bg('TelescopePromptTitle', black, red)
fg_bg('TelescopeResultsTitle', darker_black, yellow)
bg('TelescopeNormal', darker_black)
bg('TelescopeSelection', black2)

-- Renamer
bg('RenamerNormal', darker_black)
fg_bg('RenamerTitle', black, blue)

-- keybinds cheatsheet
fg_bg('CheatsheetBorder', black, black)
bg('CheatsheetSectionContent', red)
fg('CheatsheetHeading', white)

local section_title_colors = {
  white,
  blue,
  red,
  green,
  yellow,
  purple,
  orange,
}
for i, color in ipairs(section_title_colors) do
  vim.cmd('highlight CheatsheetTitle' .. i .. ' guibg = ' .. color .. ' guifg=' .. black)
end

-- Disable some highlight in nvim tree if transparency enabled
if ui.float_style == 'transparency' then
  bg('Normal', 'NONE')
  bg('Folded', 'NONE')
  fg('Folded', 'NONE')
  fg('Comment', grey)
  bg('NormalFloat', 'NONE')
  bg('NvimTreeNormal', 'NONE')
  bg('NvimTreeNormalNC', 'NONE')
  bg('NvimTreeStatusLineNC', 'NONE')
  bg('NvimTreeVertSplit', 'NONE')
  fg('NvimTreeVertSplit', grey)

  -- renamer
  bg('RenamerNormal', 'NONE')
  fg_bg('RenamerBorder', one_bg, 'NONE')

  -- float border
  fg_bg('FloatBorder', one_bg, 'NONE')

  -- telescope
  bg('TelescopeBorder', 'NONE')
  bg('TelescopePrompt', 'NONE')
  bg('TelescopeResults', 'NONE')
  bg('TelescopePromptBorder', 'NONE')
  bg('TelescopePromptNormal', 'NONE')
  bg('TelescopeNormal', 'NONE')
  bg('TelescopePromptPrefix', 'NONE')
  fg('TelescopeBorder', one_bg)
  fg_bg('TelescopeResultsTitle', black, blue)

  bg('Floaterm', 'NONE')
  fg_bg('FloatermBorder', one_bg, 'NONE')
elseif ui.float_style == 'darker' then
  -- float border
  fg_bg('FloatBorder', darker_black, darker_black)

  -- renamer
  fg_bg('RenamerBorder', darker_black, darker_black)

  -- telescope
  fg_bg('TelescopeBorder', darker_black, darker_black)
  fg_bg('TelescopePromptBorder', black2, black2)
  fg_bg('TelescopePromptNormal', white, black2)
  fg_bg('TelescopePromptPrefix', red, black2)

  -- Floaterm
  bg('Floaterm', darker_black)
  fg_bg('FloatermBorder', darker_black, darker_black)
end
