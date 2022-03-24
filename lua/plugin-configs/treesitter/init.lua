local present, treesitter = pcall(require, 'nvim-treesitter.configs')

if present then
  treesitter.setup({
    ensure_installed = 'maintained',
    sync_install = false,
    ignore_install = { '' },
    highlight = {
      enable = true,
      disable = { '' },
      additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { 'yaml' } },
    autopairs = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  })
end
