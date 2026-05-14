return  {
    "mikavilpas/yazi.nvim",
    -- event = "VeryLazy",
    enabled = false,
    keys = {
        {"<leader>r", function() require("yazi").yazi() end, desc = "Open the file manager"},
        {"<leader>R", ':Yazi cwd<CR>', silent = true, desc = "Open the file manager in nvim's working directory"},
        {
          "<C-f>",
          function() require('user.libs.snacks-dirs').find_dirs(function(path) require("yazi").yazi(nil, path) end) end,
          desc = "Find directories"
        },
      },
      opts = {
        -- if you want to open yazi instead of netrw, see below for more info
        open_for_directories = true,

        -- enable these if you are using the latest version of yazi
        use_ya_for_events_reading = true,
        -- use_yazi_client_id_flag = true,
        keymaps = {
          open_file_in_vertical_split = '<c-v>',
          open_file_in_horizontal_split = '<c-s>',
          open_file_in_tab = '<c-t>',
          grep_in_directory = '<c-g>',
          replace_in_directory = '<c-x>',
          cycle_open_buffers = '<tab>',
        },
      },
    }

