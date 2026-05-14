return {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    enabled = true,
    config = function()
        local actions = require('telescope.actions')
        local smart_open_actions = require("smart-open.actions")

        require("telescope").setup {
            defaults = {
                layout_strategy = 'horizontal',
                layout_config = { height = 0.85, width = 0.65, prompt_position = "top" },
                sorting_strategy = "ascending",
                respect_gitignore = false,
                file_ignore_patterns = {"^.git/", "dist/"},
                file_sorter = require('telescope.sorters').get_fzy_sorter,
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-p>"] = require('telescope.actions.layout').toggle_preview,
                    },
                },

            },

            extensions = {
                smart_open = {
                    theme = 'dropdown',
                    cwd_only = true,
                    mappings = {
                        i = {
                            ["<C-w>"] = function ()
                                vim.api.nvim_input "<c-s-w>"
                            end,
                            ["<C-x>"] = smart_open_actions.delete_buffer
                        },
                    },
                },
            }
        }
        require("telescope").load_extension("smart_open")
    end,
    dependencies = {
        'nvim-telescope/telescope.nvim',
        "kkharji/sqlite.lua",
        -- Only required if using match_algorithm fzf
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
        { "nvim-telescope/telescope-fzy-native.nvim" },
    },

    keys = {
        { '<C-p>', function() require("telescope").extensions.smart_open.smart_open({ previewer = false, cwd_only = true,  }) end, silent = true, desc = 'Smart Open' }
        -- { '<leader>ff', function() require("telescope").extensions.smart_open.smart_open({ previewer = false, cwd_only = true,  }) end, silent = true, desc = 'Smart Open' }
    }
}
