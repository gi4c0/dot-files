return {
    "retran/meow.yarn.nvim",
    enabled = true,
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
        require("meow.yarn").setup({
            -- Your custom configuration goes here
        })
    end,
    keys = {
        {'<leader>cc', '<cmd>MeowYarn call callers<CR>', silent = true, desc = "(Code) Symbol Callers"}
    }
}
