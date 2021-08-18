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

    },
    pickers = {
      find_files = {
        previewer = false,
      },
      buffers = {
        -- theme = "dropdown",
        sort_lastused = true,
        previewer = false,
        mappings = {
          i = {
            ["<c-d>"] = actions.delete_buffer,
          },
          n = {
            ["<c-d>"] = actions.delete_buffer,
          }
        }
      }
    }
  }
EOF

nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>/ <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <C-Space> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').oldfiles()<cr>

nnoremap <leader>ghh <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>gcc <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>ghb <cmd>lua require('telescope.builtin').git_bcommits()<cr>
