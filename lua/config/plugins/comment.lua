return {
  'numToStr/Comment.nvim',
  keys = {
    { 'gcc', mode = 'n' },
    { 'gc', mode = 'v' },
    { 'gbc', mode = 'n' },
    { 'gb', mode = 'v' },
  },
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    local nvim_comment = require('Comment')

    nvim_comment.setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
  end,
}
