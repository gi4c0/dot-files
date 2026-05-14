return {
    "XXiaoA/atone.nvim",
    cmd = "Atone",
    ---@module "atone"
    ---@type AtoneConfig
    opts = {},
    keys = {
        {'<leader>u', ':Atone toggle<CR>', silent = true, desc = 'Undotree'}
    },
}
