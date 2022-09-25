local present, luasnip = pcall(require, 'luasnip')

if present then
  local options = {
    history = true,
    updateevents = 'TextChanged,TextChangedI',
  }

  luasnip.config.set_config(options)

  require('luasnip.loaders.from_vscode').lazy_load({ paths = '~/.config/nvim/snippets' })
end
