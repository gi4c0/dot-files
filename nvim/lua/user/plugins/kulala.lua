return {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest'},
    build = 'brew install jq',
    opts = {
        global_keymaps_prefix = "<leader>k",
        global_keymaps = true,
        ui = {
            display_mode = "float",
            win_opts = {
                wo = {
                    foldmethod = 'manual'
                }
            }
        },
        kulala_keymaps = {
            ["Next response"] = { "]k", function() require("kulala.ui").show_next() end, },
            ["Previous response"] = { "[k", function() require("kulala.ui").show_previous() end, },
        }
    }
}
