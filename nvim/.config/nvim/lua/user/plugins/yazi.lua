return  {
    "mikavilpas/yazi.nvim",
    -- event = "VeryLazy",
    enabled = true,
    keys = {
        {"<leader>r", ':Yazi<CR>', desc = "Open the file manager"},
        {"<leader>R", ':Yazi cwd<CR>', silent = true, desc = "Open the file manager in nvim's working directory"},
        {
            "<C-f>",
            function() require('user.libs.snacks-dirs').find_dirs(function(path) vim.cmd('Yazi ' .. path) end) end,
            desc = "Find directories"
        },
    },
    opts = {
        -- if you want to open yazi instead of netrw, see below for more info
        open_for_directories = true,
        floating_window_scaling_factor = 0.75,

        keymaps = {
            show_help = "<f1>",
            open_file_in_vertical_split = '<c-v>',
            open_file_in_horizontal_split = '<c-s>',
            open_file_in_tab = '<c-t>',
            grep_in_directory = '<c-g>',
            replace_in_directory = '<c-x>',
            cycle_open_buffers = '<tab>',
        },
    },
}

