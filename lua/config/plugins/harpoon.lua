return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup({})

      local map = vim.keymap.set

      harpoon:extend({
        UI_CREATE = function(cx)
          map('n', '<C-v>', function()
            harpoon.ui:select_menu_item({ vsplit = true })
          end, { buffer = cx.bufnr })

          map('n', '<C-x>', function()
            harpoon.ui:select_menu_item({ split = true })
          end, { buffer = cx.bufnr })
        end,
      })

      local function toggle_telescope(harpoon_files)
        local finder = function()
          local paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(paths, item.value)
          end

          return require('telescope.finders').new_table({
            results = paths,
          })
        end

        -- 创建新的 picker 并保存实例
        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = finder(),
            previewer = false,
            sorter = require('telescope.config').values.generic_sorter({}),
            layout_config = {
              height = 0.4,
              width = 0.5,
              prompt_position = 'top',
              preview_cutoff = 120,
            },
            attach_mappings = function(prompt_bufnr, local_map)
              local_map('i', '<C-d>', function()
                local state = require('telescope.actions.state')
                local selected_entry = state.get_selected_entry()
                local current_picker = state.get_current_picker(prompt_bufnr)

                table.remove(harpoon_files.items, selected_entry.index)
                current_picker:refresh(finder())
              end)
              return true
            end,
          })
          :find()
      end

      map('n', '<leader>a', function()
        harpoon:list():add()
      end)

      map('n', '<C-e>', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'Open harpoon window' })

      map('n', '<C-f>', function()
        harpoon:list():select(1)
      end)
      map('n', '<C-p>', function()
        harpoon:list():select(2)
      end)
      map('n', '<C-y>', function()
        harpoon:list():select(3)
      end)
      map('n', '<C-t>', function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      map('n', '<C-S-P>', function()
        harpoon:list():prev()
      end)
      map('n', '<C-S-N>', function()
        harpoon:list():next()
      end)
    end,
  },
}
