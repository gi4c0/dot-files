return {
    'kremovtort/tabterm.nvim',
    lazy = false,
    config = {
        ui = {
            float = {
                width = 0.80,
                height = 0.80,
            },
        },
    },
    keys = {
        {'<C-t><C-t>', function() require('tabterm').toggle() end, desc = "Terminal toggle", mode = {'n', 't'}},
        -- { '<C-t><C-d>',  '<cmd>Tabterm delete<CR>',  mode = { 't', 'n' } },
        { '<C-t>c',  '<cmd>Tabterm shell<CR>',  mode = { 't', 'n' } },
        { '<C-t><C-r>',  '<cmd>Tabterm rename<CR>',  mode = { 't', 'n' } },
        { '<C-t>a',  '<cmd>Tabterm command claude<CR>',  mode = { 't', 'n' } },
        {
            '<C-t><C-f>',
            function ()
                local fname = vim.fn.expand('%:t')
                vim.cmd('Tabterm command yarn test ' .. fname)
            end,
            desc = "wTa fuck"
        },
    }
}

-- return {
--     'akinsho/toggleterm.nvim',
--     version = "*",
--     opts = {
--         direction = 'float',
--     },
--     keys = {
--         {
--             '<leader>tf',
--             function ()
--                 local fname = vim.fn.expand('%:t')
--                 vim.cmd('TermExec cmd="yarn test ' .. fname .. '"')
--             end,
--             desc = "test file"
--         },
--         -- {'<leader>td', '<cmd>q!<CR>', mode = {'t', 'n'}, desc = "Terminal Delete"},
--         {'<C-t><C-t>', '<cmd>ToggleTerm<CR>', desc = "Terminal toggle", mode = {'n', 't'}},
--         { '<C-t><C-x>',  '<cmd>q!<CR>',  mode = { 't', 'n' } },
--         { '<C-t><C-d>',  '<cmd>q!<CR>',  mode = { 't', 'n' } },
--         {
--             '<C-t><C-f>',
--             function ()
--                 local fname = vim.fn.expand('%:t')
--                 vim.cmd('TermExec cmd="yarn test ' .. fname .. '"')
--             end,
--             desc = "wTa fuck"
--         },
--     }
-- }


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
