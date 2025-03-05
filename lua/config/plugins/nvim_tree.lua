-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

return {
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      dofile(vim.g.base46_cache .. 'nvimtree')
      local api = require('nvim-tree.api')

      local function on_attach(bufnr)
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        -- 使用默认的mapping
        api.config.mappings.default_on_attach(bufnr)

        -- 添加自定义的mapping
        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', 'V', api.node.open.horizontal, opts('Open: Horizontal Split'))
      end

      -- 创建文件后, 自动编辑该文件
      api.events.subscribe(api.events.Event.FileCreated, function(file)
        vim.cmd('edit ' .. file.fname)
      end)

      require('nvim-tree').setup({
        filters = { dotfiles = false },
        disable_netrw = true,
        hijack_cursor = true,
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        on_attach = on_attach,
        view = {
          -- float = {
          --   enable = true,
          --   open_win_config = function()
          --     local screen_w = vim.opt.columns:get()
          --     local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          --     local w_h = 70
          --     local s_h = 42
          --     local center_x = (screen_w - w_h) / 2
          --     local center_y = ((vim.opt.lines:get() - s_h) / 5) - vim.opt.cmdheight:get()
          --     return {
          --       border = 'single',
          --       relative = 'editor',
          --       row = center_y,
          --       col = center_x,
          --       width = w_h,
          --       height = s_h,
          --     }
          --   end,
          -- },
          width = 30,
          preserve_window_proportions = true,
        },
        renderer = {
          root_folder_label = false,
          highlight_git = true,
          indent_markers = { enable = true },
          icons = {
            glyphs = {
              default = '󰈚',
              folder = {
                default = '',
                empty = '',
                empty_open = '',
                open = '',
                symlink = '',
              },
              git = {
                unstaged = '',
                staged = '',
                unmerged = '',
                renamed = '',
                untracked = '',
                deleted = '',
                ignored = '󰴲',
              },
            },
          },
        },
      })
    end,
  },
}
