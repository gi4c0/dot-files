return {
    'dmtrKovalenko/fff.nvim',
    enabled = false,
    lazy = false,
    build = function()
        -- this will download prebuild binary or try to use existing rustup toolchain to build from source
        -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
        require("fff.download").download_binary()
    end,
    -- or if you are using nixos
    -- build = "nix run .#release",
    opts = { -- (optional)
        history = {
            enabled = true,
            db_path = vim.fn.stdpath('data') .. '/fff_queries',
            min_combo_count = 3, -- file will get a boost if it was selected 3 in a row times per specific query
            combo_boost_score_multiplier = 100, -- Score multiplier for combo matches
        },
        grep = {
            max_file_size = 10 * 1024 * 1024, -- Skip files larger than 10MB
            max_matches_per_file = 100, -- Maximum matches per file (set 0 to unlimited)
            smart_case = true, -- Case-insensitive unless query has uppercase
            time_budget_ms = 150, -- Max search time in ms per call (prevents UI freeze, 0 = no limit)
            modes = { 'plain', 'regex', 'fuzzy' }, -- Available grep modes and their cycling order
        },
        keymaps = {
            close = '<Esc>',
            select = '<CR>',
            select_split = '<C-s>',
            select_vsplit = '<C-v>',
            select_tab = '<C-t>',
            move_up = { '<C-k>', '<C-p>' },
            move_down = { '<C-j>', '<C-n>' },
            preview_scroll_up = '<C-u>',
            preview_scroll_down = '<C-d>',
            toggle_debug = '<F2>',
        },
        layout = {
            height = 0.8,
            width = 0.8,
            prompt_position = 'top', -- or 'top'
            preview_position = 'right', -- or 'left', 'right', 'top', 'bottom'
            preview_size = 0.5,
        },
        preview = {
            enabled = false,
        },
        debug = {
            enabled = true,     -- we expect your collaboration at least during the beta
            show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
        },
    },
    keys = {
        -- { "<leader>ff", function() require('fff').find_files() end, desc = 'FFFind files', },
        { "<C-p>", function() require('fff').find_files() end, desc = 'FFFind files', },
        -- {
        --     "<leader>/",
        --     function() require('fff').live_grep({
        --         grep = {
        --             modes = { 'fuzzy', 'plain' }
        --         }
        --     }) end,
        --     desc = 'Live fffuzy grep',
        -- },
        -- {
        --     "<leader>*",
        --     function() require('fff').live_grep({ query = vim.fn.expand("<cword>") }) end,
        --     desc = 'Search current word',
        -- },
    }
}
