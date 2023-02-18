local present, nvim_comment = pcall(require, 'Comment')

if present then
  nvim_comment.setup({
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  })
end
