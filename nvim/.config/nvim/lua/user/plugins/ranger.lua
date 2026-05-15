return {
    'kevinhwang91/rnvimr',
    lazy = false,
    init = function()
        vim.g.rnvimr_enable_ex = true
        vim.g.rnvimr_enable_picker = true
        vim.g.rnvimr_hide_gitignore = false

        vim.g.rnvimr_action = {

            ['<C-v>'] = 'NvimEdit vsplit',
            ['<C-s>'] = 'NvimEdit split'
        }
        vim.g.python3_host_prog = vim.fn.expand('~/.local/pipx/venvs/pynvim/bin/python')

        vim.g.rnvimr_layout = {
            relative = 'editor',
            width = math.floor(0.75 * vim.o.columns), -- 90% of screen width
            height = math.floor(0.75 * vim.o.lines),  -- 90% of screen height
            col = math.floor(0.15 * vim.o.columns),  -- 5% offset to center horizontally
            row = math.floor(0.15 * vim.o.lines),    -- 5% offset to center vertically
            style = 'minimal'
        }
    end,

    keys = {
        {'<leader>r', function() vim.cmd 'RnvimrToggle' end, silent = true, desc = 'Ranger'},
        { "<C-f>", function() require('user.libs.snacks-dirs').find_dirs(function(path) vim.cmd('e ' .. path) end) end, desc = "Find directories (ranger)" },
        {'<leader>R', function() vim.cmd 'e .' end, desc = 'Ranger Root'}
    }
}
