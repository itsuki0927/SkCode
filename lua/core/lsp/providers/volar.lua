local function get_ts_server_path(root_dir)
  local util = require('lspconfig.util')
  local project_root = util.find_node_modules_ancestor(root_dir)

  local local_tsserverlib = project_root ~= nil
    and util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js')
  local global_tsserverlib = '~/.npm/lib/node_modules/typescript/lib/tsserverlibrary.js'

  if local_tsserverlib and util.path.exists(local_tsserverlib) then
    return local_tsserverlib
  else
    return global_tsserverlib
  end
end

return {
  config = {
    on_new_config = function(new_config, new_root_dir)
      new_config.init_options.typescript.serverPath = get_ts_server_path(new_root_dir)
    end,
  },
}
