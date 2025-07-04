local M = {}

local kind_icons = {
  Text = ' ',
  Method = ' ',
  Function = ' ',
  Constructor = ' ',
  Field = ' ',
  Variable = ' ',
  Class = ' ',
  Interface = ' ',
  Module = ' ',
  Property = ' ',
  Unit = ' ',
  Value = ' ',
  Enum = ' ',
  Keyword = ' ',
  Snippet = ' ',
  Color = ' ',
  File = ' ',
  Reference = ' ',
  Folder = ' ',
  EnumMember = ' ',
  Constant = ' ',
  Struct = ' ',
  Event = ' ',
  Operator = ' ',
  TypeParameter = ' ',
}

M.components = {
  kind_icon = {
    text = function(ctx)
      return (kind_icons[ctx.kind] or '󰈚')
    end,
    highlight = function(ctx)
      return ctx.kind
    end,
  },

  kind = {
    text = function(ctx)
      return string.lower(ctx.kind) .. ' '
    end,
    highlight = function(ctx)
      return ctx.kind
    end,
  },

  source_name = {
    text = function(ctx)
      return '[' .. ctx.source_name .. ']'
    end,
  },
}

M.menu = {
  scrollbar = false,
  border = 'single',
  draw = {
    columns = {
      { 'label', 'label_description', gap = 1 },
      { 'kind_icon', 'kind', 'source_name' },
    },
    components = M.components,
  },
}

return M
