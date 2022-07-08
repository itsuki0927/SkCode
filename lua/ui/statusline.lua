local modules = require('plugin-configs.statusline')
return {
  run = function()
    return table.concat({
      modules.mode(),
      modules.fileInfo(),
      modules.git(),

      '%=',
      modules.LSP_progress(),
      '%=',

      modules.LSP_Diagnostics(),
      modules.LSP_status() or '',
      modules.cwd(),
      modules.cursor_position(),
    })
  end,
}
