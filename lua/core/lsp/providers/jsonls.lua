local M = {
  settings = {
    json = {
      schemas = {
        {
          description = 'NPM configuration file',
          fileMatch = { 'package.json' },
          url = 'https://json.schemastore.org/package.json',
        },
        {
          description = 'TypeScript compiler configuration file',
          fileMatch = { 'tsconfig*.json' },
          url = 'https://json.schemastore.org/tsconfig.json',
        },
        {
          description = 'Prettier config',
          fileMatch = { '.prettierrc', '.prettierrc.json', 'prettier.config.json' },
          url = 'https://json.schemastore.org/prettierrc.json',
        },
        {
          description = 'ESLint config',
          fileMatch = { '.eslintrc', '.eslintrc.json' },
          url = 'https://json.schemastore.org/eslintrc.json',
        },
        {
          description = 'Babel configuration',
          fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
          url = 'https://json.schemastore.org/babelrc.json',
        },
        {
          description = 'Lerna config',
          fileMatch = { 'lerna.json' },
          url = 'https://json.schemastore.org/lerna.json',
        },
        {
          description = 'Vercel Now config',
          fileMatch = { 'now.json', 'vercel.json' },
          url = 'https://json.schemastore.org/now.json',
        },
        {
          description = 'Stylelint config',
          fileMatch = {
            '.stylelintrc',
            '.stylelintrc.json',
            'stylelint.config.json',
          },
          url = 'https://json.schemastore.org/stylelintrc',
        },
        {
          description = 'Json schema for properties json file for a GitHub Workflow template',
          fileMatch = {
            '.github/workflow-templates/**.properties.json',
          },
          url = 'https://json.schemastore.org/github-workflow-template-properties.json',
        },
        {
          description = 'JSON schema for Visual Studio component configuration files',
          fileMatch = {
            '*.vsconfig',
          },
          url = 'https://json.schemastore.org/vsconfig.json',
        },
      },
    },
    setup = {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
          end,
        },
      },
    },
  },
}

return M
