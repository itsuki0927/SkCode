local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

telescope.setup({
	defaults = {
    initial_mode = "insert", -- telescope 启动模式: 'insert' | 'normal'
    selection_strategy = "reset", 
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.8, -- 宽度 80%
      prompt_position = "top",  -- prompt在顶部
      preview_cutoff = 120,  -- 预览区域
      horizontal = {mirror = false}, -- 不翻转result/prompt位置
      vertical = {mirror = false}
    },

--		winblend = 0,
    prompt_prefix = " ",
    -- selection_caret = " ",
    entry_prefix = "  ",
		path_display = { "smart" },
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },

    set_env = {['COLORTERM'] = 'truecolor'},

		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<M-p>"] = action_layout.toggle_preview,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,

				["<esc>"] = actions.close,
				["<C-[>"] = actions.close,

				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.complete_tag,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},

			n = {
				["<M-p>"] = action_layout.toggle_preview,

				["<esc>"] = actions.close,
				["<C-[>"] = actions.close,

				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,

				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["?"] = actions.which_key,
			},
		},
	},
})
