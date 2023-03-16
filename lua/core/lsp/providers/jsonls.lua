local present, schemastore = pcall(require, 'schemastore')

if not present then
  return {}
end

local M = {
  settings = {
    json = {
      schemas = schemastore.json.schemas({
        select = {
          '.eslintrc',
          'package.json',
          'prettierrc.json',
          'babelrc.json',
          'Build Info',
          'CircleCI config.yml',
          'Vercel',
          'VSCode Code Snippets',
          'GitHub Action',
          'GitHub Funding',
          'GitHub issue forms',
          'GitHub Issue Template configuration',
          'GitHub Workflow',
          'GitHub Workflow Template Properties',
          'GraphQL Config',
          'GraphQL Code Generator',
          'JSON-API',
          'jsconfig.json',
          'nodemon.json',
          '.postcssrc',
          '.pre-commit-config.yml',
          '.pre-commit-hooks.yml',
          '.stylelintrc',
          '.vsconfig',
          '.lintstagedrc',
          '.commitlintrc',
          '.yarnrc.yml',
        },
      }),
      validate = { enable = true },
    },
    -- setup = {
    --   commands = {
    --     Format = {
    --       function()
    --         vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
    --       end,
    --     },
    --   },
    -- },
  },
}

return M
