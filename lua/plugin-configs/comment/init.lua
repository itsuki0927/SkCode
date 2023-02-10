local present, nvim_comment = pcall(require, 'Comment')

if present then
  nvim_comment.setup({
    pre_hook = function(ctx)
      -- TODO: 使用ts_context_commentstring，会是Comment.nvim插件失效，懒加载顺序问题？
      --      local U = require('Comment.utils')
      --      local location = nil
      --      local commentstring_utils = require('ts_context_commentstring.utils')
      --      if ctx.ctype == U.ctype.block then
      --        location = commentstring_utils.get_cursor_location()
      --      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      --        location = commentstring_utils.get_visual_start_location()
      --      end
      --
      --      return require('ts_context_commentstring.internal').calculate_commentstring({
      --        key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
      --        location = location,
      --      })
    end,
  })
end
