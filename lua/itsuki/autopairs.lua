local status_ok, npairs = pcall(require, 'nvim-autopairs')

if not status_ok then
  return
end

npairs.setup({
  check_ts = true,
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
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
    highlight_grey='LineNr'
  },
})

-- cmp 集成, 回车自动补全括号
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")

if not cmp_status_ok then
  return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
