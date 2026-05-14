return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        direction = 'float',
    },
    keys = {
        {
            '<leader>tf',
            function ()
                local fname = vim.fn.expand('%:t')
                vim.cmd('TermExec cmd="yarn test ' .. fname .. '"')
            end,
            desc = "test file"
        },
        -- {'<leader>td', '<cmd>q!<CR>', mode = {'t', 'n'}, desc = "Terminal Delete"},
        {'<C-t><C-t>', '<cmd>ToggleTerm<CR>', desc = "Terminal toggle", mode = {'n', 't'}},
        { '<C-t><C-x>',  '<cmd>q!<CR>',  mode = { 't', 'n' } },
        { '<C-t><C-d>',  '<cmd>q!<CR>',  mode = { 't', 'n' } },
        {
            '<C-t><C-f>',
            function ()
                local fname = vim.fn.expand('%:t')
                vim.cmd('TermExec cmd="yarn test ' .. fname .. '"')
            end,
            desc = "wTa fuck"
        },
    }
}


-- return {
--     "wr9dg17/essential-term.nvim",
--     lazy = false,
--     enabled = true,
--     dependencies = { "MunifTanjim/nui.nvim" },
--     config = function()
--         require("essential-term").setup({
--             display_mode = "float", -- or "vertical" or "float"
--             size = 70,                   -- percentage of editor height/width
--         })
--     end,
--     keys = {
--         { "<C-\\>", "<cmd>EssentialTermToggle<cr>", mode = { "n", "t" } },
--         { "<C-t>",  "<cmd>EssentialTermNew<cr>",    mode = { "n", "t" } },
--         { "<C-x>",  "<cmd>EssentialTermClose<cr>",  mode = { "n", "t" } },
--         { "<C-h>",  "<cmd>EssentialTermPrev<cr>",   mode = { "t" } },
--         { "<C-l>",  "<cmd>EssentialTermNext<cr>",   mode = { "t" } },
--         {'<leader>tf', function() require('essential-term').new('yarn test') end}
--     },
--
-- }
