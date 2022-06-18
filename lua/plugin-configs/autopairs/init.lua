local present1, autopairs = pcall(require, 'nvim-autopairs')
local present2, cmp = pcall(require, 'cmp')

if present1 and present2 then
  autopairs.setup({
    check_ts = true,
    disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
    map_cr = true,
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
      offset = 0, -- Offset from pattern match
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      highlight = 'PmenuSel',
      highlight_grey = 'LineNr',
    },
  })

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end
