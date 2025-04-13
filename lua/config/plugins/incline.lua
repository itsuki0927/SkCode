return {
  {
    'b0o/incline.nvim',
    opts = {},
    -- Optional: Lazy load Incline
    event = 'VeryLazy',
    config = function()
      require('incline').setup({
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 0 },
        },
        render = function(props)
          local buf_name = vim.api.nvim_buf_get_name(props.buf)
          -- 处理未命名缓冲区
          if buf_name == '' then
            return { { '[No Name]', guifg = '#666666' } }
          end

          local icon, color = require('nvim-web-devicons').get_icon_color(buf_name)
          -- 获取相对路径并分割路径
          local relative_path = vim.fn.fnamemodify(buf_name, ':~:.')
          local filename = vim.fn.fnamemodify(relative_path, ':t')
          local parent_dir = vim.fn.fnamemodify(relative_path, ':h')
          local segments = {}

          table.insert(segments, { ' ' })

          -- 添加文件图标
          if icon and #icon > 0 then
            table.insert(segments, { icon, guifg = color })
            table.insert(segments, { ' ' })
          end

          -- 提取最后一个父级目录
          local dir_parts = vim.split(parent_dir, '/', { plain = true })
          local display_dir = (#dir_parts > 0) and dir_parts[#dir_parts] or ''

          -- 添加父级目录（非当前目录时显示）
          if display_dir ~= '' then
            table.insert(segments, { display_dir .. '/', guifg = '#888888' }) -- 灰色显示父目录
          end

          -- 添加文件名
          table.insert(segments, { filename })
          table.insert(segments, { ' ' })

          return segments
        end,
      })
    end,
  },
}
