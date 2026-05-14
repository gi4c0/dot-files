return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    enabled = false,
    config = true,
    keys = {
        {"<leader><space>", function() require('harpoon'):list():add() end, noremap = true, silent = true, desc = "Set harpoon mark"},
        {"<C-t>", function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end, noremap = true, silent = true },

        {"<leader>1", function() require('harpoon'):list():select(1) end, noremap = true, silent = true, desc = "Set mark 1"},
        {"<leader>2", function() require('harpoon'):list():select(2) end, noremap = true, silent = true, desc = "Set mark 2"},
        {"<leader>3", function() require('harpoon'):list():select(3) end, noremap = true, silent = true, desc = "Set mark 3"},
        {"<leader>4", function() require('harpoon'):list():select(4) end, noremap = true, silent = true, desc = "Set mark 4"},
        {"<leader>5", function() require('harpoon'):list():select(5) end, noremap = true, silent = true, desc = "Set mark 5"},
        {"<leader>6", function() require('harpoon'):list():select(6) end, noremap = true, silent = true, desc = "Set mark 6"},

        -- Toggle previous & next buffers stored within Harpoon list
        { "[[", function() require('harpoon'):list():prev() end, desc = "Previous harpoon mark" },
        { "]]", function() require('harpoon'):list():next() end, desc = "Next harpoon mark" }
    }
}
