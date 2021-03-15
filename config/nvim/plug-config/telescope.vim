lua << EOF
  local actions = require('telescope.actions')
  require('telescope').setup{
    defaults = {
      file_sorter = require('telescope.sorters').get_fzy_sorter,
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        }
      },

      extensions = {
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        }
      }
    }
  }

  require('telescope').load_extension('fzy_native')
EOF

nnoremap <C-p> <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>/ <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <C-Space> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').oldfiles()<cr>
