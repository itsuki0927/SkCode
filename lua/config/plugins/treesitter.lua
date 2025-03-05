pcall(function()
  dofile(vim.g.base46_cache .. 'syntax')
  dofile(vim.g.base46_cache .. 'treesitter')
end)

return {
  {
    'nvim-treesitter/nvim-treesitter',
    cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        modules = {},
        ensure_installed = {
          'bash',
          'c',
          'c_sharp',
          'comment',
          'cpp',
          'css',
          'diff',
          'dockerfile',
          'dot',
          'fish',
          'git_rebase',
          'gitcommit',
          'gitignore',
          'go',
          'graphql',
          'html',
          'markdown',
          'pug',
          'prisma',
          'lua',
          'vim',
          'help',
          'java',
          'javascript',
          'typescript',
          'scss',
          'tsx',
          'vue',
          'jsdoc',
          'json',
          'json5',
          'regex',
          'ruby',
          'rust',
          'sql',
          'yaml',
          'git_config',
          'jsdoc',
          'make',
          'toml',
          'vimdoc',
        },
        ignore_install = { 'help' },
        sync_install = false,
        auto_install = true,
        -- autotag = {
        --   enable = true,
        -- },
        indent = { enable = true, disable = { 'yaml' } },
        autopairs = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn', -- set to `false` to disable one of the mappings
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        highlight = {
          enable = true,
          disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
}
