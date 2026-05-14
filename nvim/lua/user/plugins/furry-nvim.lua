return {
    "litvinov-git/furry.nvim",
    enabled = false,
    dependencies = { "nvim-mini/mini.fuzzy" },
    config = function()
        require("furry").setup({
            -- Defaults:
            -- highlight_matches = true,
            -- highlight_current = true,
            -- max_score = 1800,
            -- progressive = true,
            -- sort_by = "lines",
            -- on_empty = "dump",
            -- on_space = "repeat_last",
            -- on_change = "dump",
            -- on_buf_enter = "repeat_last",
        })
    end,

    keys = {
        {'?', ':FurryGlobal<CR>', silent = true, desc = "Fuzzy search (file)", noremap = true},
        {'<C-l>', ':Furry<CR>', silent = true, desc = "Furry Jump", noremap = true},
    }
}
