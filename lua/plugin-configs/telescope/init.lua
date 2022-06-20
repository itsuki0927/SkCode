local present, telescope = pcall(require, 'telescope')

local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')
local action_state = require('telescope.actions.state')

local telescope_custom_actions = {}

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = #picker:get_multi_selection()
  if not num_selections or num_selections <= 1 then
    actions.add_selection(prompt_bufnr)
  end
  actions.send_selected_to_qflist(prompt_bufnr)
  vim.cmd('cfdo ' .. open_cmd)
end

function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
  telescope_custom_actions._multiopen(prompt_bufnr, 'vsplit')
end

function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
  telescope_custom_actions._multiopen(prompt_bufnr, 'split')
end

function telescope_custom_actions.multi_selection_open_tab(prompt_bufnr)
  telescope_custom_actions._multiopen(prompt_bufnr, 'tabe')
end

function telescope_custom_actions.multi_selection_open(prompt_bufnr)
  telescope_custom_actions._multiopen(prompt_bufnr, 'edit')
end

if present then
  require('base46').load_highlight('telescope')
  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
      },
      prompt_prefix = ' ',
      selection_caret = '  ',
      entry_prefix = '  ',
      initial_mode = 'insert',
      selection_strategy = 'reset',
      sorting_strategy = 'ascending',
      layout_strategy = 'horizontal',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = require('telescope.sorters').get_fuzzy_file,
      file_ignore_patterns = { 'node_modules' },
      generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
      path_display = { 'truncate' },
      winblend = 0,
      border = {},
      borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      color_devicons = true,
      use_less = true,
      set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,

      mappings = {
        i = {
          ['<C-n>'] = actions.cycle_history_next,
          ['<C-p>'] = actions.cycle_history_prev,
          ['<M-p>'] = action_layout.toggle_preview,

          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,

          ['<esc>'] = actions.close,
          ['<C-[>'] = actions.close,

          ['<CR>'] = telescope_custom_actions.multi_selection_open,
          ['<C-x>'] = telescope_custom_actions.multi_selection_open_split,
          ['<C-v>'] = telescope_custom_actions.multi_selection_open_vsplit,
          ['<C-t>'] = telescope_custom_actions.multi_selection_open_tab,

          ['<C-u>'] = actions.preview_scrolling_up,
          ['<C-d>'] = actions.preview_scrolling_down,

          ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
          ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
          ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
          ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          ['<C-l>'] = actions.complete_tag,
          ['<C-_>'] = actions.which_key, -- keys from pressing <C-/>
        },

        n = {
          ['<M-p>'] = action_layout.toggle_preview,

          ['<esc>'] = actions.close,
          ['<C-[>'] = actions.close,

          ['<CR>'] = telescope_custom_actions.multi_selection_open,
          ['<C-x>'] = telescope_custom_actions.multi_selection_open_split,
          ['<C-v>'] = telescope_custom_actions.multi_selection_open_vsplit,
          ['<C-t>'] = telescope_custom_actions.multi_selection_open_tab,

          ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
          ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
          ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
          ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

          ['j'] = actions.move_selection_next,
          ['k'] = actions.move_selection_previous,
          ['H'] = actions.move_to_top,
          ['M'] = actions.move_to_middle,
          ['L'] = actions.move_to_bottom,

          ['gg'] = actions.move_to_top,
          ['G'] = actions.move_to_bottom,

          ['<C-u>'] = actions.preview_scrolling_up,
          ['<C-d>'] = actions.preview_scrolling_down,

          ['?'] = actions.which_key,
        },
      },
    },
    pickers = {
      find_files = {
        previewer = false,
      },
    },
  })

  local extensions = { 'themes', 'terms' }

  pcall(function()
    for _, ext in ipairs(extensions) do
      telescope.load_extension(ext)
    end
  end)
end
