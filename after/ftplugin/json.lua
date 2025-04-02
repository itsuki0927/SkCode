vim.keymap.set('n', 'o', require('config.utils.json').add_trailing_comma_if_needed, { buffer = true, expr = true })
