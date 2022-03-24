local present1, autopairs = pcall(require, 'nvim-autopairs')
local present2, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')

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

  local cmp = require('cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
  cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = 'racket'
end
