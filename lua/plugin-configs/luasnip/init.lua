local present, luasnip = pcall(require, 'luasnip')

if present then
  luasnip.config.set_config({
    history = true,
    updateevents = 'TextChanged,TextChangedI',
  })

  require('luasnip/loaders/from_vscode').load({ paths = {} })
  require('luasnip/loaders/from_vscode').load()
end
